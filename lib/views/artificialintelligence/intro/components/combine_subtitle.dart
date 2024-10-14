import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_base/views/artificialintelligence/intro/components/subtitle_text.dart';
import '../../../../view model/responsive.dart';

class CombineSubtitleText extends StatelessWidget {
  const CombineSubtitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const Responsive(
          //   desktop: AnimatedSubtitle(
          //       start: 30, end: 40, text: 'Facial Recognition '),
          //   largeMobile: AnimatedSubtitle(
          //       start: 30, end: 25, text: 'Facial Recognition '),
          //   mobile: AnimatedSubtitle(
          //       start: 25, end: 20, text: 'Facial Recognition '),
          //   tablet: AnimatedSubtitle(
          //       start: 40, end: 30, text: 'Facial Recognition '),
          // ),
          (kIsWeb && Responsive.isLargeMobile(context)
              ? const Responsive(
            desktop: AnimatedSubtitleText(
                start: 30,
                end: 40,
                text: 'Facial Recognition Application ',
                gradient: true),
            largeMobile: AnimatedSubtitleText(
                start: 30,
                end: 25,
                text: 'Facial Recognition Application ',
                gradient: true),
            mobile: AnimatedSubtitleText(
                start: 25,
                end: 20,
                text: 'Facial Recognition Application ',
                gradient: true),
            tablet: AnimatedSubtitleText(
                start: 40,
                end: 30,
                text: 'Facial Recognition Application ',
                gradient: true),
          )
              : ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(colors: [
                Colors.pink,
                Colors.blue,
              ]).createShader(bounds);
            },
            child: const Responsive(
              desktop: AnimatedSubtitleText(
                  start: 30,
                  end: 40,
                  text: 'Facial Recognition Application ',
                  gradient: false),
              largeMobile: AnimatedSubtitleText(
                  start: 30,
                  end: 25,
                  text: 'Facial Recognition Application ',
                  gradient: false),
              mobile: AnimatedSubtitleText(
                  start: 25,
                  end: 20,
                  text: 'Facial Recognition Application ',
                  gradient: true),
              tablet: AnimatedSubtitleText(
                  start: 40,
                  end: 30,
                  text: 'Facial Recognition Application ',
                  gradient: false),
            ),
          ))
        ],
      ),
    );
  }
}
