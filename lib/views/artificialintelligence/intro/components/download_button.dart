import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/colors.dart';


class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Coming soon...')));
        launchUrl(Uri.parse('https://drive.google.com/file/d/1KqltoGi_tPx53JC9naAvaCjBcCpXjo1y/view?usp=sharing'));
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: defaultPadding/1.5,horizontal: defaultPadding*2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
            boxShadow:const [
              BoxShadow(color: Colors.red,offset: Offset(0, 1),blurRadius: 5),
              BoxShadow(color: Colors.blue,offset: Offset(0, -1),blurRadius: 5),

            ],
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade900,
                Colors.pink,

              ]),
        ),
        child: Row(
          children: [
            Text(
              'Download APK',
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: defaultPadding/3,),
            const Icon(FontAwesomeIcons.download,color: Colors.white70,size: 15,)

          ],
        ),
      ),
    );
  }
}