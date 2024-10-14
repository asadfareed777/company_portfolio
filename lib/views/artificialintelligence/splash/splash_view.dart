import 'dart:async';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../home/home.dart';
import '../intro/components/animated_texts_componenets.dart';
import 'componenets/animated_loading_text.dart';
class SplashViewAIModule extends StatefulWidget {
  const SplashViewAIModule({super.key});
  @override
  State<SplashViewAIModule> createState() => _SplashViewAIModuleState();
}
class _SplashViewAIModuleState extends State<SplashViewAIModule> {
  @override
  void initState() {
    // // TODO: implement initState
    // super.initState();
    // Timer(const Duration(seconds: 3), () {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),));
    // });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedImageContainer(width: 100,height: 100,),
            SizedBox(height: defaultPadding,),
            AnimatedLoadingText(),
          ],
        ),
      ),
    );
  }
}
