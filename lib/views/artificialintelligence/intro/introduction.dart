import 'package:flutter/material.dart';

import '../../../view model/responsive.dart';
import 'components/intro_body.dart';
import 'components/side_menu_button.dart';
import 'components/social_media_list.dart';
class Introduction extends StatelessWidget {
  const Introduction({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.1),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.01,
            ),
            if (!Responsive.isLargeMobile(context))  Visibility(visible:false,child: MenuButton(onTap: () => Scaffold.of(context).openDrawer(),)),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.02,
            ),
            if (!Responsive.isLargeMobile(context)) const Visibility(visible:false,child: SocialMediaIconList()),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.1,
            ),
            const Expanded(
              child: IntroBody(),
            ),
          ],
        ),
      ),
    );
  }
}



