import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../utils/colors.dart';
import '../../../view model/controller.dart';
import '../../../view model/responsive.dart';
import 'components/drawer/drawer.dart';
import 'components/navigation_bar.dart';
import 'components/navigation_button_list.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MainView extends StatelessWidget {
   const MainView({super.key, required this.pages});
  final List<Widget> pages;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Center(
        child: Stack(
          children: [
          Image.asset(
          'assets/images/img_ai_new.PNG',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
            ).animate().fadeIn(duration: 300.ms),
            Column(
              children: [
                kIsWeb && !Responsive.isLargeMobile(context) ? const SizedBox(height:defaultPadding*2,) : const SizedBox(height:defaultPadding/2,),
                const Visibility(
                  visible: false,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: SizedBox(
                    height: 80,
                    child: TopNavigationBar(),
                  ),
                ),
                if(Responsive.isLargeMobile(context))  const Row(children: [Spacer(),NavigationButtonList(),Spacer()],),
                Expanded(
                  flex: 9,
                  child: PageView(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: [
                      ...pages
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}








