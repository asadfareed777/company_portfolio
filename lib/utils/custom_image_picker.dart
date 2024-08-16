import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart' as path_provider;

var pickedImagePath = StateProvider<String>((ref) {
  return ""; // Initialize with an empty string or null
});

XFile? imageFile;

enum CompressionLevel {
  low,   // 300 KB
  medium, // 1 MB
  high,  // 5 MB
}

extension CompressionSize on CompressionLevel {
  int get targetSize {
    switch (this) {
      case CompressionLevel.low:
        return 300;
      case CompressionLevel.medium:
        return 1024; // 1 MB in KB
      case CompressionLevel.high:
        return 5120; // 5 MB in KB
    }
  }
}

class CustomImagePicker {
  final picker = ImagePicker();
  Future<void> getImage({
    required BuildContext context,
    bool isSourceCamera = false,
    required String type,
    bool isNeedTimeStamp= false,
    bool isCompressionRequired = false,
    CompressionLevel? compressionLevel,
    WidgetRef? ref}) async {
    final pickedFile = await ImagePicker().pickImage(
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 80,
        source: isSourceCamera == true ? ImageSource.gallery : ImageSource.camera);
    if (pickedFile != null) {
      if(isCompressionRequired){
        log('compressing....');
        final XFile? compressedImage = await _compressImage(File(pickedFile.path), compressionLevel);
        if (compressedImage != null) {
          if(isNeedTimeStamp){
            File? processedImageFile = await _addTimeStampToImage(File(pickedFile.path));
            imageFile = XFile((processedImageFile?.path).toString());
            ref?.read(pickedImagePath.notifier).state = (imageFile?.path).toString();
          }else{
            imageFile = XFile((compressedImage.path).toString());
            ref?.read(pickedImagePath.notifier).state = (imageFile?.path).toString();
          }
        }
      }else{
        log('without compressing....');
        if(isNeedTimeStamp){
          File? processedImageFile = await _addTimeStampToImage(File(pickedFile.path));
          imageFile = XFile((processedImageFile?.path).toString());
          ref?.read(pickedImagePath.notifier).state = (imageFile?.path).toString();
        }else{
          imageFile = XFile((pickedFile.path).toString());
          ref?.read(pickedImagePath.notifier).state = (imageFile?.path).toString();
        }
      }
    }
  }

  Future<XFile?> _compressImage(File imageFile, CompressionLevel? level,{int quality = 90}) async {
    log('I am in compressed image function');
    final tempDir = await Directory.systemTemp.createTemp('images');
    final tempFilePath = '${tempDir.path}/compressed_image.jpg';
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      tempFilePath,
      quality: quality,
    );

    final compressedBytes = await compressedFile!.readAsBytes();
    final compressedSizeInKB = compressedBytes.length / 1024;
    log('compressed file size in kb:::${compressedSizeInKB.toString()}');

    if (compressedSizeInKB <= level!.targetSize) {
      // If the compressed file size is within the target size or the quality is too low, return the compressed file
      return XFile(compressedFile.path);
    } else {
      // Recursively compress the image with lower quality until the target size is reached
      return _compressImage(imageFile, level, quality: quality - 10);
    }
  }

  double getFileSizeInKB(File file) {
    int bytes = file.lengthSync();
    double kilobytes = bytes / 1024;
    return kilobytes;
  }

  Future<File?> _addTimeStampToImage(File imageFile) async {
    // Read bytes from the image file
    List<int> bytes = await imageFile.readAsBytes();
    // Decode the image
    img.Image? image = img.decodeImage(bytes);
    if (image == null) return null;

    // Add timestamp
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final formattedDate = formatter.format(now);
    img.drawString(image, img.arial_24, 10, 10, formattedDate);

    List<int> compressedBytes = img.encodeJpg(image, quality: 50);

    // Save the modified image
    final processedImageFile = File('${imageFile.path}_timestamped.jpg');
    await processedImageFile.writeAsBytes(compressedBytes);

    return processedImageFile;
  }
}
