import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/providers/api_auth_notifier.dart';
import 'package:flutter_base/utils/colors.dart';
import 'package:flutter_base/utils/constants.dart';
import 'package:flutter_base/utils/image_assets.dart';
import 'package:flutter_base/utils/strings.dart';
import 'package:flutter_base/views/home/widgets/blog_slider_widget.dart';
import 'package:flutter_base/views/home/widgets/portfolio_slider_widget.dart';
import 'package:flutter_base/widgets/button_widget/customizable_button.dart';
import 'package:flutter_base/widgets/text_field_widget/customizable_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  ScrollController controller = ScrollController();
  final homeKey = GlobalKey();
  final servicesKey = GlobalKey();
  final aboutKey = GlobalKey();
  final portfolioKey = GlobalKey();
  final blogKey = GlobalKey();
  final contactUsKey = GlobalKey();
  bool showNavBar = false;
  ScrollController _portfolioScroll1Controller = ScrollController();
  PageController _portfolioScrollController = PageController();
  int portfolioPageNumber = 0;

  TextEditingController yourNameEditingController = TextEditingController();
  TextEditingController yourPhoneEditingController = TextEditingController();
  TextEditingController yourEmailEditingController = TextEditingController();
  TextEditingController yourMessageEditingController = TextEditingController();
  FocusNode yourNameFocusNode = FocusNode();
  FocusNode yourPhoneFocusNode = FocusNode();
  FocusNode yourEmailFocusNode = FocusNode();
  FocusNode yourMessageFocusNode = FocusNode();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    portfolioPageNumber = ref.watch(pageNumberProvider);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        logoSymbolDarkImage,
                        height: (ResponsiveBreakpoints.of(context).screenWidth < 750) ? 50 : 56,
                        width: (ResponsiveBreakpoints.of(context).screenWidth < 750) ? 50 : 56,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                drawerNavButton(
                  title: "Home",
                  onPressed: () async {
                    Navigator.pop(context);
                    await Scrollable.ensureVisible(homeKey.currentContext!,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastEaseInToSlowEaseOut);
                  },
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.withOpacity(0.20),
                ),
                drawerNavButton(
                  title: "Service",
                  onPressed: () async {
                    Navigator.pop(context);
                    await Scrollable.ensureVisible(servicesKey.currentContext!,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastEaseInToSlowEaseOut);
                  },
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.withOpacity(0.20),
                ),
                drawerNavButton(
                  title: "About",
                  onPressed: () async {
                    Navigator.pop(context);
                    await Scrollable.ensureVisible(aboutKey.currentContext!,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastEaseInToSlowEaseOut);
                  },
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.withOpacity(0.20),
                ),
                drawerNavButton(
                  title: "Portfolio",
                  onPressed: () async {
                    Navigator.pop(context);
                    await Scrollable.ensureVisible(portfolioKey.currentContext!,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastEaseInToSlowEaseOut);
                  },
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.withOpacity(0.20),
                ),
                drawerNavButton(
                  title: "Blog",
                  onPressed: () async {
                    Navigator.pop(context);
                    await Scrollable.ensureVisible(blogKey.currentContext!,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastEaseInToSlowEaseOut);
                  },
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.withOpacity(0.20),
                ),
                drawerNavButton(
                  title: "Contact",
                  onPressed: () async {
                    Navigator.pop(context);
                    await Scrollable.ensureVisible(contactUsKey.currentContext!,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastEaseInToSlowEaseOut);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Visibility(
                visible: showNavBar,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          ResponsiveBreakpoints.of(context).largerOrEqualTo(DESKTOP) ? 50 : 15,
                      vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        logoImageDark,
                        height: (ResponsiveBreakpoints.of(context).screenWidth < 750) ? 50 : 60,
                        width: (ResponsiveBreakpoints.of(context).screenWidth < 750) ? 100 : 132,
                      ),
                      Row(
                        children: [
                          Visibility(
                            visible: !(ResponsiveBreakpoints.of(context).screenWidth < 1036),
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  navButton(
                                    title: "Home",
                                    textColor: Colors.black,
                                    onPressed: () async {
                                      await Scrollable.ensureVisible(homeKey.currentContext!,
                                          duration: const Duration(milliseconds: 1000),
                                          curve: Curves.fastEaseInToSlowEaseOut);
                                    },
                                  ),
                                  navButton(
                                    title: "Service",
                                    textColor: Colors.black,
                                    onPressed: () async {
                                      await Scrollable.ensureVisible(servicesKey.currentContext!,
                                          duration: const Duration(milliseconds: 1000),
                                          curve: Curves.fastEaseInToSlowEaseOut);
                                    },
                                  ),
                                  navButton(
                                    title: "About",
                                    textColor: Colors.black,
                                    onPressed: () async {
                                      await Scrollable.ensureVisible(aboutKey.currentContext!,
                                          duration: const Duration(milliseconds: 1000),
                                          curve: Curves.fastEaseInToSlowEaseOut);
                                    },
                                  ),
                                  navButton(
                                    title: "Portfolio",
                                    textColor: Colors.black,
                                    onPressed: () async {
                                      await Scrollable.ensureVisible(portfolioKey.currentContext!,
                                          duration: const Duration(milliseconds: 1000),
                                          curve: Curves.fastEaseInToSlowEaseOut);
                                    },
                                  ),
                                  navButton(
                                    title: "Blog",
                                    textColor: Colors.black,
                                    onPressed: () async {
                                      await Scrollable.ensureVisible(blogKey.currentContext!,
                                          duration: const Duration(milliseconds: 1000),
                                          curve: Curves.fastEaseInToSlowEaseOut);
                                    },
                                  ),
                                  navButton(
                                    title: "Contact",
                                    textColor: Colors.black,
                                    onPressed: () async {
                                      await Scrollable.ensureVisible(contactUsKey.currentContext!,
                                          duration: const Duration(milliseconds: 1000),
                                          curve: Curves.fastEaseInToSlowEaseOut);
                                    },
                                  ),
                                  // CustomizableTextButton(
                                  //   prefixButtonIcon: null,
                                  //   suffixButtonIcon: null,
                                  //   isFullWidth: false,
                                  //   isOutlined: true,
                                  //   buttonTitle: Constants.buyNow,
                                  //   onPressed: () async {},
                                  //   buttonTitleStyle: TextStyle(
                                  //     fontSize: 16.sp,
                                  //     color: Colors.black,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  //   buttonBorderRadius: 70,
                                  //   buttonColor: Colors.transparent,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: ResponsiveBreakpoints.of(context).largerOrEqualTo(DESKTOP)
                                    ? 50
                                    : 30,
                              ),
                              // CustomizableTextButton(
                              //   prefixButtonIcon: null,
                              //   suffixButtonIcon: null,
                              //   isFullWidth: false,
                              //   isOutlined: true,
                              //   buttonBorderColor: Colors.black,
                              //   buttonTitle: Constants.buyNow.toUpperCase(),
                              //   onPressed: () async {},
                              //   buttonTitleStyle: TextStyle(
                              //     fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 750)
                              //         ? 12
                              //         : 14,
                              //     color: Colors.black,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              //   buttonBorderRadius: 60,
                              //   buttonColor: Colors.transparent,
                              //   horizontalPadding:
                              //       (ResponsiveBreakpoints.of(context).screenWidth < 750) ? 20 : 40,
                              //   verticalPadding:
                              //       (ResponsiveBreakpoints.of(context).screenWidth < 765) ? 8 : 16,
                              // ),
                              Visibility(
                                visible: ResponsiveBreakpoints.of(context).screenWidth < 1036,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: InkWell(
                                    onTap: () {
                                      _scaffoldKey.currentState?.openDrawer();
                                      // Scaffold.of(context).openDrawer();
                                    },
                                    child: Icon(
                                      Icons.menu,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      Container(
                        key: homeKey,
                        height: (ResponsiveBreakpoints.of(context).screenWidth < 1000)
                            ? (ResponsiveBreakpoints.of(context).screenWidth < 760)
                                ? 496
                                : 660
                            : 720,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(homeSectionBackgroundImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black54,
                          child: Column(
                            children: [
                              VisibilityDetector(
                                key: Key('navbar'),
                                onVisibilityChanged: (visibilityInfo) {
                                  if (visibilityInfo.visibleFraction == 0) {
                                    showNavBar = true;
                                    setState(() {});
                                  } else {
                                    showNavBar = false;
                                    setState(() {});
                                  }
                                  var visiblePercentage = visibilityInfo.visibleFraction * 100;
                                  debugPrint(
                                      'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          ResponsiveBreakpoints.of(context).largerOrEqualTo(DESKTOP)
                                              ? 50
                                              : 15,
                                      vertical: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        logoImage,
                                        height:
                                            (ResponsiveBreakpoints.of(context).screenWidth < 750)
                                                ? 50
                                                : 60,
                                        width: (ResponsiveBreakpoints.of(context).screenWidth < 750)
                                            ? 100
                                            : 132,
                                      ),
                                      Row(
                                        children: [
                                          Visibility(
                                            visible:
                                                !(ResponsiveBreakpoints.of(context).screenWidth <
                                                    1036),
                                            child: Container(
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  navButton(
                                                    title: "Home",
                                                    onPressed: () async {
                                                      await Scrollable.ensureVisible(
                                                          homeKey.currentContext!,
                                                          duration:
                                                              const Duration(milliseconds: 1000),
                                                          curve: Curves.fastEaseInToSlowEaseOut);
                                                    },
                                                  ),
                                                  navButton(
                                                    title: "Service",
                                                    onPressed: () async {
                                                      await Scrollable.ensureVisible(
                                                          servicesKey.currentContext!,
                                                          duration:
                                                              const Duration(milliseconds: 1000),
                                                          curve: Curves.fastEaseInToSlowEaseOut);
                                                    },
                                                  ),
                                                  navButton(
                                                    title: "About",
                                                    onPressed: () async {
                                                      await Scrollable.ensureVisible(
                                                          aboutKey.currentContext!,
                                                          duration:
                                                              const Duration(milliseconds: 1000),
                                                          curve: Curves.fastEaseInToSlowEaseOut);
                                                    },
                                                  ),
                                                  navButton(
                                                    title: "Portfolio",
                                                    onPressed: () async {
                                                      await Scrollable.ensureVisible(
                                                          portfolioKey.currentContext!,
                                                          duration:
                                                              const Duration(milliseconds: 1000),
                                                          curve: Curves.fastEaseInToSlowEaseOut);
                                                    },
                                                  ),
                                                  navButton(
                                                    title: "Blog",
                                                    onPressed: () async {
                                                      await Scrollable.ensureVisible(
                                                          blogKey.currentContext!,
                                                          duration:
                                                              const Duration(milliseconds: 1000),
                                                          curve: Curves.fastEaseInToSlowEaseOut);
                                                    },
                                                  ),
                                                  navButton(
                                                    title: "Contact",
                                                    onPressed: () async {
                                                      await Scrollable.ensureVisible(
                                                          contactUsKey.currentContext!,
                                                          duration:
                                                              const Duration(milliseconds: 1000),
                                                          curve: Curves.fastEaseInToSlowEaseOut);
                                                    },
                                                  ),
                                                  // CustomizableTextButton(
                                                  //   prefixButtonIcon: null,
                                                  //   suffixButtonIcon: null,
                                                  //   isFullWidth: false,
                                                  //   isOutlined: true,
                                                  //   buttonTitle: Constants.buyNow,
                                                  //   onPressed: () async {},
                                                  //   buttonTitleStyle: TextStyle(
                                                  //     fontSize: 16.sp,
                                                  //     color: Colors.black,
                                                  //     fontWeight: FontWeight.w500,
                                                  //   ),
                                                  //   buttonBorderRadius: 70,
                                                  //   buttonColor: Colors.transparent,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: ResponsiveBreakpoints.of(context)
                                                        .largerOrEqualTo(DESKTOP)
                                                    ? 50
                                                    : 30,
                                              ),
                                              /*CustomizableTextButton(
                                                prefixButtonIcon: null,
                                                suffixButtonIcon: null,
                                                isFullWidth: false,
                                                isOutlined: true,
                                                buttonTitle: Constants.buyNow.toUpperCase(),
                                                onPressed: () async {},
                                                buttonTitleStyle: TextStyle(
                                                  fontSize: (ResponsiveBreakpoints.of(context)
                                                              .screenWidth <
                                                          750)
                                                      ? 12
                                                      : 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                buttonBorderRadius: 60,
                                                buttonColor: Colors.transparent,
                                                horizontalPadding:
                                                    (ResponsiveBreakpoints.of(context).screenWidth <
                                                            750)
                                                        ? 20
                                                        : 40,
                                                verticalPadding:
                                                    (ResponsiveBreakpoints.of(context).screenWidth <
                                                            765)
                                                        ? 8
                                                        : 16,
                                              ),*/
                                              Visibility(
                                                visible:
                                                    ResponsiveBreakpoints.of(context).screenWidth <
                                                        1036,
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 20),
                                                  child: InkWell(
                                                    onTap: () {
                                                      _scaffoldKey.currentState?.openDrawer();
                                                    },
                                                    child: Icon(
                                                      Icons.menu,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 140.w),
                                child: Column(
                                  children: [
                                    SizedBox(height: 100.h),
                                    GradientText(
                                      "Creative",
                                      style: GoogleFonts.montserrat(
                                        fontSize: (ResponsiveBreakpoints.of(context).screenWidth <
                                                1200)
                                            ? (ResponsiveBreakpoints.of(context).screenWidth < 1000)
                                                ? (ResponsiveBreakpoints.of(context).screenWidth <
                                                        765)
                                                    ? 36
                                                    : 56
                                                : 70
                                            : 90,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      colors: [
                                        gradientColor1,
                                        gradientColor2,
                                        gradientColor3,
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 106.w),
                                      child: Text(
                                        "There are many variations of passages of Lorem Ipsum available but the majority have suffered alteration.",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              (ResponsiveBreakpoints.of(context).screenWidth < 765)
                                                  ? 16
                                                  : 24,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white.withOpacity(0.75),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    CustomizableTextButton(
                                      prefixButtonIcon: null,
                                      suffixButtonIcon: null,
                                      isFullWidth: false,
                                      isOutlined: false,
                                      buttonTitle: Constants.contactUs.toUpperCase(),
                                      onPressed: () async {
                                        await Scrollable.ensureVisible(contactUsKey.currentContext!,
                                            duration: const Duration(milliseconds: 1000),
                                            curve: Curves.fastEaseInToSlowEaseOut);
                                      },
                                      buttonTitleStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      buttonBorderRadius: 60,
                                      buttonColor: primaryColor,
                                      horizontalPadding:
                                          (ResponsiveBreakpoints.of(context).screenWidth < 1000)
                                              ? 40
                                              : 60,
                                      verticalPadding:
                                          (ResponsiveBreakpoints.of(context).screenWidth < 1000)
                                              ? 16
                                              : 24,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        key: servicesKey,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 120),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              spacing: 30,
                              runSpacing: 30,
                              children: [
                                serviceWidget(
                                  onPressed: () {},
                                  title: "Business Strategy",
                                  content:
                                      "I throw myself down among the tall grass by the stream as I lie close to the earth.",
                                  icon: SvgPicture.asset(
                                    websiteDevelopmentIcon,
                                    color: primaryColor,
                                    height: 47,
                                    width: 47,
                                  ),
                                ),
                                serviceWidget(
                                  onPressed: () {},
                                  title: "Website Development",
                                  content:
                                      "I throw myself down among the tall grass by the stream as I lie close to the earth.",
                                  icon: SvgPicture.asset(
                                    websiteDevelopmentIcon,
                                    color: secondaryColor,
                                    height: 47,
                                    width: 47,
                                  ),
                                ),
                                serviceWidget(
                                  onPressed: () {},
                                  title: "Marketing & Reporting",
                                  content:
                                      "I throw myself down among the tall grass by the stream as I lie close to the earth.",
                                  icon: SvgPicture.asset(
                                    marketingReportingIcon,
                                    color: lightBlueColor,
                                    height: 47,
                                    width: 47,
                                  ),
                                ),
                                serviceWidget(
                                  onPressed: () {},
                                  title: "Mobile App Development",
                                  content:
                                      "I throw myself down among the tall grass by the stream as I lie close to the earth.",
                                  icon: SvgPicture.asset(
                                    mobileAppDevelopmentIcon,
                                    color: Colors.green,
                                    height: 47,
                                    width: 47,
                                  ),
                                ),
                                serviceWidget(
                                  onPressed: () {},
                                  title: "Marketing & Reporting",
                                  content:
                                      "I throw myself down among the tall grass by the stream as I lie close to the earth.",
                                  icon: SvgPicture.asset(
                                    marketingReportingIcon,
                                    color: purpleColor,
                                    height: 47,
                                    width: 47,
                                  ),
                                ),
                                serviceWidget(
                                  onPressed: () {},
                                  title: "Mobile App Development",
                                  content:
                                      "I throw myself down among the tall grass by the stream as I lie close to the earth.",
                                  icon: SvgPicture.asset(
                                    mobileAppDevelopmentIcon,
                                    color: secondaryColor,
                                    height: 47,
                                    width: 47,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        key: aboutKey,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 120),
                        color: Colors.grey.withOpacity(0.06),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        (ResponsiveBreakpoints.of(context).screenWidth < 570)
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        height: (ResponsiveBreakpoints.of(context)
                                                                    .screenWidth <
                                                                770)
                                                            ? 596.h
                                                            : 804,
                                                        width: (ResponsiveBreakpoints.of(context)
                                                                    .screenWidth <
                                                                770)
                                                            ? 516.w
                                                            : 696,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage(aboutImage),
                                                            fit: BoxFit.fitWidth,
                                                          ),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                height:
                                                    (ResponsiveBreakpoints.of(context).screenWidth <
                                                            770)
                                                        ? 596
                                                        : 804,
                                                width:
                                                    (ResponsiveBreakpoints.of(context).screenWidth <
                                                            770)
                                                        ? 516
                                                        : 696,
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(aboutImage),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        (ResponsiveBreakpoints.of(context).screenWidth < 570)
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                child: Container(
                                                  width: (ResponsiveBreakpoints.of(context)
                                                              .screenWidth <
                                                          770)
                                                      ? 516
                                                      : 696,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      GradientText(
                                                        "Read About Us",
                                                        style: GoogleFonts.montserrat(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        colors: [
                                                          gradientColor1,
                                                          gradientColor2,
                                                          gradientColor3,
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 12.h,
                                                      ),
                                                      Text(
                                                        "Read Company Values",
                                                        textAlign: TextAlign.left,
                                                        style: GoogleFonts.poppins(
                                                          fontSize:
                                                              (ResponsiveBreakpoints.of(context)
                                                                          .screenWidth <
                                                                      765)
                                                                  ? 16
                                                                  : 50,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.black.withOpacity(0.75),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 26.h,
                                                      ),
                                                      Text(
                                                        "There are many variations of passages of Lorem Ipsum available,\nbut the majority have suffered alteration.",
                                                        textAlign: TextAlign.left,
                                                        style: GoogleFonts.poppins(
                                                          fontSize:
                                                              (ResponsiveBreakpoints.of(context)
                                                                          .screenWidth <
                                                                      765)
                                                                  ? 16
                                                                  : 18,
                                                          fontWeight: FontWeight.w300,
                                                          color: Colors.black.withOpacity(0.75),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 50,
                                                      ),
                                                      aboutUsTitleDescription(
                                                          title: "Honest",
                                                          description:
                                                              "Lorem ipsum dolor sit amet, onecis et mollis."),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      aboutUsTitleDescription(
                                                          title: "Strategy",
                                                          description:
                                                              "Lorem ipsum dolor sit amet, onecis et mollis."),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      aboutUsTitleDescription(
                                                          title: "Development",
                                                          description:
                                                              "Lorem ipsum dolor sit amet, onecis et mollis."),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      aboutUsTitleDescription(
                                                          title: "Quality",
                                                          description:
                                                              "Lorem ipsum dolor sit amet, onecis et mollis."),

                                                      /*Row(
                                                  children: [
                                                    Expanded(
                                                      child: aboutUsTitleDescription(
                                                          title: "Development",
                                                          description:
                                                              "Lorem ipsum dolor sit amet, onecis et mollis."),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Expanded(
                                                      child: aboutUsTitleDescription(
                                                          title: "Quality",
                                                          description:
                                                              "Lorem ipsum dolor sit amet, onecis et mollis."),
                                                    ),
                                                  ],
                                                ),*/
                                                      SizedBox(
                                                        height: 50,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: GradientText(
                                                              "WHY WE'RE DIFFERENT VALUES",
                                                              style: GoogleFonts.montserrat(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                              colors: [
                                                                gradientColor1,
                                                                gradientColor2,
                                                                gradientColor3,
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Container(
                                                        height: 2.4,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            colors: [
                                                              gradientColor1,
                                                              gradientColor2,
                                                              gradientColor3,
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width:
                                                    (ResponsiveBreakpoints.of(context).screenWidth <
                                                            770)
                                                        ? 516
                                                        : 696,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    GradientText(
                                                      "Read About Us",
                                                      style: GoogleFonts.montserrat(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      colors: [
                                                        gradientColor1,
                                                        gradientColor2,
                                                        gradientColor3,
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 12.h,
                                                    ),
                                                    Text(
                                                      "Read Company Values",
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts.poppins(
                                                        fontSize: (ResponsiveBreakpoints.of(context)
                                                                    .screenWidth <
                                                                765)
                                                            ? 16
                                                            : 50,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black.withOpacity(0.75),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 26.h,
                                                    ),
                                                    Text(
                                                      "There are many variations of passages of Lorem Ipsum available,\nbut the majority have suffered alteration.",
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts.poppins(
                                                        fontSize: (ResponsiveBreakpoints.of(context)
                                                                    .screenWidth <
                                                                765)
                                                            ? 16
                                                            : 18,
                                                        fontWeight: FontWeight.w300,
                                                        color: Colors.black.withOpacity(0.75),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    aboutUsTitleDescription(
                                                        title: "Honest",
                                                        description:
                                                            "Lorem ipsum dolor sit amet, onecis et mollis."),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    aboutUsTitleDescription(
                                                        title: "Strategy",
                                                        description:
                                                            "Lorem ipsum dolor sit amet, onecis et mollis."),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    aboutUsTitleDescription(
                                                        title: "Development",
                                                        description:
                                                            "Lorem ipsum dolor sit amet, onecis et mollis."),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    aboutUsTitleDescription(
                                                        title: "Quality",
                                                        description:
                                                            "Lorem ipsum dolor sit amet, onecis et mollis."),

                                                    /*Row(
                                                children: [
                                                  Expanded(
                                                    child: aboutUsTitleDescription(
                                                        title: "Development",
                                                        description:
                                                            "Lorem ipsum dolor sit amet, onecis et mollis."),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child: aboutUsTitleDescription(
                                                        title: "Quality",
                                                        description:
                                                            "Lorem ipsum dolor sit amet, onecis et mollis."),
                                                  ),
                                                ],
                                              ),*/
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    GradientText(
                                                      "WHY WE'RE DIFFERENT VALUES",
                                                      style: GoogleFonts.montserrat(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                      colors: [
                                                        gradientColor1,
                                                        gradientColor2,
                                                        gradientColor3,
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Container(
                                                      height: 2.4,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                          colors: [
                                                            gradientColor1,
                                                            gradientColor2,
                                                            gradientColor3,
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height:
                                              (ResponsiveBreakpoints.of(context).screenWidth < 1280)
                                                  ? 524
                                                  : 696,
                                          width:
                                              (ResponsiveBreakpoints.of(context).screenWidth < 1280)
                                                  ? 452
                                                  : 633,
                                          padding: EdgeInsets.symmetric(horizontal: 15),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(aboutImage),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          width:
                                              (ResponsiveBreakpoints.of(context).screenWidth < 1280)
                                                  ? 452
                                                  : 633,
                                          padding: EdgeInsets.symmetric(horizontal: 15),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              GradientText(
                                                "Read About Us",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                colors: [
                                                  gradientColor1,
                                                  gradientColor2,
                                                  gradientColor3,
                                                ],
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              Text(
                                                "Read Company Values",
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontSize: (ResponsiveBreakpoints.of(context)
                                                              .screenWidth <
                                                          765)
                                                      ? 16
                                                      : 50,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black.withOpacity(0.75),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 26.h,
                                              ),
                                              Text(
                                                "There are many variations of passages of Lorem Ipsum available,\nbut the majority have suffered alteration.",
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontSize: (ResponsiveBreakpoints.of(context)
                                                              .screenWidth <
                                                          765)
                                                      ? 16
                                                      : 18,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black.withOpacity(0.75),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: aboutUsTitleDescription(
                                                        title: "Honest",
                                                        description:
                                                            "Lorem ipsum dolor sit amet, onecis et mollis."),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child: aboutUsTitleDescription(
                                                        title: "Strategy",
                                                        description:
                                                            "Lorem ipsum dolor sit amet, onecis et mollis."),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: aboutUsTitleDescription(
                                                        title: "Development",
                                                        description:
                                                            "Lorem ipsum dolor sit amet, onecis et mollis."),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child: aboutUsTitleDescription(
                                                        title: "Quality",
                                                        description:
                                                            "Lorem ipsum dolor sit amet, onecis et mollis."),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              GradientText(
                                                "WHY WE'RE DIFFERENT VALUES",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                colors: [
                                                  gradientColor1,
                                                  gradientColor2,
                                                  gradientColor3,
                                                ],
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Container(
                                                height: 2.4,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      gradientColor1,
                                                      gradientColor2,
                                                      gradientColor3,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        key: portfolioKey,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 120),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GradientText(
                                    "Our project",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    colors: [
                                      gradientColor1,
                                      gradientColor2,
                                      gradientColor3,
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  Text(
                                    "Some of our Recent Works",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontSize: (ResponsiveBreakpoints.of(context).screenWidth <
                                              990)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                              ? 32
                                              : 40
                                          : 50,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.75),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 26.h,
                                  ),
                                  Text(
                                    "There are many variations of passages of Lorem Ipsum available,\nbut the majority have suffered alteration.",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontSize: (ResponsiveBreakpoints.of(context).screenWidth <
                                              765)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                              ? 14
                                              : 16
                                          : 18,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black.withOpacity(0.75),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Container(
                                    width: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                                        ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                            ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                                ? (ResponsiveBreakpoints.of(context).screenWidth <
                                                        575)
                                                    ? 479
                                                    : 546
                                                : 726
                                            : 966
                                        : 1266,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                                  ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                      ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                              ? 713.h
                                              : 431
                                          : 389
                                      : 498
                                  : 634,
                              width: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                                  ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                      ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                              ? 479
                                              : 546
                                          : 726
                                      : 966
                                  : 1266,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: LayoutBuilder(builder: (context, constraints) {
                                            return InfiniteCarousel.builder(
                                              itemCount: 5,
                                              itemExtent: (ResponsiveBreakpoints.of(context)
                                                          .screenWidth <
                                                      1270)
                                                  ? (ResponsiveBreakpoints.of(context).screenWidth <
                                                          990)
                                                      ? (ResponsiveBreakpoints.of(context)
                                                                  .screenWidth <
                                                              770)
                                                          ? (ResponsiveBreakpoints.of(context)
                                                                      .screenWidth <
                                                                  575)
                                                              ? constraints.maxWidth
                                                              : 273
                                                          : 242
                                                      : 322
                                                  : 425,
                                              center: false,
                                              anchor: 0.0,
                                              velocityFactor: 0.8,
                                              onIndexChanged: (index) {
                                                ref.read(pageNumberProvider.notifier).state = index;
                                              },
                                              controller: _portfolioScroll1Controller,
                                              axisDirection: Axis.horizontal,
                                              loop: true,
                                              itemBuilder: (context, itemIndex, realIndex) {
                                                return PortfolioSliderWidget(itemIndex: itemIndex);
                                              },
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                portfolioPageNumber == 0 ? activeIndicator() : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 1 ? activeIndicator() : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 2 ? activeIndicator() : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 3 ? activeIndicator() : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 4 ? activeIndicator() : inActiveIndicator(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: /*(ResponsiveBreakpoints.of(context).screenWidth < 1270)
                            ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                    ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                        ? 479
                                        : 546
                                    : 726
                                : 966
                            : */
                            1266,
                        padding: EdgeInsets.symmetric(vertical: 120),
                        color: Colors.grey.withOpacity(0.06),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GradientText(
                              "Experts grows",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              colors: [
                                gradientColor1,
                                gradientColor2,
                                gradientColor3,
                              ],
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Text(
                              "Our Company Growth",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontSize:
                                    (ResponsiveBreakpoints.of(context).screenWidth < 765) ? 16 : 50,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.75),
                              ),
                            ),
                            SizedBox(
                              height: 26.h,
                            ),
                            Text(
                              "We have grown strength over the past 20 years",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontSize:
                                    (ResponsiveBreakpoints.of(context).screenWidth < 765) ? 16 : 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.black.withOpacity(0.75),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              child: Wrap(
                                spacing: 30,
                                runSpacing: 30,
                                children: [
                                  companyGrowthWidget(
                                    icon: Icon(
                                      Icons.favorite_border_outlined,
                                      size: 44,
                                      color: primaryColor,
                                    ),
                                    scores: 120,
                                    title: "Satisfied Customers",
                                  ),
                                  companyGrowthWidget(
                                    icon: Icon(
                                      Icons.access_time_outlined,
                                      size: 44,
                                      color: secondaryColor,
                                    ),
                                    scores: 200,
                                    title: "Days of Operation",
                                  ),
                                  companyGrowthWidget(
                                    icon: Icon(
                                      Icons.circle_outlined,
                                      size: 44,
                                      color: orangeColor,
                                    ),
                                    scores: 200,
                                    title: "Complete Projects",
                                  ),
                                  companyGrowthWidget(
                                    icon: Icon(
                                      Icons.favorite_border_outlined,
                                      size: 44,
                                      color: primaryColor,
                                    ),
                                    scores: 120,
                                    title: "Satisfied Customers",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        key: blogKey,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 120),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GradientText(
                                    "Latest News",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    colors: [
                                      gradientColor1,
                                      gradientColor2,
                                      gradientColor3,
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  Text(
                                    "Latest News",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontSize: (ResponsiveBreakpoints.of(context).screenWidth <
                                              990)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                              ? 32
                                              : 40
                                          : 50,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.75),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 26.h,
                                  ),
                                  Text(
                                    "There are many variations of passages of Lorem Ipsum available,\nbut the majority have suffered alteration.",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontSize: (ResponsiveBreakpoints.of(context).screenWidth <
                                              765)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                              ? 14
                                              : 16
                                          : 18,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black.withOpacity(0.75),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Container(
                                    width: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                                        ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                            ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                                ? (ResponsiveBreakpoints.of(context).screenWidth <
                                                        575)
                                                    ? 479
                                                    : 546
                                                : 726
                                            : 966
                                        : 1266,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                                  ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                      ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                              ? 713.h
                                              : 431
                                          : 389
                                      : 498
                                  : 634,
                              width: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                                  ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                      ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                              ? 479
                                              : 546
                                          : 726
                                      : 966
                                  : 1266,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: LayoutBuilder(builder: (context, constraints) {
                                            return InfiniteCarousel.builder(
                                              itemCount: 5,
                                              itemExtent: (ResponsiveBreakpoints.of(context)
                                                          .screenWidth <
                                                      1270)
                                                  ? (ResponsiveBreakpoints.of(context).screenWidth <
                                                          990)
                                                      ? (ResponsiveBreakpoints.of(context)
                                                                  .screenWidth <
                                                              770)
                                                          ? (ResponsiveBreakpoints.of(context)
                                                                      .screenWidth <
                                                                  575)
                                                              ? constraints.maxWidth
                                                              : 273
                                                          : 242
                                                      : 322
                                                  : 425,
                                              center: false,
                                              anchor: 0.0,
                                              velocityFactor: 0.8,
                                              onIndexChanged: (index) {
                                                ref.read(pageNumberProvider.notifier).state = index;
                                              },
                                              controller: _portfolioScroll1Controller,
                                              axisDirection: Axis.horizontal,
                                              loop: true,
                                              itemBuilder: (context, itemIndex, realIndex) {
                                                return BlogSliderWidget(itemIndex: itemIndex);
                                              },
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                portfolioPageNumber == 0 ? activeIndicator() : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 1 ? activeIndicator() : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 2 ? activeIndicator() : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 3 ? activeIndicator() : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 4 ? activeIndicator() : inActiveIndicator(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        key: contactUsKey,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 120),
                        color: Colors.grey.withOpacity(0.06),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        (ResponsiveBreakpoints.of(context).screenWidth < 570)
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        height: (ResponsiveBreakpoints.of(context)
                                                                    .screenWidth <
                                                                770)
                                                            ? 596.h
                                                            : 804,
                                                        width: (ResponsiveBreakpoints.of(context)
                                                                    .screenWidth <
                                                                770)
                                                            ? 516.w
                                                            : 696,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage(aboutImage),
                                                            fit: BoxFit.fitWidth,
                                                          ),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                height:
                                                    (ResponsiveBreakpoints.of(context).screenWidth <
                                                            770)
                                                        ? 596
                                                        : 804,
                                                width:
                                                    (ResponsiveBreakpoints.of(context).screenWidth <
                                                            770)
                                                        ? 516
                                                        : 696,
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(aboutImage),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        (ResponsiveBreakpoints.of(context).screenWidth < 570)
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                child: Container(
                                                  width: (ResponsiveBreakpoints.of(context)
                                                              .screenWidth <
                                                          770)
                                                      ? 516
                                                      : 696,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      GradientText(
                                                        "Let's Say Hi",
                                                        style: GoogleFonts.montserrat(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        colors: [
                                                          gradientColor1,
                                                          gradientColor2,
                                                          gradientColor3,
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 12.h,
                                                      ),
                                                      Text(
                                                        "Contact With Us",
                                                        textAlign: TextAlign.left,
                                                        style: GoogleFonts.poppins(
                                                          fontSize:
                                                              (ResponsiveBreakpoints.of(context)
                                                                          .screenWidth <
                                                                      765)
                                                                  ? 16
                                                                  : 50,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.black.withOpacity(0.75),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 26.h,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "Call us directly: ",
                                                                  textAlign: TextAlign.left,
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        (ResponsiveBreakpoints.of(
                                                                                        context)
                                                                                    .screenWidth <
                                                                                765)
                                                                            ? 16
                                                                            : 14,
                                                                    fontWeight: FontWeight.w300,
                                                                    color: Colors.black
                                                                        .withOpacity(0.75),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    "+111 227 228 222",
                                                                    textAlign: TextAlign.left,
                                                                    style: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          (ResponsiveBreakpoints.of(
                                                                                          context)
                                                                                      .screenWidth <
                                                                                  765)
                                                                              ? 14
                                                                              : 17,
                                                                      fontWeight: FontWeight.w700,
                                                                      color: Colors.black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20.h,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "Contact Email: ",
                                                                  textAlign: TextAlign.left,
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        (ResponsiveBreakpoints.of(
                                                                                        context)
                                                                                    .screenWidth <
                                                                                765)
                                                                            ? 16
                                                                            : 14,
                                                                    fontWeight: FontWeight.w300,
                                                                    color: Colors.black
                                                                        .withOpacity(0.75),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    "abdulmannanijaz99@gmail.com",
                                                                    textAlign: TextAlign.left,
                                                                    style: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          (ResponsiveBreakpoints.of(
                                                                                          context)
                                                                                      .screenWidth <
                                                                                  765)
                                                                              ? 14
                                                                              : 17,
                                                                      fontWeight: FontWeight.w700,
                                                                      color: Colors.black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 50,
                                                      ),
                                                      CustomizableTextField(
                                                        controller: yourNameEditingController,
                                                        hintText: yourNameText,
                                                        focusNode: yourNameFocusNode,
                                                        validator: (value) {
                                                          // if (value!.isEmpty) {
                                                          //   return cnicEmptyValidationText;
                                                          // } else if (value!.length < 15) {
                                                          //   return cnicValidationText;
                                                          // } else {
                                                          return null;
                                                          // }
                                                        },
                                                        onChanged: (value) {
                                                          // ref.read(cnicLoginProvider.notifier).state = value;
                                                        },
                                                        prefixIcon: null,
                                                        suffixIcon: null,
                                                        prefixWidget: null,
                                                        //Prefix Widget != null
                                                        prefixPadding: EdgeInsets.zero,
                                                        suffixPadding: EdgeInsets.symmetric(
                                                          horizontal: 10.w,
                                                          vertical: 16.h,
                                                        ),
                                                        focusedIconColor: Colors.black,
                                                        unfocusedIconColor: Colors.grey,
                                                        hideText: false,
                                                        textInputType: TextInputType.number,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      CustomizableTextField(
                                                        controller: yourPhoneEditingController,
                                                        hintText: yourPhoneText,
                                                        focusNode: yourPhoneFocusNode,
                                                        validator: (value) {
                                                          // if (value!.isEmpty) {
                                                          //   return cnicEmptyValidationText;
                                                          // } else if (value!.length < 15) {
                                                          //   return cnicValidationText;
                                                          // } else {
                                                          return null;
                                                          // }
                                                        },
                                                        onChanged: (value) {
                                                          // ref.read(cnicLoginProvider.notifier).state = value;
                                                        },
                                                        prefixIcon: null,
                                                        suffixIcon: null,
                                                        prefixWidget: null,
                                                        //Prefix Widget != null
                                                        prefixPadding: EdgeInsets.zero,
                                                        suffixPadding: EdgeInsets.symmetric(
                                                          horizontal: 10.w,
                                                          vertical: 16.h,
                                                        ),
                                                        focusedIconColor: Colors.black,
                                                        unfocusedIconColor: Colors.grey,
                                                        hideText: false,
                                                        textInputType: TextInputType.number,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      CustomizableTextField(
                                                        controller: yourEmailEditingController,
                                                        hintText: yourEmailText,
                                                        focusNode: yourEmailFocusNode,
                                                        validator: (value) {
                                                          // if (value!.isEmpty) {
                                                          //   return cnicEmptyValidationText;
                                                          // } else if (value!.length < 15) {
                                                          //   return cnicValidationText;
                                                          // } else {
                                                          return null;
                                                          // }
                                                        },
                                                        onChanged: (value) {
                                                          // ref.read(cnicLoginProvider.notifier).state = value;
                                                        },
                                                        prefixIcon: null,
                                                        suffixIcon: null,
                                                        prefixWidget: null,
                                                        //Prefix Widget != null
                                                        prefixPadding: EdgeInsets.zero,
                                                        suffixPadding: EdgeInsets.symmetric(
                                                          horizontal: 10.w,
                                                          vertical: 16.h,
                                                        ),
                                                        focusedIconColor: Colors.black,
                                                        unfocusedIconColor: Colors.grey,
                                                        hideText: false,
                                                        textInputType: TextInputType.number,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      CustomizableTextField(
                                                        controller: yourMessageEditingController,
                                                        hintText: yourMessageText,
                                                        focusNode: yourMessageFocusNode,
                                                        validator: (value) {
                                                          // if (value!.isEmpty) {
                                                          //   return cnicEmptyValidationText;
                                                          // } else if (value!.length < 15) {
                                                          //   return cnicValidationText;
                                                          // } else {
                                                          return null;
                                                          // }
                                                        },
                                                        onChanged: (value) {
                                                          // ref.read(cnicLoginProvider.notifier).state = value;
                                                        },
                                                        prefixIcon: null,
                                                        suffixIcon: null,
                                                        prefixWidget: null,
                                                        //Prefix Widget != null
                                                        prefixPadding: EdgeInsets.zero,
                                                        suffixPadding: EdgeInsets.symmetric(
                                                          horizontal: 10.w,
                                                          vertical: 16.h,
                                                        ),
                                                        focusedIconColor: Colors.black,
                                                        unfocusedIconColor: Colors.grey,
                                                        hideText: false,
                                                        textInputType: TextInputType.number,
                                                        maxLines: 5,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      CustomizableTextButton(
                                                        prefixButtonIcon: null,
                                                        suffixButtonIcon: null,
                                                        isFullWidth: false,
                                                        isOutlined: false,
                                                        buttonTitle: "Submit Now".toUpperCase(),
                                                        onPressed: () async {},
                                                        buttonTitleStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        buttonBorderRadius: 60,
                                                        buttonColor: primaryColor,
                                                        horizontalPadding: 40,
                                                        verticalPadding: 16,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width:
                                                    (ResponsiveBreakpoints.of(context).screenWidth <
                                                            770)
                                                        ? 516
                                                        : 696,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    GradientText(
                                                      "Let's Say Hi",
                                                      style: GoogleFonts.montserrat(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      colors: [
                                                        gradientColor1,
                                                        gradientColor2,
                                                        gradientColor3,
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 12.h,
                                                    ),
                                                    Text(
                                                      "Contact With Us",
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts.poppins(
                                                        fontSize: (ResponsiveBreakpoints.of(context)
                                                                    .screenWidth <
                                                                765)
                                                            ? 16
                                                            : 50,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black.withOpacity(0.75),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 26.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "Call us directly: ",
                                                                textAlign: TextAlign.left,
                                                                style: GoogleFonts.poppins(
                                                                  fontSize:
                                                                      (ResponsiveBreakpoints.of(
                                                                                      context)
                                                                                  .screenWidth <
                                                                              765)
                                                                          ? 16
                                                                          : 14,
                                                                  fontWeight: FontWeight.w300,
                                                                  color: Colors.black
                                                                      .withOpacity(0.75),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  "+111 227 228 222",
                                                                  textAlign: TextAlign.left,
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        (ResponsiveBreakpoints.of(
                                                                                        context)
                                                                                    .screenWidth <
                                                                                765)
                                                                            ? 14
                                                                            : 17,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: Colors.black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "Contact Email: ",
                                                                textAlign: TextAlign.left,
                                                                style: GoogleFonts.poppins(
                                                                  fontSize:
                                                                      (ResponsiveBreakpoints.of(
                                                                                      context)
                                                                                  .screenWidth <
                                                                              765)
                                                                          ? 16
                                                                          : 14,
                                                                  fontWeight: FontWeight.w300,
                                                                  color: Colors.black
                                                                      .withOpacity(0.75),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  "abdulmannanijaz99@gmail.com",
                                                                  textAlign: TextAlign.left,
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        (ResponsiveBreakpoints.of(
                                                                                        context)
                                                                                    .screenWidth <
                                                                                765)
                                                                            ? 14
                                                                            : 17,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: Colors.black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    CustomizableTextField(
                                                      controller: yourNameEditingController,
                                                      hintText: yourNameText,
                                                      focusNode: yourNameFocusNode,
                                                      validator: (value) {
                                                        // if (value!.isEmpty) {
                                                        //   return cnicEmptyValidationText;
                                                        // } else if (value!.length < 15) {
                                                        //   return cnicValidationText;
                                                        // } else {
                                                        return null;
                                                        // }
                                                      },
                                                      onChanged: (value) {
                                                        // ref.read(cnicLoginProvider.notifier).state = value;
                                                      },
                                                      prefixIcon: null,
                                                      suffixIcon: null,
                                                      prefixWidget: null,
                                                      //Prefix Widget != null
                                                      prefixPadding: EdgeInsets.zero,
                                                      suffixPadding: EdgeInsets.symmetric(
                                                        horizontal: 10.w,
                                                        vertical: 16.h,
                                                      ),
                                                      focusedIconColor: Colors.black,
                                                      unfocusedIconColor: Colors.grey,
                                                      hideText: false,
                                                      textInputType: TextInputType.number,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    CustomizableTextField(
                                                      controller: yourPhoneEditingController,
                                                      hintText: yourPhoneText,
                                                      focusNode: yourPhoneFocusNode,
                                                      validator: (value) {
                                                        // if (value!.isEmpty) {
                                                        //   return cnicEmptyValidationText;
                                                        // } else if (value!.length < 15) {
                                                        //   return cnicValidationText;
                                                        // } else {
                                                        return null;
                                                        // }
                                                      },
                                                      onChanged: (value) {
                                                        // ref.read(cnicLoginProvider.notifier).state = value;
                                                      },
                                                      prefixIcon: null,
                                                      suffixIcon: null,
                                                      prefixWidget: null,
                                                      //Prefix Widget != null
                                                      prefixPadding: EdgeInsets.zero,
                                                      suffixPadding: EdgeInsets.symmetric(
                                                        horizontal: 10.w,
                                                        vertical: 16.h,
                                                      ),
                                                      focusedIconColor: Colors.black,
                                                      unfocusedIconColor: Colors.grey,
                                                      hideText: false,
                                                      textInputType: TextInputType.number,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    CustomizableTextField(
                                                      controller: yourEmailEditingController,
                                                      hintText: yourEmailText,
                                                      focusNode: yourEmailFocusNode,
                                                      validator: (value) {
                                                        // if (value!.isEmpty) {
                                                        //   return cnicEmptyValidationText;
                                                        // } else if (value!.length < 15) {
                                                        //   return cnicValidationText;
                                                        // } else {
                                                        return null;
                                                        // }
                                                      },
                                                      onChanged: (value) {
                                                        // ref.read(cnicLoginProvider.notifier).state = value;
                                                      },
                                                      prefixIcon: null,
                                                      suffixIcon: null,
                                                      prefixWidget: null,
                                                      //Prefix Widget != null
                                                      prefixPadding: EdgeInsets.zero,
                                                      suffixPadding: EdgeInsets.symmetric(
                                                        horizontal: 10.w,
                                                        vertical: 16.h,
                                                      ),
                                                      focusedIconColor: Colors.black,
                                                      unfocusedIconColor: Colors.grey,
                                                      hideText: false,
                                                      textInputType: TextInputType.number,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    CustomizableTextField(
                                                      controller: yourMessageEditingController,
                                                      hintText: yourMessageText,
                                                      focusNode: yourMessageFocusNode,
                                                      validator: (value) {
                                                        // if (value!.isEmpty) {
                                                        //   return cnicEmptyValidationText;
                                                        // } else if (value!.length < 15) {
                                                        //   return cnicValidationText;
                                                        // } else {
                                                        return null;
                                                        // }
                                                      },
                                                      onChanged: (value) {
                                                        // ref.read(cnicLoginProvider.notifier).state = value;
                                                      },
                                                      prefixIcon: null,
                                                      suffixIcon: null,
                                                      prefixWidget: null,
                                                      //Prefix Widget != null
                                                      prefixPadding: EdgeInsets.zero,
                                                      suffixPadding: EdgeInsets.symmetric(
                                                        horizontal: 10.w,
                                                        vertical: 16.h,
                                                      ),
                                                      focusedIconColor: Colors.black,
                                                      unfocusedIconColor: Colors.grey,
                                                      hideText: false,
                                                      textInputType: TextInputType.number,
                                                      maxLines: 5,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    CustomizableTextButton(
                                                      prefixButtonIcon: null,
                                                      suffixButtonIcon: null,
                                                      isFullWidth: false,
                                                      isOutlined: false,
                                                      buttonTitle: "Submit Now".toUpperCase(),
                                                      onPressed: () async {},
                                                      buttonTitleStyle: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      buttonBorderRadius: 60,
                                                      buttonColor: primaryColor,
                                                      horizontalPadding: 40,
                                                      verticalPadding: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width:
                                              (ResponsiveBreakpoints.of(context).screenWidth < 1280)
                                                  ? 452
                                                  : 633,
                                          padding: EdgeInsets.symmetric(horizontal: 15),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              GradientText(
                                                "Let's Say Hi",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                colors: [
                                                  gradientColor1,
                                                  gradientColor2,
                                                  gradientColor3,
                                                ],
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              Text(
                                                "Contact With Us",
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontSize: (ResponsiveBreakpoints.of(context)
                                                              .screenWidth <
                                                          765)
                                                      ? 16
                                                      : 50,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black.withOpacity(0.75),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 26.h,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Call us directly: ",
                                                          textAlign: TextAlign.left,
                                                          style: GoogleFonts.poppins(
                                                            fontSize:
                                                                (ResponsiveBreakpoints.of(context)
                                                                            .screenWidth <
                                                                        765)
                                                                    ? 16
                                                                    : 14,
                                                            fontWeight: FontWeight.w300,
                                                            color: Colors.black.withOpacity(0.75),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "+111 227 228 222",
                                                            textAlign: TextAlign.left,
                                                            style: GoogleFonts.poppins(
                                                              fontSize:
                                                                  (ResponsiveBreakpoints.of(context)
                                                                              .screenWidth <
                                                                          765)
                                                                      ? 14
                                                                      : 17,
                                                              fontWeight: FontWeight.w700,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Contact Email: ",
                                                          textAlign: TextAlign.left,
                                                          style: GoogleFonts.poppins(
                                                            fontSize:
                                                                (ResponsiveBreakpoints.of(context)
                                                                            .screenWidth <
                                                                        765)
                                                                    ? 16
                                                                    : 14,
                                                            fontWeight: FontWeight.w300,
                                                            color: Colors.black.withOpacity(0.75),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "abdulmannanijaz99@gmail.com",
                                                            textAlign: TextAlign.left,
                                                            style: GoogleFonts.poppins(
                                                              fontSize:
                                                                  (ResponsiveBreakpoints.of(context)
                                                                              .screenWidth <
                                                                          765)
                                                                      ? 14
                                                                      : 17,
                                                              fontWeight: FontWeight.w700,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              CustomizableTextField(
                                                controller: yourNameEditingController,
                                                hintText: yourNameText,
                                                focusNode: yourNameFocusNode,
                                                validator: (value) {
                                                  // if (value!.isEmpty) {
                                                  //   return cnicEmptyValidationText;
                                                  // } else if (value!.length < 15) {
                                                  //   return cnicValidationText;
                                                  // } else {
                                                  return null;
                                                  // }
                                                },
                                                onChanged: (value) {
                                                  // ref.read(cnicLoginProvider.notifier).state = value;
                                                },
                                                prefixIcon: null,
                                                suffixIcon: null,
                                                prefixWidget: null,
                                                //Prefix Widget != null
                                                prefixPadding: EdgeInsets.zero,
                                                suffixPadding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 16.h,
                                                ),
                                                focusedIconColor: Colors.black,
                                                unfocusedIconColor: Colors.grey,
                                                hideText: false,
                                                textInputType: TextInputType.number,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              CustomizableTextField(
                                                controller: yourPhoneEditingController,
                                                hintText: yourPhoneText,
                                                focusNode: yourPhoneFocusNode,
                                                validator: (value) {
                                                  // if (value!.isEmpty) {
                                                  //   return cnicEmptyValidationText;
                                                  // } else if (value!.length < 15) {
                                                  //   return cnicValidationText;
                                                  // } else {
                                                  return null;
                                                  // }
                                                },
                                                onChanged: (value) {
                                                  // ref.read(cnicLoginProvider.notifier).state = value;
                                                },
                                                prefixIcon: null,
                                                suffixIcon: null,
                                                prefixWidget: null,
                                                //Prefix Widget != null
                                                prefixPadding: EdgeInsets.zero,
                                                suffixPadding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 16.h,
                                                ),
                                                focusedIconColor: Colors.black,
                                                unfocusedIconColor: Colors.grey,
                                                hideText: false,
                                                textInputType: TextInputType.number,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              CustomizableTextField(
                                                controller: yourEmailEditingController,
                                                hintText: yourEmailText,
                                                focusNode: yourEmailFocusNode,
                                                validator: (value) {
                                                  // if (value!.isEmpty) {
                                                  //   return cnicEmptyValidationText;
                                                  // } else if (value!.length < 15) {
                                                  //   return cnicValidationText;
                                                  // } else {
                                                  return null;
                                                  // }
                                                },
                                                onChanged: (value) {
                                                  // ref.read(cnicLoginProvider.notifier).state = value;
                                                },
                                                prefixIcon: null,
                                                suffixIcon: null,
                                                prefixWidget: null,
                                                //Prefix Widget != null
                                                prefixPadding: EdgeInsets.zero,
                                                suffixPadding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 16.h,
                                                ),
                                                focusedIconColor: Colors.black,
                                                unfocusedIconColor: Colors.grey,
                                                hideText: false,
                                                textInputType: TextInputType.number,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              CustomizableTextField(
                                                controller: yourMessageEditingController,
                                                hintText: yourMessageText,
                                                focusNode: yourMessageFocusNode,
                                                validator: (value) {
                                                  // if (value!.isEmpty) {
                                                  //   return cnicEmptyValidationText;
                                                  // } else if (value!.length < 15) {
                                                  //   return cnicValidationText;
                                                  // } else {
                                                  return null;
                                                  // }
                                                },
                                                onChanged: (value) {
                                                  // ref.read(cnicLoginProvider.notifier).state = value;
                                                },
                                                prefixIcon: null,
                                                suffixIcon: null,
                                                prefixWidget: null,
                                                //Prefix Widget != null
                                                prefixPadding: EdgeInsets.zero,
                                                suffixPadding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 16.h,
                                                ),
                                                focusedIconColor: Colors.black,
                                                unfocusedIconColor: Colors.grey,
                                                hideText: false,
                                                textInputType: TextInputType.number,
                                                maxLines: 5,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              CustomizableTextButton(
                                                prefixButtonIcon: null,
                                                suffixButtonIcon: null,
                                                isFullWidth: false,
                                                isOutlined: false,
                                                buttonTitle: "Submit Now".toUpperCase(),
                                                onPressed: () async {},
                                                buttonTitleStyle: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                buttonBorderRadius: 60,
                                                buttonColor: primaryColor,
                                                horizontalPadding: 40,
                                                verticalPadding: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          height:
                                              (ResponsiveBreakpoints.of(context).screenWidth < 1280)
                                                  ? 524
                                                  : 696,
                                          width:
                                              (ResponsiveBreakpoints.of(context).screenWidth < 1280)
                                                  ? 452
                                                  : 633,
                                          padding: EdgeInsets.symmetric(horizontal: 15),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(aboutImage),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ],
                                    ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Container(
                          width: /*(ResponsiveBreakpoints.of(context).screenWidth < 1270)
                              ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                  ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                      ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                          ? 479
                                          : 546
                                      : 726
                                  : 966
                              : */
                              1266,
                          padding: EdgeInsets.symmetric(vertical: 120),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GradientText(
                                "Top Clients",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                colors: [
                                  gradientColor1,
                                  gradientColor2,
                                  gradientColor3,
                                ],
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                "We worked with brands",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                      ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                          ? 32
                                          : 40
                                      : 50,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.75),
                                ),
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              Container(
                                child: Wrap(
                                  spacing: 30,
                                  runSpacing: 30,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    clientsImageWidget(image: brand1Image),
                                    clientsImageWidget(image: brand2Image),
                                    clientsImageWidget(image: brand3Image),
                                    clientsImageWidget(image: brand1Image),
                                    clientsImageWidget(image: brand2Image),
                                    clientsImageWidget(image: brand3Image),
                                    clientsImageWidget(image: brand1Image),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal:
                                (ResponsiveBreakpoints.of(context).screenWidth < 575) ? 0 : 50),
                        color: Colors.black,
                        child: (ResponsiveBreakpoints.of(context).screenWidth < 990)
                            ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                ? Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    logoImage,
                                                    height: 50,
                                                    width: 100,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: Icon(
                                                      FontAwesomeIcons.facebookF,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                    suffixButtonIcon: null,
                                                    isFullWidth: false,
                                                    isOutlined: true,
                                                    buttonTitle: null,
                                                    onPressed: () async {},
                                                    buttonTitleStyle: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    buttonBorderRadius: 60,
                                                    buttonColor: primaryColor,
                                                    horizontalPadding: 40,
                                                    verticalPadding: 16,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: Icon(
                                                      FontAwesomeIcons.linkedinIn,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                    suffixButtonIcon: null,
                                                    isFullWidth: false,
                                                    isOutlined: true,
                                                    buttonTitle: null,
                                                    onPressed: () async {},
                                                    buttonTitleStyle: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    buttonBorderRadius: 60,
                                                    buttonColor: primaryColor,
                                                    horizontalPadding: 40,
                                                    verticalPadding: 16,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: Icon(
                                                      FontAwesomeIcons.twitter,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                    suffixButtonIcon: null,
                                                    isFullWidth: false,
                                                    isOutlined: true,
                                                    buttonTitle: null,
                                                    onPressed: () async {},
                                                    buttonTitleStyle: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    buttonBorderRadius: 60,
                                                    buttonColor: primaryColor,
                                                    horizontalPadding: 40,
                                                    verticalPadding: 16,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: Icon(
                                                      FontAwesomeIcons.instagram,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                    suffixButtonIcon: null,
                                                    isFullWidth: false,
                                                    isOutlined: true,
                                                    buttonTitle: null,
                                                    onPressed: () async {},
                                                    buttonTitleStyle: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    buttonBorderRadius: 60,
                                                    buttonColor: primaryColor,
                                                    horizontalPadding: 40,
                                                    verticalPadding: 16,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Copyright © 2024 Rainbow-Themes. All Rights Reserved",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w300,
                                                      color: Colors.white.withOpacity(0.75),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    logoImage,
                                                    height: (ResponsiveBreakpoints.of(context)
                                                                .screenWidth <
                                                            750)
                                                        ? 40
                                                        : 50,
                                                    width: (ResponsiveBreakpoints.of(context)
                                                                .screenWidth <
                                                            750)
                                                        ? 68
                                                        : 100,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: Icon(
                                                      FontAwesomeIcons.facebookF,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                    suffixButtonIcon: null,
                                                    isFullWidth: false,
                                                    isOutlined: true,
                                                    buttonTitle: null,
                                                    onPressed: () async {},
                                                    buttonTitleStyle: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    buttonBorderRadius: 60,
                                                    buttonColor: primaryColor,
                                                    horizontalPadding: 40,
                                                    verticalPadding: 16,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: Icon(
                                                      FontAwesomeIcons.linkedinIn,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                    suffixButtonIcon: null,
                                                    isFullWidth: false,
                                                    isOutlined: true,
                                                    buttonTitle: null,
                                                    onPressed: () async {},
                                                    buttonTitleStyle: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    buttonBorderRadius: 60,
                                                    buttonColor: primaryColor,
                                                    horizontalPadding: 40,
                                                    verticalPadding: 16,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: Icon(
                                                      FontAwesomeIcons.twitter,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                    suffixButtonIcon: null,
                                                    isFullWidth: false,
                                                    isOutlined: true,
                                                    buttonTitle: null,
                                                    onPressed: () async {},
                                                    buttonTitleStyle: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    buttonBorderRadius: 60,
                                                    buttonColor: primaryColor,
                                                    horizontalPadding: 40,
                                                    verticalPadding: 16,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: Icon(
                                                      FontAwesomeIcons.instagram,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                    suffixButtonIcon: null,
                                                    isFullWidth: false,
                                                    isOutlined: true,
                                                    buttonTitle: null,
                                                    onPressed: () async {},
                                                    buttonTitleStyle: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    buttonBorderRadius: 60,
                                                    buttonColor: primaryColor,
                                                    horizontalPadding: 40,
                                                    verticalPadding: 16,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height:
                                                  (ResponsiveBreakpoints.of(context).screenWidth <
                                                          750)
                                                      ? 40
                                                      : 50,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Copyright © 2024 Rainbow-Themes. All Rights Reserved",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w300,
                                                      color: Colors.white.withOpacity(0.75),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                            : Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            logoImage,
                                            height: (ResponsiveBreakpoints.of(context).screenWidth <
                                                    750)
                                                ? 40
                                                : 50,
                                            width: (ResponsiveBreakpoints.of(context).screenWidth <
                                                    750)
                                                ? 68
                                                : 100,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomizableTextButton(
                                            prefixButtonIcon: Icon(
                                              FontAwesomeIcons.facebookF,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            suffixButtonIcon: null,
                                            isFullWidth: false,
                                            isOutlined: true,
                                            buttonTitle: null,
                                            onPressed: () async {},
                                            buttonTitleStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            buttonBorderRadius: 60,
                                            buttonColor: primaryColor,
                                            horizontalPadding: 40,
                                            verticalPadding: 16,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          CustomizableTextButton(
                                            prefixButtonIcon: Icon(
                                              FontAwesomeIcons.linkedinIn,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            suffixButtonIcon: null,
                                            isFullWidth: false,
                                            isOutlined: true,
                                            buttonTitle: null,
                                            onPressed: () async {},
                                            buttonTitleStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            buttonBorderRadius: 60,
                                            buttonColor: primaryColor,
                                            horizontalPadding: 40,
                                            verticalPadding: 16,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          CustomizableTextButton(
                                            prefixButtonIcon: Icon(
                                              FontAwesomeIcons.twitter,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            suffixButtonIcon: null,
                                            isFullWidth: false,
                                            isOutlined: true,
                                            buttonTitle: null,
                                            onPressed: () async {},
                                            buttonTitleStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            buttonBorderRadius: 60,
                                            buttonColor: primaryColor,
                                            horizontalPadding: 40,
                                            verticalPadding: 16,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          CustomizableTextButton(
                                            prefixButtonIcon: Icon(
                                              FontAwesomeIcons.instagram,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            suffixButtonIcon: null,
                                            isFullWidth: false,
                                            isOutlined: true,
                                            buttonTitle: null,
                                            onPressed: () async {},
                                            buttonTitleStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            buttonBorderRadius: 60,
                                            buttonColor: primaryColor,
                                            horizontalPadding: 40,
                                            verticalPadding: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: (ResponsiveBreakpoints.of(context).screenWidth < 750)
                                          ? 40
                                          : 50,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Copyright © 2024 Rainbow-Themes. All Rights Reserved",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white.withOpacity(0.75),
                                            ),
                                          ),
                                        ],
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
            ],
          ),
        ),
      ),
    );
  }

  Widget clientsImageWidget({required String image}) {
    return Container(
      padding: EdgeInsets.all(25),
      child: Image.asset(
        image,
        height: (ResponsiveBreakpoints.of(context).screenWidth < 1200)
            ? (ResponsiveBreakpoints.of(context).screenWidth < 970)
                ? (ResponsiveBreakpoints.of(context).screenWidth < 740)
                    ? 50
                    : 70
                : 80
            : 110,
      ),
    );
  }

  Widget companyGrowthWidget({required Widget icon, required int scores, required String title}) {
    return (ResponsiveBreakpoints.of(context).screenWidth < 575)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 280,
                    width: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                        ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                            ? 243
                            : 211
                        : 286,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon,
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "$scores +",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize:
                                (ResponsiveBreakpoints.of(context).screenWidth < 1250) ? 44 : 54,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.75),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          title,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize:
                                (ResponsiveBreakpoints.of(context).screenWidth < 765) ? 16 : 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.75),
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
            height: 280,
            width: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                    ? 243
                    : 211
                : 286,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                SizedBox(
                  height: 20,
                ),
                Text(
                  "$scores +",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 1250) ? 44 : 54,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.75),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 765) ? 16 : 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.75),
                  ),
                ),
              ],
            ),
          );
  }

  Widget activeIndicator() {
    return Container(
      padding: EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: primaryColor,
      ),
      child: Container(
        height: 8,
        width: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget inActiveIndicator() {
    return Container(
      height: 6,
      width: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
    );
  }

  Widget aboutUsTitleDescription({required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
            fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 765) ? 16 : 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          description,
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
            fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 765) ? 16 : 18,
            fontWeight: FontWeight.w300,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget drawerNavButton({required String title, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget navButton({required String title, required VoidCallback onPressed, Color? textColor}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 66.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    color: textColor ?? Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget serviceWidget(
      {required VoidCallback onPressed,
      required String title,
      required String content,
      required Widget icon}) {
    return Container(
      height: (ResponsiveBreakpoints.of(context).screenWidth < 1200)
          ? (ResponsiveBreakpoints.of(context).screenWidth < 985)
              ? (ResponsiveBreakpoints.of(context).screenWidth < 765)
                  ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                      ? 238
                      : 332
                  : 264
              : 336
          : 286,
      width: (ResponsiveBreakpoints.of(context).screenWidth < 1200)
          ? (ResponsiveBreakpoints.of(context).screenWidth < 985)
              ? (ResponsiveBreakpoints.of(context).screenWidth < 765)
                  ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                      ? 550
                      : 243
                  : 333
              : 300
          : 380,
      padding: EdgeInsets.symmetric(
          horizontal: (ResponsiveBreakpoints.of(context).screenWidth < 575) ? 23 : 30,
          vertical: (ResponsiveBreakpoints.of(context).screenWidth < 575) ? 32 : 40),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          SizedBox(
            height: (ResponsiveBreakpoints.of(context).screenWidth < 985)
                ? (ResponsiveBreakpoints.of(context).screenWidth < 765)
                    ? 22
                    : 10
                : 22,
          ),
          Text(
            title,
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: (ResponsiveBreakpoints.of(context).screenWidth < 985)
                ? (ResponsiveBreakpoints.of(context).screenWidth < 765)
                    ? 20
                    : 8
                : 20,
          ),
          Text(
            content,
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 765) ? 16 : 18,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
