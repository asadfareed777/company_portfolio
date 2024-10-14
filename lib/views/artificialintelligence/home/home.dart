import 'package:flutter/material.dart';

import '../intro/introduction.dart';
import '../main/main_view.dart';

class HomePageAIModule extends StatelessWidget {
  const HomePageAIModule({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MainView(pages: [
      Introduction(),
     /* ProjectsView(),
      Certifications(),*/
    ]);
  }
}
