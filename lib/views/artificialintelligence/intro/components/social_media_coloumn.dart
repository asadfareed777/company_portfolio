import 'package:flutter/material.dart';
import 'package:flutter_base/views/artificialintelligence/intro/components/social_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaIconColumn extends StatelessWidget {
  const SocialMediaIconColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialMediaIcon(icon: 'assets/images/img_facebook.png',onTap: ()=>launchUrl(Uri.parse('https://www.facebook.com/invertedtec'))),
        SocialMediaIcon(icon: 'assets/images/img_youtube.png',onTap: () => launchUrl(Uri.parse('https://www.youtube.com/@invertedtechnology')),),
        SocialMediaIcon(icon: 'assets/images/img_x.png',onTap: ()=>launchUrl(Uri.parse('https://x.com/invertedtec'))),
        // const SocialMediaIcon(icon: 'assets/icons/linkedin.svg'),
      ],
    );
  }
}
