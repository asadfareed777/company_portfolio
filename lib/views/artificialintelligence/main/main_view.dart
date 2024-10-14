import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../utils/colors.dart';
import '../../../utils/image_assets.dart';
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
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveBreakpoints.of(context)
                                .largerOrEqualTo(DESKTOP)
                            ? 50
                            : 15,
                        vertical: 10),
                    child: Image.asset(
                      logoImageInvertedTechnologyWhite,
                      height:
                          (ResponsiveBreakpoints.of(context).screenWidth < 750)
                              ? 50
                              : 60,
                      width:
                          (ResponsiveBreakpoints.of(context).screenWidth < 750)
                              ? 100
                              : 132,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                kIsWeb && !Responsive.isLargeMobile(context)
                    ? const SizedBox(
                        height: defaultPadding * 2,
                      )
                    : const SizedBox(
                        height: defaultPadding / 2,
                      ),
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
                if (Responsive.isLargeMobile(context))
                  const Row(
                    children: [Spacer(), NavigationButtonList(), Spacer()],
                  ),
                Expanded(
                  flex: 9,
                  child: PageView(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: [...pages],
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
