import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/route/routes.dart';
import 'package:flutter_base/utils/image_assets.dart';
import 'package:flutter_base/widgets/button_widget/customizable_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/colors.dart';

class BlogSliderWidget extends StatefulWidget {
  final int itemIndex;
  const BlogSliderWidget({super.key, required this.itemIndex});

  @override
  State<BlogSliderWidget> createState() => _BlogSliderWidgetState();
}

class _BlogSliderWidgetState extends State<BlogSliderWidget> with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController animateController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animateController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) async {
        isHovered = value;
        setState(() {});
        await animateController.forward();
      },
      onTap: () {
        Navigator.pushNamed(context, Routes.DETAILS);
      },
      hoverColor: Colors.transparent,
      child: (ResponsiveBreakpoints.of(context).screenWidth < 575)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                        ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                            ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                    ? 614.h
                                    : 331
                                : 289
                            : 398
                        : 404,
                    width: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                        ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                            ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                    ? 450
                                    : 273
                                : 242
                            : 322
                        : 425,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          portfolioImages(widget.itemIndex),
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: (isHovered)
                              ? [primaryColor, Colors.transparent]
                              : [Colors.black54, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AnimatedContainer(
                            height: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                                ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                    ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                        ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                            ? 614.h
                                            : 331
                                        : 289
                                    : 398
                                : 404,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(30),
                            duration: Duration(seconds: 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Shop",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white.withOpacity(0.75),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "What is the difference between web and mobile",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                        ? 24
                                        : 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Visibility(
                                  visible: isHovered,
                                  child: FadeInUp(
                                    child: SizedBox(
                                      height: (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                          ? 5
                                          : 15,
                                    ),
                                  ),
                                ),
                                // isHovered
                                //     ?
                                Visibility(
                                  visible: isHovered,
                                  child: FadeInUp(
                                    from: 10,
                                    duration: Duration(milliseconds: 500),
                                    child: CustomizableTextButton(
                                      prefixButtonIcon: null,
                                      suffixButtonIcon: null,
                                      isFullWidth: false,
                                      isOutlined: true,
                                      buttonBorderColor: Colors.white30,
                                      buttonTitle: "Read More".toUpperCase(),
                                      onPressed: () async {},
                                      buttonTitleStyle: TextStyle(
                                        fontSize:
                                            (ResponsiveBreakpoints.of(context).screenWidth < 750)
                                                ? 12
                                                : 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      buttonBorderRadius: 6,
                                      buttonColor: Colors.transparent,
                                      horizontalPadding: 30,
                                      verticalPadding: 8,
                                    ),
                                  ),
                                )
                                // : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              height: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                  ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                      ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                          ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                              ? 614
                              : 331
                          : 289
                      : 398
                  : 404,
              width: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                  ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                      ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                          ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                              ? 450
                              : 273
                          : 242
                      : 322
                  : 425,
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    portfolioImages(widget.itemIndex),
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: (isHovered)
                        ? [primaryColor, Colors.transparent]
                        : [Colors.black54, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "Shop",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.white.withOpacity(0.75),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "What is the difference between web and mobile",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontSize:
                                  (ResponsiveBreakpoints.of(context).screenWidth < 990) ? 24 : 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Visibility(
                            visible: isHovered,
                            child: SizedBox(
                              height:
                                  (ResponsiveBreakpoints.of(context).screenWidth < 990) ? 5 : 15,
                            ),
                          ),
                          Visibility(
                            visible: isHovered,
                            child: FadeInUp(
                              from: 10,
                              duration: Duration(milliseconds: 500),
                              child: CustomizableTextButton(
                                prefixButtonIcon: null,
                                suffixButtonIcon: null,
                                isFullWidth: false,
                                isOutlined: true,
                                buttonBorderColor: Colors.white30,
                                buttonTitle: "Read More".toUpperCase(),
                                onPressed: () async {},
                                buttonTitleStyle: TextStyle(
                                  fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 750)
                                      ? 12
                                      : 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                buttonBorderRadius: 6,
                                buttonColor: Colors.transparent,
                                horizontalPadding: 30,
                                verticalPadding: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  String portfolioImages(int index) {
    if (index == 0) {
      return portfolio1Image;
    } else if (index == 1) {
      return portfolio2Image;
    } else if (index == 2) {
      return portfolio3Image;
    } else if (index == 3) {
      return portfolio4Image;
    } else {
      return portfolio5Image;
    }
  }
}
