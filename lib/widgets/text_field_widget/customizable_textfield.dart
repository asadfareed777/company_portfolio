import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomizableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final Function(String) onChanged;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color focusedIconColor;
  final Color unfocusedIconColor;
  final bool hideText;
  VoidCallback? onSuffixIconPressed;
  final bool readOnly;
  Widget? prefixWidget;
  Widget? suffixWidget;
  TextInputType? textInputType;
  Function(String)? onFieldSubmit;
  EdgeInsetsGeometry? prefixPadding;
  EdgeInsetsGeometry? suffixPadding;
  List<TextInputFormatter>? inputFormatters;
  int? maxLines;

  CustomizableTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.focusNode,
    required this.validator,
    required this.onChanged,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.focusedIconColor,
    required this.unfocusedIconColor,
    required this.hideText,
    this.onSuffixIconPressed,
    this.readOnly = false,
    this.prefixWidget,
    this.suffixWidget,
    this.textInputType,
    this.onFieldSubmit,
    this.prefixPadding,
    this.suffixPadding,
    this.inputFormatters,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: hideText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: colorPrimary13.withOpacity(0.50),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: colorPrimary13.withOpacity(0.50),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: headingColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        errorStyle: GoogleFonts.poppins(
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 0,
                fontSize: 16,
              ),
        ),
        prefixIcon: prefixWidget != null
            ? Container(
                padding: prefixPadding ??
                    EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                      left: 20,
                      right: 10,
                    ),
                child: prefixWidget)
            : prefixIcon == null
                ? null
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Icon(
                      prefixIcon,
                      color: (focusNode.hasFocus) ? focusedIconColor : unfocusedIconColor,
                    ),
                  ),
        suffixIcon: (suffixWidget != null)
            ? Container(
                padding: suffixPadding ??
                    EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                      left: 20,
                      right: 10,
                    ),
                child: suffixWidget,
              )
            : suffixIcon == null
                ? null
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: InkWell(
                      onTap: onSuffixIconPressed,
                      child: Icon(
                        suffixIcon,
                        color: unfocusedIconColor,
                      ),
                    ),
                  ),
        filled: true,
        fillColor: (focusNode.hasFocus) ? Colors.transparent : Colors.transparent,
        focusColor: Colors.black,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
        ),
      ),
      maxLines: maxLines ?? 1,
      cursorWidth: 2.w,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmit,
      cursorColor: primaryColor,
      style: GoogleFonts.poppins(
        textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
      ),
    );
  }
}
