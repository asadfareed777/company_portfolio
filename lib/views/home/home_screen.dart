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
  final targetKey = GlobalKey();
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


  final List<Map<String, String>> portfolioItems = [
    {
      "stackName": "Flutter",
      "projectName": "Kuwait Mushaf - Quranic Android App",
      "explanation":
      "Developed using Flutter, Kuwait Mushaf is a comprehensive Quran app designed for an enriching and personalized experience. The app offers full Quran text with audio recitations from various renowned reciters. Users can explore translations in multiple languages, access detailed Tafseer from different scholars, and study the 10 readings of Quranic verses with highlighted wordings and pronunciation guides. Additionally, the app allows users to download complete recitations and customize the app's language and appearance through a robust settings screen."
    },
    {
      "stackName": "Java & Kotlin",
      "projectName": "Urbie - IoT-Based Home Automation App",
      "explanation":
      "Developed using Java and Kotlin, Urbie is a sophisticated IoT-based Android app designed for seamless home automation. The app enables users to control various home appliances, including fans, LEDs, and water tank levels. Leveraging AWS MQTT services for real-time cloud control and robust databases for storing current device statuses, Urbie provides a reliable and user-friendly solution for modern smart home management."
    },
  ];
  final List<Map<String, String>> whyChooseUsItems = [
    {
      "title": "Customized Solutions",
      "image": customizedSolution,
      "description": "At the heart of our service philosophy is the belief that every business is unique, with its own set of challenges and goals. We don’t believe in one-size-fits-all solutions. Instead, we take the time to understand your specific needs, industry dynamics, and operational intricacies. By tailoring our strategies and solutions to align with your business objectives, we ensure that the outcomes not only meet but exceed your expectations. Our bespoke approach allows us to deliver results that drive tangible value, setting your business apart from the competition.",
    },
    {
      "title": "Proven Track Record",
      "image": provenTrackRecord,
      "description": "Over the years, we have built a strong reputation for delivering high-quality solutions that consistently meet the demands of various industries. Our extensive portfolio showcases our ability to solve complex challenges and create innovative solutions that stand the test of time. Whether it’s in technology, finance, healthcare, or any other sector, our track record demonstrates our commitment to excellence and our capability to drive success for our clients. Each project we undertake is a testament to our expertise, creativity, and dedication to delivering exceptional results.",

    },
    {
      "title": "Client-Centric Approach",
      "image": clientCentricSolution,
      "description": "Our clients are at the core of everything we do. We believe that the key to a successful partnership lies in open communication, mutual respect, and a deep understanding of our clients' needs. We take a collaborative approach, working closely with you at every stage of the project to ensure that our solutions are perfectly aligned with your vision and goals. By prioritizing your success and putting your needs first, we build long-lasting relationships based on trust, transparency, and shared achievements. Your success is our success, and we are committed to going above and beyond to ensure it.",

    },
    {
      "title": "Scalable and Secure Solutions",
      "image": secureSolution,
      "description": "In today's fast-paced and ever-changing business environment, scalability and security are more important than ever. Our solutions are designed with these principles at their core. We create systems that can grow and adapt with your business, ensuring they remain effective as your needs evolve. At the same time, we place a strong emphasis on security, protecting your data and assets with the latest technologies and best practices. This dual focus on scalability and security ensures that our solutions not only meet your current needs but also position you for long-term success in a secure and sustainable way.",

    },
  ];


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
                        logoImageInvertedTechnology,
                        height: (ResponsiveBreakpoints.of(context).screenWidth <
                                750)
                            ? 50
                            : 56,
                        width: (ResponsiveBreakpoints.of(context).screenWidth <
                                750)
                            ? 50
                            : 56,
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
                  title: "Target",
                  onPressed: () async {
                    Navigator.pop(context);
                    await Scrollable.ensureVisible(targetKey.currentContext!,
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
                      horizontal: ResponsiveBreakpoints.of(context)
                              .largerOrEqualTo(DESKTOP)
                          ? 50
                          : 15,
                      vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        logoImageInvertedTechnology,
                        height: (ResponsiveBreakpoints.of(context).screenWidth <
                                750)
                            ? 50
                            : 60,
                        width: (ResponsiveBreakpoints.of(context).screenWidth <
                                750)
                            ? 100
                            : 132,
                      ),
                      Row(
                        children: [
                          Visibility(
                            visible: !(ResponsiveBreakpoints.of(context)
                                    .screenWidth <
                                1036),
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  navButton(
                                    title: "Home",
                                    textColor: Colors.black,
                                    onPressed: () async {
                                      await Scrollable.ensureVisible(
                                          homeKey.currentContext!,
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          curve:
                                              Curves.fastEaseInToSlowEaseOut);
                                    },
                                  ),
                                  navButton(
                                    title: "Service",
                                    textColor: Colors.black,
                                    onPressed: () async {
                                      await Scrollable.ensureVisible(
                                          servicesKey.currentContext!,
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          curve:
                                              Curves.fastEaseInToSlowEaseOut);
                                    },
                                  ),
                                  navButton(
                                    title: "About",
                                    textColor: Colors.black,
                                    onPressed: () async {
                                      await Scrollable.ensureVisible(
                                          aboutKey.currentContext!,
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          curve:
                                              Curves.fastEaseInToSlowEaseOut);
                                    },
                                  ),
                                  navButton(
                                    title: "Portfolio",
                                    textColor: Colors.black,
                                    onPressed: () async {
                                      await Scrollable.ensureVisible(
                                          portfolioKey.currentContext!,
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          curve:
                                              Curves.fastEaseInToSlowEaseOut);
                                    },
                                  ),
                                  navButton(
                                    title: "Target",
                                    textColor: Colors.black,
                                    onPressed: () async {
                                      await Scrollable.ensureVisible(
                                          targetKey.currentContext!,
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          curve:
                                          Curves.fastEaseInToSlowEaseOut);
                                    },
                                  ),
                                  navButton(
                                    title: "Blog",
                                    textColor: Colors.black,
                                    onPressed: () async {
                                      await Scrollable.ensureVisible(
                                          blogKey.currentContext!,
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          curve:
                                              Curves.fastEaseInToSlowEaseOut);
                                    },
                                  ),
                                  navButton(
                                    title: "Contact",
                                    textColor: Colors.black,
                                    onPressed: () async {
                                      await Scrollable.ensureVisible(
                                          contactUsKey.currentContext!,
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          curve:
                                              Curves.fastEaseInToSlowEaseOut);
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
                                visible: ResponsiveBreakpoints.of(context)
                                        .screenWidth <
                                    1036,
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
                        height: (ResponsiveBreakpoints.of(context).screenWidth <
                                1000)
                            ? (ResponsiveBreakpoints.of(context).screenWidth <
                                    760)
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
                                  var visiblePercentage =
                                      visibilityInfo.visibleFraction * 100;
                                  debugPrint(
                                      'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          ResponsiveBreakpoints.of(context)
                                                  .largerOrEqualTo(DESKTOP)
                                              ? 50
                                              : 15,
                                      vertical: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        logoImageInvertedTechnology,
                                        height:
                                            (ResponsiveBreakpoints.of(context)
                                                        .screenWidth <
                                                    750)
                                                ? 50
                                                : 60,
                                        width:
                                            (ResponsiveBreakpoints.of(context)
                                                        .screenWidth <
                                                    750)
                                                ? 100
                                                : 132,
                                      ),
                                      Row(
                                        children: [
                                          Visibility(
                                            visible: !(ResponsiveBreakpoints.of(
                                                        context)
                                                    .screenWidth <
                                                1036),
                                            child: Container(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  navButton(
                                                    title: "Home",
                                                    onPressed: () async {
                                                      await Scrollable.ensureVisible(
                                                          homeKey
                                                              .currentContext!,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      1000),
                                                          curve: Curves
                                                              .fastEaseInToSlowEaseOut);
                                                    },
                                                  ),
                                                  navButton(
                                                    title: "Service",
                                                    onPressed: () async {
                                                      await Scrollable.ensureVisible(
                                                          servicesKey
                                                              .currentContext!,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      1000),
                                                          curve: Curves
                                                              .fastEaseInToSlowEaseOut);
                                                    },
                                                  ),
                                                  navButton(
                                                    title: "About",
                                                    onPressed: () async {
                                                      await Scrollable.ensureVisible(
                                                          aboutKey
                                                              .currentContext!,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      1000),
                                                          curve: Curves
                                                              .fastEaseInToSlowEaseOut);
                                                    },
                                                  ),
                                                  navButton(
                                                    title: "Portfolio",
                                                    onPressed: () async {
                                                      await Scrollable.ensureVisible(
                                                          portfolioKey
                                                              .currentContext!,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      1000),
                                                          curve: Curves
                                                              .fastEaseInToSlowEaseOut);
                                                    },
                                                  ),
                                                  navButton(
                                                    title: "Target",
                                                    onPressed: () async {
                                                      await Scrollable.ensureVisible(
                                                          targetKey
                                                              .currentContext!,
                                                          duration:
                                                          const Duration(
                                                              milliseconds:
                                                              1000),
                                                          curve: Curves
                                                              .fastEaseInToSlowEaseOut);
                                                    },
                                                  ),

                                                  navButton(
                                                    title: "Blog",
                                                    onPressed: () async {
                                                      await Scrollable.ensureVisible(
                                                          blogKey
                                                              .currentContext!,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      1000),
                                                          curve: Curves
                                                              .fastEaseInToSlowEaseOut);
                                                    },
                                                  ),
                                                  navButton(
                                                    title: "Contact",
                                                    onPressed: () async {
                                                      await Scrollable.ensureVisible(
                                                          contactUsKey
                                                              .currentContext!,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      1000),
                                                          curve: Curves
                                                              .fastEaseInToSlowEaseOut);
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
                                                width: ResponsiveBreakpoints.of(
                                                            context)
                                                        .largerOrEqualTo(
                                                            DESKTOP)
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
                                                    ResponsiveBreakpoints.of(
                                                                context)
                                                            .screenWidth <
                                                        1036,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: InkWell(
                                                    onTap: () {
                                                      _scaffoldKey.currentState
                                                          ?.openDrawer();
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
                                padding: EdgeInsets.symmetric(horizontal: 80.w),
                                child: Column(
                                  children: [
                                    SizedBox(height: 60.h),
                                    GradientText(
                                      "Welcome to InvertedTech",
                                      style: GoogleFonts.montserrat(
                                        fontSize: (ResponsiveBreakpoints.of(
                                                        context)
                                                    .screenWidth <
                                                1200)
                                            ? (ResponsiveBreakpoints.of(context)
                                                        .screenWidth <
                                                    1000)
                                                ? (ResponsiveBreakpoints.of(
                                                                context)
                                                            .screenWidth <
                                                        765)
                                                    ? 20
                                                    : 40
                                                : 54
                                            : 74,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      colors: [
                                        gradientColor1,
                                        gradientColor2,
                                        gradientColor3,
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 106.w),
                                      child: Text(
                                        "Innovating the Future of Technology.",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              (ResponsiveBreakpoints.of(context)
                                                          .screenWidth <
                                                      765)
                                                  ? 18
                                                  : 26,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white.withOpacity(0.75),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 80.w),
                                      child: Text(
                                        "At InvertedTech, our vision is to revolutionize the software industry by creating innovative, user-centric solutions that empower businesses to achieve their full potential. As a dynamic software startup, we are committed to leveraging the latest technologies to deliver high-quality, scalable, and secure applications that meet the unique needs of our clients. Our mission is to drive digital transformation across various industries, ensuring our clients stay ahead in a competitive market.",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              (ResponsiveBreakpoints.of(context)
                                                          .screenWidth <
                                                      765)
                                                  ? 13
                                                  : 21,
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
                                      buttonTitle:
                                          Constants.contactUs.toUpperCase(),
                                      onPressed: () async {
                                        await Scrollable.ensureVisible(
                                            contactUsKey.currentContext!,
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            curve:
                                                Curves.fastEaseInToSlowEaseOut);
                                      },
                                      buttonTitleStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      buttonBorderRadius: 60,
                                      buttonColor: primaryColor,
                                      horizontalPadding:
                                          (ResponsiveBreakpoints.of(context)
                                                      .screenWidth <
                                                  1000)
                                              ? 40
                                              : 60,
                                      verticalPadding:
                                          (ResponsiveBreakpoints.of(context)
                                                      .screenWidth <
                                                  1000)
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
                        padding: const EdgeInsets.symmetric(vertical: 120),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              spacing: 20,
                              runSpacing: 20,

                              children: [
                                serviceWidget(
                                  onPressed: () {},
                                  title: "Android Development",
                                  content:
                                      """Our team excels in developing robust and user-friendly Android applications that run smoothly on a wide range of devices. We ensure that our apps are optimized for performance and security, providing a seamless user experience.
Benefits:
Customizable: Tailored to meet specific business needs.
Scalable: Designed to handle increasing user loads.
High Performance: Optimized for speed and efficiency.
Extensive Market Reach: Access to a vast user base on the Android platform.
""",
                                  icon: Image.asset(
                                    androidIcon,
                                    // color: primaryColor,
                                    height: 47,
                                    width: 47,
                                  ),
                                ),
                                serviceWidget(
                                  onPressed: () {},
                                  title: "iOS Development",
                                  content:
                                      """We specialize in creating seamless and intuitive iOS applications that provide an exceptional user experience. Our iOS apps are known for their sleek design and robust functionality, ensuring high user engagement and satisfaction.
Benefits:
High Security: Built with strong security protocols to protect user data.
Excellent Performance: Smooth and responsive user interface.
Premium User Base: Access to a high-value demographic.
Consistency: Consistent performance across all iOS devices.
""",
                                  icon: Image.asset(
                                    appleIcon,
                                    // color: secondaryColor,
                                    height: 47,
                                    width: 47,
                                  ),
                                ),
                                serviceWidget(
                                  onPressed: () {},
                                  title: "Flutter",
                                  content:
                                      """Flutter is a UI toolkit developed by Google for building natively compiled applications for mobile, web, and desktop from a single codebase. We use Flutter to create high-performance apps with beautiful, expressive UIs.
Benefits:
Cross-Platform Development: One codebase for multiple platforms, reducing development time and cost.
High Performance: Native performance with smooth animations.
Expressive and Flexible UI: Customizable widgets for a unique user experience.
Single Codebase: Easier maintenance and updates.
""",
                                  icon: Image.asset(
                                    flutterIcon,
                                    // color: lightBlueColor,
                                    height: 47,
                                    width: 47,
                                  ),
                                ),
                                serviceWidget(
                                  onPressed: () {},
                                  title: "Artificial Intelligence",
                                  content:
                                      """We integrate AI technologies into mobile applications to provide intelligent features such as predictive analytics, natural language processing, and image recognition. Our AI models are designed to enhance user experience and automate complex tasks.
Benefits:
Enhanced User Experience: Personalized recommendations and interactions.
Automation: Automate repetitive tasks, improving efficiency.
Data-Driven Insights: Leverage data for better decision-making.
Advanced Features: Implement cutting-edge functionalities like facial recognition, document verification, and nudity checks.
Specialized AI Models:
Facial Recognition: Secure and accurate user authentication.
Document Verification: Automated verification of user documents.
Nudity Checks: Ensure content compliance and safety.
Technologies Used: TensorFlow, PyTorch, OpenCV.
""",
                                  icon: Image.asset(
                                    artificialIntelligence,
                                    // color: Colors.green,
                                    height: 47,
                                    width: 47,
                                  ),
                                ),
                                // serviceWidget(
                                //   onPressed: () {},
                                //   title: "Marketing & Reporting",
                                //   content:
                                //       "I throw myself down among the tall grass by the stream as I lie close to the earth.",
                                //   icon: SvgPicture.asset(
                                //     marketingReportingIcon,
                                //     color: purpleColor,
                                //     height: 47,
                                //     width: 47,
                                //   ),
                                // ),
                                // serviceWidget(
                                //   onPressed: () {},
                                //   title: "Mobile App Development",
                                //   content:
                                //       "I throw myself down among the tall grass by the stream as I lie close to the earth.",
                                //   icon: SvgPicture.asset(
                                //     mobileAppDevelopmentIcon,
                                //     color: secondaryColor,
                                //     height: 47,
                                //     width: 47,
                                //   ),
                                // ),
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
                              child: (ResponsiveBreakpoints.of(context)
                                          .screenWidth <
                                      990)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        (ResponsiveBreakpoints.of(context)
                                                    .screenWidth <
                                                570)
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        height: (ResponsiveBreakpoints.of(
                                                                        context)
                                                                    .screenWidth <
                                                                770)
                                                            ? 596.h
                                                            : 804,
                                                        width: (ResponsiveBreakpoints.of(
                                                                        context)
                                                                    .screenWidth <
                                                                770)
                                                            ? 516.w
                                                            : 696,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                aboutImage),
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                height:
                                                    (ResponsiveBreakpoints.of(
                                                                    context)
                                                                .screenWidth <
                                                            770)
                                                        ? 596
                                                        : 804,
                                                width:
                                                    (ResponsiveBreakpoints.of(
                                                                    context)
                                                                .screenWidth <
                                                            770)
                                                        ? 516
                                                        : 696,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image:
                                                        AssetImage(aboutImage),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        (ResponsiveBreakpoints.of(context)
                                                    .screenWidth <
                                                570)
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: Container(
                                                  width:
                                                      (ResponsiveBreakpoints.of(
                                                                      context)
                                                                  .screenWidth <
                                                              770)
                                                          ? 516
                                                          : 696,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      GradientText(
                                                        "Read About Us",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: (ResponsiveBreakpoints.of(
                                                                          context)
                                                                      .screenWidth <
                                                                  765)
                                                              ? 16
                                                              : 50,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.75),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 26.h,
                                                      ),
                                                      Text(
                                                        "Our values are the guiding principles that define who we are as a company and how we conduct our business.",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: (ResponsiveBreakpoints.of(
                                                                          context)
                                                                      .screenWidth <
                                                                  765)
                                                              ? 16
                                                              : 18,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.75),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 50,
                                                      ),
                                                      aboutUsTitleDescription(
                                                        title: "Integrity",
                                                        description: "We adhere to the highest ethical standards, ensuring honesty and fairness in every action we take.",
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      aboutUsTitleDescription(
                                                        title: "Innovation",
                                                        description: "We are committed to fostering a culture of creativity and continuous improvement.",
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      aboutUsTitleDescription(
                                                        title: "Excellence",
                                                        description: "We strive for excellence in everything we do, delivering superior results that exceed expectations.",
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      aboutUsTitleDescription(
                                                        title: "Customer Focus",
                                                        description: "Our customers are at the heart of our business, and their success is our top priority.",
                                                      ),
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
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
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
                                                    (ResponsiveBreakpoints.of(
                                                                    context)
                                                                .screenWidth <
                                                            770)
                                                        ? 516
                                                        : 696,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GradientText(
                                                      "Read About Us",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: (ResponsiveBreakpoints.of(
                                                                        context)
                                                                    .screenWidth <
                                                                765)
                                                            ? 16
                                                            : 50,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black
                                                            .withOpacity(0.75),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 26.h,
                                                    ),
                                                    Text(
                                                      "Our values are the guiding principles that define who we are as a company and how we conduct our business.",
                                                      textAlign: TextAlign.left,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: (ResponsiveBreakpoints.of(
                                                                        context)
                                                                    .screenWidth <
                                                                765)
                                                            ? 16
                                                            : 18,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.black
                                                            .withOpacity(0.75),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    aboutUsTitleDescription(
                                                      title: "Integrity",
                                                      description: "We adhere to the highest ethical standards, ensuring honesty and fairness in every action we take.",
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    aboutUsTitleDescription(
                                                      title: "Innovation",
                                                      description: "We are committed to fostering a culture of creativity and continuous improvement.",
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    aboutUsTitleDescription(
                                                      title: "Excellence",
                                                      description: "We strive for excellence in everything we do, delivering superior results that exceed expectations.",
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    aboutUsTitleDescription(
                                                      title: "Customer Focus",
                                                      description: "Our customers are at the heart of our business, and their success is our top priority.",
                                                    ),

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
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                        gradient:
                                                            LinearGradient(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height:
                                              (ResponsiveBreakpoints.of(context)
                                                          .screenWidth <
                                                      1280)
                                                  ? 524
                                                  : 696,
                                          width:
                                              (ResponsiveBreakpoints.of(context)
                                                          .screenWidth <
                                                      1280)
                                                  ? 452
                                                  : 633,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(aboutImage),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          width:
                                              (ResponsiveBreakpoints.of(context)
                                                          .screenWidth <
                                                      1280)
                                                  ? 452
                                                  : 633,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                      (ResponsiveBreakpoints.of(
                                                                      context)
                                                                  .screenWidth <
                                                              765)
                                                          ? 16
                                                          : 50,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black
                                                      .withOpacity(0.75),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 26.h,
                                              ),
                                              Text(
                                                "Our values are the guiding principles that define who we are as a company and how we conduct our business.",
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontSize:
                                                      (ResponsiveBreakpoints.of(
                                                                      context)
                                                                  .screenWidth <
                                                              765)
                                                          ? 16
                                                          : 18,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black
                                                      .withOpacity(0.75),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: aboutUsTitleDescription(
                                                      title: "Integrity",
                                                      description: "We adhere to the highest ethical standards, ensuring honesty and fairness in every action we take.",
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child:   aboutUsTitleDescription(
                                                      title: "Innovation",
                                                      description: "We are committed to fostering a culture of creativity and continuous improvement.",

                                                    ),
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
                                                      title: "Excellence",
                                                      description: "We strive for excellence in everything we do, delivering superior results that exceed expectations.",
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child:   aboutUsTitleDescription(
                                                      title: "Customer Focus",
                                                      description: "Our customers are at the heart of our business, and their success is our top priority.",
                                                    ),
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
                                    "Our Portfolio",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w600,
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
                                    "Showcasing Our Expertise Through Successful Projects",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontSize: (ResponsiveBreakpoints.of(
                                                      context)
                                                  .screenWidth <
                                              990)
                                          ? (ResponsiveBreakpoints.of(context)
                                                      .screenWidth <
                                                  575)
                                              ? 24
                                              : 32
                                          : 40,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.75),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 26.h,
                                  ),
                                  Text(
                                    "We take pride in our diverse portfolio, which showcases our ability to deliver high-quality solutions across various industries.\nOne of our standout projects is the PakWheels app, a comprehensive platform for car enthusiasts.",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontSize: (ResponsiveBreakpoints.of(
                                                      context)
                                                  .screenWidth <
                                              765)
                                          ? (ResponsiveBreakpoints.of(context)
                                                      .screenWidth <
                                                  575)
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
                                    width: (ResponsiveBreakpoints.of(context)
                                                .screenWidth <
                                            1270)
                                        ? (ResponsiveBreakpoints.of(context)
                                                    .screenWidth <
                                                990)
                                            ? (ResponsiveBreakpoints.of(context)
                                                        .screenWidth <
                                                    770)
                                                ? (ResponsiveBreakpoints.of(
                                                                context)
                                                            .screenWidth <
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
                              height: (ResponsiveBreakpoints.of(context)
                                          .screenWidth <
                                      1270)
                                  ? (ResponsiveBreakpoints.of(context)
                                              .screenWidth <
                                          990)
                                      ? (ResponsiveBreakpoints.of(context)
                                                  .screenWidth <
                                              770)
                                          ? (ResponsiveBreakpoints.of(context)
                                                      .screenWidth <
                                                  575)
                                              ? 713.h
                                              : 431
                                          : 389
                                      : 498
                                  : 634,
                              width: (ResponsiveBreakpoints.of(context)
                                          .screenWidth <
                                      1270)
                                  ? (ResponsiveBreakpoints.of(context)
                                              .screenWidth <
                                          990)
                                      ? (ResponsiveBreakpoints.of(context)
                                                  .screenWidth <
                                              770)
                                          ? (ResponsiveBreakpoints.of(context)
                                                      .screenWidth <
                                                  575)
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            return InfiniteCarousel.builder(
                                              itemCount: portfolioItems.length,
                                              itemExtent: (ResponsiveBreakpoints
                                                              .of(context)
                                                          .screenWidth <
                                                      1270)
                                                  ? (ResponsiveBreakpoints.of(
                                                                  context)
                                                              .screenWidth <
                                                          990)
                                                      ? (ResponsiveBreakpoints.of(
                                                                      context)
                                                                  .screenWidth <
                                                              770)
                                                          ? (ResponsiveBreakpoints.of(
                                                                          context)
                                                                      .screenWidth <
                                                                  575)
                                                              ? constraints
                                                                  .maxWidth
                                                              : 273
                                                          : 242
                                                      : 322
                                                  : 425,
                                              center: false,
                                              anchor: 0.0,
                                              velocityFactor: 0.8,
                                              onIndexChanged: (index) {
                                                ref
                                                    .read(pageNumberProvider
                                                        .notifier)
                                                    .state = index;
                                              },
                                              controller:
                                                  _portfolioScroll1Controller,
                                              axisDirection: Axis.horizontal,
                                              loop: false,
                                              itemBuilder: (context, itemIndex,
                                                  realIndex) {
                                                final item = portfolioItems[itemIndex];
                                                return PortfolioSliderWidget(
                                                    itemIndex: itemIndex,
                                                  stackName: item['stackName']!,
                                                  projectName: item['projectName']!,
                                                  explanation: item['explanation']!,);
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
                                portfolioPageNumber == 0
                                    ? activeIndicator()
                                    : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 1
                                    ? activeIndicator()
                                    : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 2
                                    ? activeIndicator()
                                    : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 3
                                    ? activeIndicator()
                                    : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 4
                                    ? activeIndicator()
                                    : inActiveIndicator(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        key: targetKey,
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
                              "Our Target Market",
                              style: GoogleFonts.montserrat(
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
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
                              "Tailored Solutions for Diverse Industries",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontSize: (ResponsiveBreakpoints.of(context)
                                            .screenWidth <
                                        765)
                                    ? 16
                                    : 40,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.75),
                              ),
                            ),
                            SizedBox(
                              height: 26.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 40.w),
                              child: Text(
                                "Our services are designed to meet the needs of a diverse range of industries. We understand that each industry has unique requirements, and we tailor our solutions to ensure maximum impact and efficiency.",
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
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GradientText(
                              "Industries We Serve:",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              colors: [
                                gradientColor1,
                                gradientColor2,
                                gradientColor3,
                              ],
                            ),

                            SizedBox(
                              height: 40,
                            ),

                            Wrap(
                              spacing: 30,
                              runSpacing: 30,
                              children: [
                                companyGrowthWidget(
                                  image: Image.asset(
                                    ecommerce,
                                    height: 44,
                                    width: 44,
                                    // color: secondaryColor,
                                  ),
                                  scores: "E-commerce",
                                  title: """Use-Case: Online Retail Stores

Description: Build comprehensive e-commerce platforms with product listings, shopping carts, payment gateways, and order tracking.
Technologies Used: Flutter for mobile and web apps, Firebase for real-time updates, RESTful APIs for payment integration.
Relevant Image:

Use-Case: Subscription Services

Description: Develop subscription-based platforms for various services, including video streaming, digital content, and more.
Technologies Used: Flutter for UI, Firebase for user authentication and data storage, AWS for scalable backend services.
""",
                                ),
                                companyGrowthWidget(
                                  image: Image.asset(
                                    education,
                                    height: 44,
                                    width: 44,
                                    // color: orangeColor,
                                  ),
                                  scores: "Education",
                                  title: """Use-Case: E-learning Platforms

Description: Create interactive e-learning platforms with video lessons, quizzes, progress tracking, and community forums.
Technologies Used: Flutter for cross-platform apps, Firebase for real-time data, GraphQL for efficient data fetching.
Relevant Image:

Use-Case: School Management Systems

Description: Develop systems for managing school operations, including student information, attendance, grading, and communication.
Technologies Used: Flutter for UI, Firebase for data storage, RESTful APIs for integration with third-party services.
""",
                                ),
                                companyGrowthWidget(
                                  image: Image.asset(
                                    finance,
                                    height: 44,
                                    width: 44,
                                    // color: primaryColor,
                                  ),
                                  scores: "Finance",
                                  title: """Use-Case: Fintech Solutions

Description: Build secure and scalable fintech applications for banking, investment, and personal finance management.
Technologies Used: Flutter for cross-platform apps, Firebase for real-time data, RESTful APIs for integration with financial services.
Relevant Image:
Use-Case: Investment Platforms

Description: Develop platforms for managing investments, including portfolio tracking, market analysis, and trading.
Technologies Used: Flutter for UI, Firebase for real-time data, GraphQL for efficient data querying.
""",
                                ),
                                companyGrowthWidget(
                                  image: Image.asset(
                                    realEstate,
                                    height: 44,
                                    width: 44,
                                    // color: primaryColor,
                                  ),
                                  scores: "Real Estate",
                                  title: """Use-Case: Property Listing Platforms

Description: Create platforms for listing and searching properties, including advanced search filters, virtual tours, and agent contact.
Technologies Used: Flutter for cross-platform apps, Firebase for real-time updates, RESTful APIs for integration with third-party services.
Relevant Image:

Use-Case: Real Estate Management Systems

Description: Develop systems for managing real estate operations, including property management, tenant communication, and maintenance tracking.
Technologies Used: Flutter for UI, Firebase for data storage, AWS for scalable backend services.
""",
                                ),




                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 80),
                              child: companyGrowthFullWidthWidget(
                                image: Image.asset(
                                  automotive,
                                  height: 44,
                                  width: 44,
                                  // color: primaryColor,
                                ),
                                scores: "Automotive",
                                title: """Use-Case: Dealership Management Systems
                              
Description: Streamline operations for car dealerships, including inventory management, customer relationship management (CRM), and sales tracking.
Technologies Used: Flutter for cross-platform apps, Firebase for real-time data, RESTful APIs for integration with third-party services.
Relevant Image:
                              
Use-Case: Car Rental Services
                              
Description: Develop apps for managing car rentals, including booking, fleet management, and customer support.
Technologies Used: Flutter for mobile apps, Firebase for real-time data, AWS for scalable backend services.
Relevant Image:
Healthcare
                              
Use-Case: Telemedicine Platforms
                              
Description: Enable remote consultations between patients and healthcare providers, including video calls, appointment scheduling, and electronic health records (EHR) management.
Technologies Used: Flutter for mobile and web apps, Firebase for real-time data, RESTful APIs for EHR integration.
Relevant Image:
Use-Case: Patient Management Systems
                              
Description: Manage patient information, appointments, billing, and communication in a single platform.
Technologies Used: Flutter for UI, Firebase for data storage, GraphQL for efficient data querying.
                              """,
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
                                    "Why Choose Us",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w600,
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
                                    "Expertise in Cutting-Edge Technologies",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontSize: (ResponsiveBreakpoints.of(
                                                      context)
                                                  .screenWidth <
                                              990)
                                          ? (ResponsiveBreakpoints.of(context)
                                                      .screenWidth <
                                                  575)
                                              ? 32
                                              : 40
                                          : 50,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.75),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 26.h,
                                  ),
                                  Text(
                                    "We stay ahead of the curve by leveraging the latest technologies to deliver innovative solutions.",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontSize: (ResponsiveBreakpoints.of(
                                                      context)
                                                  .screenWidth <
                                              765)
                                          ? (ResponsiveBreakpoints.of(context)
                                                      .screenWidth <
                                                  575)
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
                                    width: (ResponsiveBreakpoints.of(context)
                                                .screenWidth <
                                            1270)
                                        ? (ResponsiveBreakpoints.of(context)
                                                    .screenWidth <
                                                990)
                                            ? (ResponsiveBreakpoints.of(context)
                                                        .screenWidth <
                                                    770)
                                                ? (ResponsiveBreakpoints.of(
                                                                context)
                                                            .screenWidth <
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
                              height: (ResponsiveBreakpoints.of(context)
                                          .screenWidth <
                                      1270)
                                  ? (ResponsiveBreakpoints.of(context)
                                              .screenWidth <
                                          990)
                                      ? (ResponsiveBreakpoints.of(context)
                                                  .screenWidth <
                                              770)
                                          ? (ResponsiveBreakpoints.of(context)
                                                      .screenWidth <
                                                  575)
                                              ? 713.h
                                              : 431
                                          : 389
                                      : 498
                                  : 634,
                              width: (ResponsiveBreakpoints.of(context)
                                          .screenWidth <
                                      1270)
                                  ? (ResponsiveBreakpoints.of(context)
                                              .screenWidth <
                                          990)
                                      ? (ResponsiveBreakpoints.of(context)
                                                  .screenWidth <
                                              770)
                                          ? (ResponsiveBreakpoints.of(context)
                                                      .screenWidth <
                                                  575)
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            return InfiniteCarousel.builder(
                                              itemCount: whyChooseUsItems.length,
                                              itemExtent: (ResponsiveBreakpoints
                                                              .of(context)
                                                          .screenWidth <
                                                      1270)
                                                  ? (ResponsiveBreakpoints.of(
                                                                  context)
                                                              .screenWidth <
                                                          990)
                                                      ? (ResponsiveBreakpoints.of(
                                                                      context)
                                                                  .screenWidth <
                                                              770)
                                                          ? (ResponsiveBreakpoints.of(
                                                                          context)
                                                                      .screenWidth <
                                                                  575)
                                                              ? constraints
                                                                  .maxWidth
                                                              : 273
                                                          : 242
                                                      : 322
                                                  : 425,
                                              center: false,
                                              anchor: 0.0,
                                              velocityFactor: 0.8,
                                              onIndexChanged: (index) {
                                                ref
                                                    .read(pageNumberProvider
                                                        .notifier)
                                                    .state = index;
                                              },
                                              controller:
                                                  _portfolioScroll1Controller,
                                              axisDirection: Axis.horizontal,
                                              loop: false,
                                              itemBuilder: (context, itemIndex,
                                                  realIndex) {
                                                final item = whyChooseUsItems[itemIndex];

                                                return BlogSliderWidget(
                                                    itemIndex: itemIndex, title: item['title'].toString(), description: item['description'].toString(), image: item['image'].toString(),);
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
                                portfolioPageNumber == 0
                                    ? activeIndicator()
                                    : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 1
                                    ? activeIndicator()
                                    : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 2
                                    ? activeIndicator()
                                    : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 3
                                    ? activeIndicator()
                                    : inActiveIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 4
                                    ? activeIndicator()
                                    : inActiveIndicator(),
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
                              child: (ResponsiveBreakpoints.of(context)
                                          .screenWidth <
                                      990)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        (ResponsiveBreakpoints.of(context)
                                                    .screenWidth <
                                                570)
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        height: (ResponsiveBreakpoints.of(
                                                                        context)
                                                                    .screenWidth <
                                                                770)
                                                            ? 596.h
                                                            : 804,
                                                        width: (ResponsiveBreakpoints.of(
                                                                        context)
                                                                    .screenWidth <
                                                                770)
                                                            ? 516.w
                                                            : 696,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                aboutImage),
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                height:
                                                    (ResponsiveBreakpoints.of(
                                                                    context)
                                                                .screenWidth <
                                                            770)
                                                        ? 596
                                                        : 804,
                                                width:
                                                    (ResponsiveBreakpoints.of(
                                                                    context)
                                                                .screenWidth <
                                                            770)
                                                        ? 516
                                                        : 696,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image:
                                                        AssetImage(aboutImage),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        (ResponsiveBreakpoints.of(context)
                                                    .screenWidth <
                                                570)
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: Container(
                                                  width:
                                                      (ResponsiveBreakpoints.of(
                                                                      context)
                                                                  .screenWidth <
                                                              770)
                                                          ? 516
                                                          : 696,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      GradientText(
                                                        "Contact Us",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 36,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                        "Get in Touch",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: (ResponsiveBreakpoints.of(
                                                                          context)
                                                                      .screenWidth <
                                                                  765)
                                                              ? 16
                                                              : 50,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.75),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 12.h,
                                                      ),
                                                      Text(
                                                        "Let's Discuss Your Project",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: (ResponsiveBreakpoints.of(
                                                                          context)
                                                                      .screenWidth <
                                                                  765)
                                                              ? 12
                                                              : 38,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.75),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 26.h,
                                                      ),
                                                      Text(
                                                        "Ready to take your business to the next level? Contact us today to discuss your project and how we can help you achieve your goals.",
                                                        textAlign:
                                                        TextAlign
                                                            .left,
                                                        style: GoogleFonts
                                                            .poppins(
                                                          fontSize:
                                                          (ResponsiveBreakpoints.of(context).screenWidth <
                                                              765)
                                                              ? 16
                                                              : 14,
                                                          fontWeight:
                                                          FontWeight
                                                              .w300,
                                                          color: Colors
                                                              .black
                                                              .withOpacity(
                                                              0.75),
                                                        ),
                                                      ),


                                                      SizedBox(
                                                        height: 50,
                                                      ),
                                                      CustomizableTextField(
                                                        controller:
                                                            yourNameEditingController,
                                                        hintText: yourNameText,
                                                        focusNode:
                                                            yourNameFocusNode,
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
                                                        prefixPadding:
                                                            EdgeInsets.zero,
                                                        suffixPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10.w,
                                                          vertical: 16.h,
                                                        ),
                                                        focusedIconColor:
                                                            Colors.black,
                                                        unfocusedIconColor:
                                                            Colors.grey,
                                                        hideText: false,
                                                        textInputType:
                                                            TextInputType
                                                                .number,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      CustomizableTextField(
                                                        controller:
                                                            yourPhoneEditingController,
                                                        hintText: yourPhoneText,
                                                        focusNode:
                                                            yourPhoneFocusNode,
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
                                                        prefixPadding:
                                                            EdgeInsets.zero,
                                                        suffixPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10.w,
                                                          vertical: 16.h,
                                                        ),
                                                        focusedIconColor:
                                                            Colors.black,
                                                        unfocusedIconColor:
                                                            Colors.grey,
                                                        hideText: false,
                                                        textInputType:
                                                            TextInputType
                                                                .number,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      CustomizableTextField(
                                                        controller:
                                                            yourEmailEditingController,
                                                        hintText: yourEmailText,
                                                        focusNode:
                                                            yourEmailFocusNode,
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
                                                        prefixPadding:
                                                            EdgeInsets.zero,
                                                        suffixPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10.w,
                                                          vertical: 16.h,
                                                        ),
                                                        focusedIconColor:
                                                            Colors.black,
                                                        unfocusedIconColor:
                                                            Colors.grey,
                                                        hideText: false,
                                                        textInputType:
                                                            TextInputType
                                                                .number,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      CustomizableTextField(
                                                        controller:
                                                            yourMessageEditingController,
                                                        hintText:
                                                            yourMessageText,
                                                        focusNode:
                                                            yourMessageFocusNode,
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
                                                        prefixPadding:
                                                            EdgeInsets.zero,
                                                        suffixPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10.w,
                                                          vertical: 16.h,
                                                        ),
                                                        focusedIconColor:
                                                            Colors.black,
                                                        unfocusedIconColor:
                                                            Colors.grey,
                                                        hideText: false,
                                                        textInputType:
                                                            TextInputType
                                                                .number,
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
                                                        buttonTitle:
                                                            "Submit Now"
                                                                .toUpperCase(),
                                                        onPressed: () async {},
                                                        buttonTitleStyle:
                                                            TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        buttonBorderRadius: 60,
                                                        buttonColor:
                                                            primaryColor,
                                                        horizontalPadding: 40,
                                                        verticalPadding: 16,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width:
                                                    (ResponsiveBreakpoints.of(
                                                                    context)
                                                                .screenWidth <
                                                            770)
                                                        ? 516
                                                        : 696,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GradientText(
                                                      "Contact Us",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 36,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                      "Get in Touch",
                                                      textAlign: TextAlign.left,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: (ResponsiveBreakpoints.of(
                                                                        context)
                                                                    .screenWidth <
                                                                765)
                                                            ? 16
                                                            : 50,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black
                                                            .withOpacity(0.75),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 12.h,
                                                    ),
                                                    Text(
                                                      "Let's Discuss Your Project",
                                                      textAlign:
                                                      TextAlign.left,
                                                      style:
                                                      GoogleFonts.poppins(
                                                        fontSize: (ResponsiveBreakpoints.of(
                                                            context)
                                                            .screenWidth <
                                                            765)
                                                            ? 12
                                                            : 38,
                                                        fontWeight:
                                                        FontWeight.w300,
                                                        color: Colors.black
                                                            .withOpacity(
                                                            0.75),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 26.h,
                                                    ),
                                                    Text(
                                                      "Ready to take your business to the next level? Contact us today to discuss your project and how we can help you achieve your goals.",
                                                      textAlign:
                                                      TextAlign
                                                          .left,
                                                      style: GoogleFonts
                                                          .poppins(
                                                        fontSize:
                                                        (ResponsiveBreakpoints.of(context).screenWidth <
                                                            765)
                                                            ? 16
                                                            : 14,
                                                        fontWeight:
                                                        FontWeight
                                                            .w300,
                                                        color: Colors
                                                            .black
                                                            .withOpacity(
                                                            0.75),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    CustomizableTextField(
                                                      controller:
                                                          yourNameEditingController,
                                                      hintText: yourNameText,
                                                      focusNode:
                                                          yourNameFocusNode,
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
                                                      prefixPadding:
                                                          EdgeInsets.zero,
                                                      suffixPadding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 10.w,
                                                        vertical: 16.h,
                                                      ),
                                                      focusedIconColor:
                                                          Colors.black,
                                                      unfocusedIconColor:
                                                          Colors.grey,
                                                      hideText: false,
                                                      textInputType:
                                                          TextInputType.number,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    CustomizableTextField(
                                                      controller:
                                                          yourPhoneEditingController,
                                                      hintText: yourPhoneText,
                                                      focusNode:
                                                          yourPhoneFocusNode,
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
                                                      prefixPadding:
                                                          EdgeInsets.zero,
                                                      suffixPadding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 10.w,
                                                        vertical: 16.h,
                                                      ),
                                                      focusedIconColor:
                                                          Colors.black,
                                                      unfocusedIconColor:
                                                          Colors.grey,
                                                      hideText: false,
                                                      textInputType:
                                                          TextInputType.number,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    CustomizableTextField(
                                                      controller:
                                                          yourEmailEditingController,
                                                      hintText: yourEmailText,
                                                      focusNode:
                                                          yourEmailFocusNode,
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
                                                      prefixPadding:
                                                          EdgeInsets.zero,
                                                      suffixPadding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 10.w,
                                                        vertical: 16.h,
                                                      ),
                                                      focusedIconColor:
                                                          Colors.black,
                                                      unfocusedIconColor:
                                                          Colors.grey,
                                                      hideText: false,
                                                      textInputType:
                                                          TextInputType.number,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    CustomizableTextField(
                                                      controller:
                                                          yourMessageEditingController,
                                                      hintText: yourMessageText,
                                                      focusNode:
                                                          yourMessageFocusNode,
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
                                                      prefixPadding:
                                                          EdgeInsets.zero,
                                                      suffixPadding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 10.w,
                                                        vertical: 16.h,
                                                      ),
                                                      focusedIconColor:
                                                          Colors.black,
                                                      unfocusedIconColor:
                                                          Colors.grey,
                                                      hideText: false,
                                                      textInputType:
                                                          TextInputType.number,
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
                                                      buttonTitle: "Submit Now"
                                                          .toUpperCase(),
                                                      onPressed: () async {},
                                                      buttonTitleStyle:
                                                          TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width:
                                              (ResponsiveBreakpoints.of(context)
                                                          .screenWidth <
                                                      1280)
                                                  ? 452
                                                  : 633,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GradientText(
                                                "Contact Us",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 36,
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
                                                "Get in Touch",
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontSize:
                                                      (ResponsiveBreakpoints.of(
                                                                      context)
                                                                  .screenWidth <
                                                              765)
                                                          ? 16
                                                          : 50,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black
                                                      .withOpacity(0.75),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              Text(
                                                "Let's Discuss Your Project",
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontSize:
                                                      (ResponsiveBreakpoints.of(
                                                                      context)
                                                                  .screenWidth <
                                                              765)
                                                          ? 12
                                                          : 38,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black
                                                      .withOpacity(0.75),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 26.h,
                                              ),
                                              Text(
                                                "Ready to take your business to the next level? Contact us today to discuss your project and how we can help you achieve your goals.",
                                                textAlign:
                                                TextAlign
                                                    .left,
                                                style: GoogleFonts
                                                    .poppins(
                                                  fontSize:
                                                  (ResponsiveBreakpoints.of(context).screenWidth <
                                                      765)
                                                      ? 16
                                                      : 14,
                                                  fontWeight:
                                                  FontWeight
                                                      .w300,
                                                  color: Colors
                                                      .black
                                                      .withOpacity(
                                                      0.75),
                                                ),
                                              ),

                                              SizedBox(
                                                height: 50,
                                              ),
                                              CustomizableTextField(
                                                controller:
                                                    yourNameEditingController,
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
                                                suffixPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 16.h,
                                                ),
                                                focusedIconColor: Colors.black,
                                                unfocusedIconColor: Colors.grey,
                                                hideText: false,
                                                textInputType:
                                                    TextInputType.number,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              CustomizableTextField(
                                                controller:
                                                    yourPhoneEditingController,
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
                                                suffixPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 16.h,
                                                ),
                                                focusedIconColor: Colors.black,
                                                unfocusedIconColor: Colors.grey,
                                                hideText: false,
                                                textInputType:
                                                    TextInputType.number,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              CustomizableTextField(
                                                controller:
                                                    yourEmailEditingController,
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
                                                suffixPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 16.h,
                                                ),
                                                focusedIconColor: Colors.black,
                                                unfocusedIconColor: Colors.grey,
                                                hideText: false,
                                                textInputType:
                                                    TextInputType.number,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              CustomizableTextField(
                                                controller:
                                                    yourMessageEditingController,
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
                                                suffixPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 16.h,
                                                ),
                                                focusedIconColor: Colors.black,
                                                unfocusedIconColor: Colors.grey,
                                                hideText: false,
                                                textInputType:
                                                    TextInputType.number,
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
                                                buttonTitle:
                                                    "Submit Now".toUpperCase(),
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
                                              (ResponsiveBreakpoints.of(context)
                                                          .screenWidth <
                                                      1280)
                                                  ? 524
                                                  : 696,
                                          width:
                                              (ResponsiveBreakpoints.of(context)
                                                          .screenWidth <
                                                      1280)
                                                  ? 452
                                                  : 633,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(aboutImage),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                  fontSize: (ResponsiveBreakpoints.of(context)
                                              .screenWidth <
                                          990)
                                      ? (ResponsiveBreakpoints.of(context)
                                                  .screenWidth <
                                              575)
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
                                (ResponsiveBreakpoints.of(context).screenWidth <
                                        575)
                                    ? 0
                                    : 50),
                        color: Colors.black,
                        child: (ResponsiveBreakpoints.of(context).screenWidth <
                                990)
                            ? (ResponsiveBreakpoints.of(context).screenWidth <
                                    575)
                                ? Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    logoImageInvertedTechnology,
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: Icon(
                                                      FontAwesomeIcons
                                                          .facebookF,
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                      FontAwesomeIcons
                                                          .linkedinIn,
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                      FontAwesomeIcons
                                                          .instagram,
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Copyright © 2024 Rainbow-Themes. All Rights Reserved",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white
                                                          .withOpacity(0.75),
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    logoImageInvertedTechnology,
                                                    height: (ResponsiveBreakpoints
                                                                    .of(context)
                                                                .screenWidth <
                                                            750)
                                                        ? 40
                                                        : 50,
                                                    width: (ResponsiveBreakpoints
                                                                    .of(context)
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: Icon(
                                                      FontAwesomeIcons
                                                          .facebookF,
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                      FontAwesomeIcons
                                                          .linkedinIn,
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                      FontAwesomeIcons
                                                          .instagram,
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                              height: (ResponsiveBreakpoints.of(
                                                              context)
                                                          .screenWidth <
                                                      750)
                                                  ? 40
                                                  : 50,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Copyright © 2024 Rainbow-Themes. All Rights Reserved",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white
                                                          .withOpacity(0.75),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            logoImageInvertedTechnology,
                                            height: (ResponsiveBreakpoints.of(
                                                            context)
                                                        .screenWidth <
                                                    750)
                                                ? 40
                                                : 50,
                                            width: (ResponsiveBreakpoints.of(
                                                            context)
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
                                      height: (ResponsiveBreakpoints.of(context)
                                                  .screenWidth <
                                              750)
                                          ? 40
                                          : 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Copyright © 2024 Rainbow-Themes. All Rights Reserved",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white
                                                  .withOpacity(0.75),
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

  Widget companyGrowthWidget(
      {required Widget image, required String scores, required String title}) {
    return (ResponsiveBreakpoints.of(context).screenWidth < 575)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    // height: 380,
                    width: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                        ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                        ? 400 // Updated width for screens smaller than 755
                        : 461 // Updated width for screens between 755 and 1250
                        : 542, // Updated width for screens larger than 1250

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60,vertical: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          image,
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            scores,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontSize:
                                  (ResponsiveBreakpoints.of(context).screenWidth <
                                          1250)
                                      ? 24
                                      : 30,
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
                                  (ResponsiveBreakpoints.of(context).screenWidth <
                                          765)
                                      ? 12
                                      : 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container(
            // height: 380,
      width: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
          ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
          ? 400 // Updated width for screens smaller than 755
          : 461 // Updated width for screens between 755 and 1250
          : 542, // Updated width for screens larger than 1250

      decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 60,vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image,
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    scores,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontSize:
                          (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                              ? 24
                              : 30,
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
                          (ResponsiveBreakpoints.of(context).screenWidth < 765)
                              ? 12
                              : 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.75),
                    ),
                  ),
                ],
              ),
            ),
          );
  }


  Widget companyGrowthFullWidthWidget(
      {required Widget image, required String scores, required String title}) {
    return (ResponsiveBreakpoints.of(context).screenWidth < 575)
        ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              // height: 380,
              // width: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
              //     ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
              //     ? 400 // Updated width for screens smaller than 755
              //     : 461 // Updated width for screens between 755 and 1250
              //     : 542, // Updated width for screens larger than 1250

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 60,vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image,
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      scores,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontSize:
                        (ResponsiveBreakpoints.of(context).screenWidth <
                            1250)
                            ? 24
                            : 30,
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
                        (ResponsiveBreakpoints.of(context).screenWidth <
                            765)
                            ? 12
                            : 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.75),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    )
        : Container(
      // height: 380,
      // width: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
      //     ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
      //     ? 400 // Updated width for screens smaller than 755
      //     : 461 // Updated width for screens between 755 and 1250
      //     : 542, // Updated width for screens larger than 1250

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60,vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            SizedBox(
              height: 20,
            ),
            Text(
              scores,
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                fontSize:
                (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                    ? 24
                    : 30,
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
                (ResponsiveBreakpoints.of(context).screenWidth < 765)
                    ? 12
                    : 14,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.75),
              ),
            ),
          ],
        ),
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

  Widget aboutUsTitleDescription(
      {required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
            fontSize:
                (ResponsiveBreakpoints.of(context).screenWidth < 765) ? 16 : 18,
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
            fontSize:
                (ResponsiveBreakpoints.of(context).screenWidth < 765) ? 16 : 18,
            fontWeight: FontWeight.w300,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget drawerNavButton(
      {required String title, required VoidCallback onPressed}) {
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

  Widget navButton(
      {required String title,
      required VoidCallback onPressed,
      Color? textColor}) {
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
      // height: (ResponsiveBreakpoints.of(context).screenWidth < 1200)
      //     ? (ResponsiveBreakpoints.of(context).screenWidth < 985)
      //         ? (ResponsiveBreakpoints.of(context).screenWidth < 765)
      //             ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
      //                 ? 500 // Updated from 238 to 500
      //                 : 696 // Updated from 332 to 696
      //             : 555 // Updated from 264 to 555
      //         : 705 // Updated from 336 to 705
      //     : 602, // Updated from 286 to 602

      // height: (ResponsiveBreakpoints.of(context).screenWidth < 1200)
      //     ? (ResponsiveBreakpoints.of(context).screenWidth < 985)
      //         ? (ResponsiveBreakpoints.of(context).screenWidth < 765)
      //             ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
      //                 ? 238
      //                 : 332
      //             : 264
      //         : 336
      //     : 286,
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
          horizontal:
              (ResponsiveBreakpoints.of(context).screenWidth < 575) ? 23 : 30,
          vertical:
              (ResponsiveBreakpoints.of(context).screenWidth < 575) ? 32 : 40),
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
              fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 765)
                  ? 13
                  : 15,
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
