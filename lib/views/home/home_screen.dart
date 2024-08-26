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
      "heading": "Overview",
      "description": """Unique Business Needs: Every business operates in a distinct environment with specific challenges and goals. Understanding these nuances is crucial for providing effective solutions.
Tailored Strategies: Our approach involves crafting bespoke strategies that align with the unique aspects of your business.
Industry Dynamics: We consider the specific dynamics of your industry, ensuring that our solutions are relevant and effective in your market context.
Operational Intricacies: We delve into the operational details of your business to create solutions that fit seamlessly into your existing processes.""",
      "header": "Detailed Approach",
      "heading1": "Initial Consultation:",
      "description1": """Discovery Phase: We begin with a comprehensive discovery phase, including interviews with key stakeholders to identify core business challenges and objectives.
Analysis: Analyzing business processes, current systems, and market position to identify gaps and opportunities for improvement.
Goal Alignment: Aligning our strategies with your short-term and long-term goals to ensure that the solutions we develop are both relevant and impactful.""",
      "heading2": "Customization Process:",
      "description2": """Solution Design: Based on the insights gained, we design customized solutions that address the specific needs and challenges of your business.
Feedback Integration: Incorporating feedback from stakeholders throughout the design and development phases to refine the solution.
Prototype Development: Creating prototypes or pilot versions of the solution to test its effectiveness and make necessary adjustments.""",
      "heading3": "Benefits:",
      "description3": """Enhanced Efficiency: Custom solutions streamline processes, reducing inefficiencies and improving productivity.
Competitive Advantage: Tailored strategies give you a competitive edge by addressing specific challenges unique to your business.
Scalability: Custom solutions can be scaled as your business grows, ensuring continued relevance and effectiveness.""",
      "heading4": "Case Examples:",
      "description4": """Example 1: A retail client experienced significant improvements in inventory management and sales forecasting through a customized solution tailored to their specific needs.
Example 2: A healthcare provider saw enhanced patient management and operational efficiency by implementing a bespoke system designed to address their unique workflow requirements.""",
    },
    {
      "title": "Proven Track Record",
      "image": provenTrackRecord,
      "heading": "Overview",
      "description": """Established Reputation: Over the years, we have built a strong reputation for delivering high-quality solutions that consistently meet the demands of various industries.
Diverse Experience: Our extensive portfolio showcases our ability to solve complex challenges and create innovative solutions that stand the test of time.
Commitment to Excellence: Our track record reflects our dedication to excellence and our capability to drive success for our clients.""",
      "header": "Detailed Achievements",
      "heading1": "Project Portfolio:",
      "description1": """Technology Sector: Successfully implemented cutting-edge technologies for clients, resulting in improved operational efficiency and competitive advantage.
Finance Sector: Developed robust financial solutions that enhanced data accuracy and compliance, leading to significant cost savings and operational improvements.
Healthcare Sector: Delivered innovative solutions that improved patient care and streamlined administrative processes, contributing to better overall service delivery.""",
      "heading2": "Client Testimonials:",
      "description2": """Testimonial 1: "The solutions provided by this firm have consistently exceeded our expectations. Their expertise and commitment to quality are evident in every project." - Technology Client
Testimonial 2: "Their ability to understand our unique challenges and deliver effective solutions has been instrumental in our success. We highly recommend their services." - Finance Client""",
      "heading3": "Project Highlights:",
      "description3": """Complex Problem Solving: Successfully addressed complex challenges by applying advanced problem-solving techniques and innovative approaches.
Innovative Solutions: Developed and implemented innovative solutions that have set new benchmarks in various industries.
Long-Term Partnerships: Built long-term relationships with clients by consistently delivering exceptional results and providing ongoing support.""",
      "heading4": "Metrics and Impact:",
      "description4": """Improved Efficiency: Quantifiable improvements in operational efficiency and productivity for clients across different sectors.
Cost Savings: Significant cost savings achieved through optimized processes and effective solutions.
Enhanced Performance: Demonstrated improvements in performance metrics, such as increased revenue, reduced operational costs, and enhanced customer satisfaction.""",
    },
    {
      "title": "Client-Centric Approach",
      "image": clientCentricSolution,
      "heading": "Overview",
      "description": """Client Focus: Our approach places clients at the heart of our operations, ensuring that their needs and goals are prioritized.
Open Communication: We emphasize transparent and open communication to foster a collaborative partnership.
Long-Term Relationships: We aim to build enduring relationships based on trust, respect, and mutual success.""",
      "header": "Detailed Approach",
      "heading1": "Client Engagement:",
      "description1": """Initial Meetings: Conducting detailed meetings with clients to understand their vision, goals, and expectations.
Regular Updates: Providing regular updates and progress reports to keep clients informed and involved throughout the project.
Feedback Mechanisms: Implementing feedback mechanisms to gather client input and make necessary adjustments to the project.""",
      "heading2": "Collaboration:",
      "description2": """Joint Planning: Working collaboratively with clients during the planning and design phases to ensure alignment with their objectives.
Team Integration: Integrating client teams into the project process to facilitate knowledge sharing and ensure that solutions meet their needs.
Problem-Solving: Addressing any issues or concerns promptly and collaboratively to ensure that solutions remain effective and aligned with client expectations.""",
      "heading3": "Client Satisfaction:",
      "description3": """Custom Solutions: Developing customized solutions that address the unique needs of each client, ensuring that their goals are met.
Exceptional Service: Providing exceptional customer service and support to enhance the overall client experience.
Continuous Improvement: Continuously seeking ways to improve our services and solutions based on client feedback and evolving needs.""",
      "heading4": "Success Stories:",
      "description4": """Story 1: Successfully revamped a client’s business processes by incorporating their feedback and working closely with their team, resulting in enhanced efficiency and satisfaction.
Story 2: Built a strong, long-term relationship with a client through consistent communication, collaborative problem-solving, and a client-centric approach, leading to multiple successful projects.""",
    },
    {
      "title": "Scalable and Secure Solutions",
      "image": secureSolution,
      "heading": "Overview",
      "description": """Scalability: Our solutions are designed to scale with your business, ensuring continued effectiveness as your needs evolve.
Security: We prioritize security by implementing the latest technologies and best practices to protect your data and assets.
Sustainability: Our focus on scalability and security ensures that solutions are not only effective but also sustainable in the long term.""",
      "header": "Detailed Approach",
      "heading1": "Scalable Design:",
      "description1": """Modular Architecture: Utilizing modular design principles to ensure that solutions can be easily scaled as your business grows.
Flexible Infrastructure: Implementing flexible infrastructure that can adapt to changing business requirements and increasing demands.
Future-Proofing: Designing solutions with future growth in mind to minimize the need for extensive modifications or upgrades.""",
      "heading2": "Security Measures:",
      "description2": """Data Protection: Employing advanced encryption and data protection techniques to safeguard sensitive information.
Access Controls: Implementing robust access controls and authentication mechanisms to prevent unauthorized access.
Compliance: Ensuring that solutions comply with relevant regulations and standards to maintain data integrity and security.""",
      "heading3": "Sustainable Solutions:",
      "description3": """Efficient Resource Utilization: Designing solutions that use resources efficiently to minimize environmental impact and operational costs.
Regular Updates: Providing regular updates and patches to address potential security vulnerabilities and ensure continued effectiveness.
Long-Term Support: Offering long-term support and maintenance to ensure that solutions remain effective and secure over time.""",
      "heading4": "Case Examples:",
      "description4": """Example 1: Developed a scalable e-commerce platform that accommodated growing customer demands and increased traffic, ensuring smooth operations as the business expanded.
Example 2: Implemented a secure data management system for a financial institution, protecting sensitive client information and meeting stringent regulatory requirements.""",
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
            padding: const EdgeInsets.all(30),
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
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
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
                                  padding: const EdgeInsets.only(left: 20),
                                  child: InkWell(
                                    onTap: () {
                                      _scaffoldKey.currentState?.openDrawer();
                                      // Scaffold.of(context).openDrawer();
                                    },
                                    child: const Icon(
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
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(homeSectionBackgroundImage1),
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
                                key: const Key('navbar'),
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
                                                      const EdgeInsets.only(left: 20),
                                                  child: InkWell(
                                                    onTap: () {
                                                      _scaffoldKey.currentState
                                                          ?.openDrawer();
                                                    },
                                                    child: const Icon(
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
                                    const SizedBox(
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
                                      buttonTitleStyle: const TextStyle(
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
                                  title: "Flutter",
                                  content:
                                  """Flutter, Google’s UI toolkit, is revolutionizing app development by enabling high-performance, visually stunning applications across mobile, web, and desktop platforms. At our company, we harness Flutter’s power to deliver cross-platform solutions efficiently, ensuring your app stands out with native-like performance.

Why Choose Flutter for Your Next Project?
Cross-Platform Development: Flutter’s single codebase supports deployment across Android, iOS, web, and desktop platforms, reducing development time and cost. This approach simplifies maintenance and accelerates time-to-market, allowing you to reach a broader audience with minimal investment.

High Performance: Flutter provides near-native performance by compiling directly to native machine code. This ensures smooth animations, fast load times, and responsive UI, rivaling that of native apps.

Expressive and Flexible UI: With a rich set of customizable widgets, Flutter allows for the creation of beautiful and brand-specific UIs. Its layered architecture provides complete control over every pixel, enabling intricate and complex designs.

Single Codebase for Easier Maintenance and Updates: A single codebase simplifies updates and maintenance, applying changes across all platforms efficiently. This reduces errors and ensures that your app remains current with the latest trends and technologies.

Our Approach to Flutter Development
In-Depth Consultation: We start by understanding your business goals and unique requirements to create a tailored development strategy.

Custom UI/UX Design: Leveraging Flutter’s capabilities, we design engaging and intuitive user interfaces, with rapid prototyping and testing to meet your vision.

Agile Development Process: Our agile approach allows for flexibility and iterative progress, providing regular updates and incorporating feedback throughout development.

Comprehensive Testing: Extensive testing across all platforms ensures your app is bug-free and performs optimally. We focus on functional, performance, and user acceptance testing.

Post-Launch Support: We offer ongoing support and maintenance, including updates and feature enhancements based on user feedback and evolving needs.
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
                                  title: "Android Development",
                                  content:
                                      """Our team excels in developing robust, user-friendly Android applications optimized for performance, security, and scalability. We understand the diverse Android ecosystem and craft solutions that meet your business needs and enhance user engagement.

Why Choose Our Android Development Services?
Customizable Solutions: We tailor our Android apps to meet your specific business requirements, whether for e-commerce, service delivery, or internal operations, ensuring alignment with your objectives.

Scalable Architecture: Our apps are designed with scalable architecture to handle increasing user loads efficiently, maintaining performance and reliability as your user base grows.

High Performance: We optimize our Android apps for speed and efficiency, ensuring smooth operation on various devices. Best practices in coding and resource management ensure quick load times and a responsive user interface.

Extensive Market Reach: Android’s vast user base offers unparalleled market penetration opportunities. Our apps are compatible with a wide range of devices and Android versions, maximizing reach and engagement.

Our Approach to Android Development
Comprehensive Requirement Analysis: We analyze your business needs and target audience to determine the features and functionalities that will best serve your users.

User-Centric Design: Our design focus is on creating intuitive interfaces that enhance user experience and engagement.

Advanced Security Measures: We integrate robust security protocols to protect user data and prevent unauthorized access, ensuring your app’s security and compliance.

Rigorous Testing and Quality Assurance: Our apps undergo extensive testing to meet high-quality standards, including performance, security, and usability assessments.

Ongoing Support and Maintenance: Post-launch, we provide support and maintenance to keep your app updated and performing optimally, incorporating feedback and new features as needed.
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
                                      """Our iOS application development focuses on creating seamless, intuitive apps that blend aesthetics with functionality. We deliver premium experiences that resonate with users and enhance engagement across Apple’s ecosystem.

Why Choose Our iOS Development Services?
High Security: Our iOS apps are built with advanced security protocols, including encryption and secure authentication, to protect user data and ensure privacy.

Excellent Performance: Optimized for speed and efficiency, our iOS apps provide a smooth and responsive interface, handling complex features and high data loads effectively.

Premium User Base: iOS users, known for their higher purchasing power, offer valuable engagement opportunities. Our apps cater to this demographic, enhancing brand loyalty and driving ROI.

Consistency Across Devices: Our apps deliver a consistent experience across all iOS devices, reinforcing brand trust and ensuring user satisfaction.

Detailed Approach to iOS Development
User-Centered Design: We prioritize user experience through extensive research and intuitive design, ensuring that the app meets user needs and preferences.

Robust Functionality: Advanced features are integrated to enhance usability while maintaining high performance, including seamless navigation and real-time updates.

Quality Assurance: Rigorous testing ensures compliance with Apple’s quality standards, including performance, security, and user experience evaluations.

Post-Launch Support: We provide ongoing support and updates to keep your app running smoothly, incorporating user feedback and ensuring compatibility with the latest iOS versions.
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
                                  title: "Artificial Intelligence",
                                  content:
                                      """In the fast-evolving digital landscape, artificial intelligence (AI) is transforming mobile applications into intelligent solutions that enhance user experience and automate complex tasks. At our company, we integrate cutting-edge AI technologies into mobile apps, providing features that offer personalized interactions, automate repetitive tasks, and deliver valuable insights.

Why AI is Essential for Modern Mobile Apps
Enhanced User Experience: AI algorithms analyze user behavior to offer personalized recommendations, such as suggesting content or products tailored to individual preferences. This customization improves user engagement by making the app more intuitive and responsive, whether recommending songs, products, or routes.

Automation: AI automates tasks like customer support through chatbots, data entry, and image recognition. This not only boosts efficiency but also reduces operational costs, freeing up human resources for strategic activities and delivering faster, more efficient user interactions.

Data-Driven Insights: AI excels at analyzing large data volumes to generate actionable insights about user behavior and trends. These insights enable better decision-making and optimization of app functionality, marketing strategies, and business operations by identifying patterns and opportunities.

Advanced Features: AI enables advanced functionalities such as facial recognition, natural language processing, and predictive analytics. These features enhance user experience with secure authentication, real-time translations, and content moderation, setting your app apart in a competitive marketplace.

Specialized AI Models We Implement
Facial Recognition: Our AI facial recognition models ensure secure and reliable user authentication, ideal for high-security applications in banking, healthcare, and government services.

Document Verification: Automated verification of documents like passports and IDs speeds up onboarding processes and reduces manual effort, particularly useful in finance, travel, and legal sectors.

Nudity Checks: AI-powered nudity detection models help maintain content moderation standards by identifying and flagging inappropriate material, ensuring compliance with community guidelines.

Technologies We Use
TensorFlow: A flexible and scalable framework for building deep learning models for image recognition and natural language processing.
PyTorch: A library suited for complex neural networks and deep learning tasks, excelling in both research and production.
OpenCV: An open-source library for real-time image processing and analysis, crucial for facial recognition and object detection.
Our Approach to AI Integration
Consultation and Strategy Development: We understand your needs and develop a strategy for integrating AI that aligns with your business goals and enhances user experience.

AI Model Development: Our specialists design custom AI models tailored to your requirements, optimizing performance and accuracy.

Seamless Integration: We integrate AI features into your app smoothly, ensuring compatibility and enhanced functionality.

Testing and Optimization: We conduct rigorous testing and continuous optimization to improve model performance and reliability.

Ongoing Support and Maintenance: Post-launch support includes monitoring, updates, and refinements to keep AI features performing optimally.
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
                        padding: const EdgeInsets.symmetric(vertical: 120),
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
                                                padding: const EdgeInsets.symmetric(
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
                                                              const DecorationImage(
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
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                decoration: BoxDecoration(
                                                  image: const DecorationImage(
                                                    image:
                                                        AssetImage(aboutImage),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        (ResponsiveBreakpoints.of(context)
                                                    .screenWidth <
                                                570)
                                            ? Padding(
                                                padding: const EdgeInsets.symmetric(
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
                                                      const SizedBox(
                                                        height: 50,
                                                      ),
                                                      aboutUsTitleDescription(
                                                        title: "Integrity",
                                                        description: "We adhere to the highest ethical standards, ensuring honesty and fairness in every action we take.",
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      aboutUsTitleDescription(
                                                        title: "Innovation",
                                                        description: "We are committed to fostering a culture of creativity and continuous improvement.",
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      aboutUsTitleDescription(
                                                        title: "Excellence",
                                                        description: "We strive for excellence in everything we do, delivering superior results that exceed expectations.",
                                                      ),
                                                      const SizedBox(
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
                                                      const SizedBox(
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
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Container(
                                                        height: 2.4,
                                                        width: 40,
                                                        decoration:
                                                            const BoxDecoration(
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
                                                    const SizedBox(
                                                      height: 50,
                                                    ),
                                                    aboutUsTitleDescription(
                                                      title: "Integrity",
                                                      description: "We adhere to the highest ethical standards, ensuring honesty and fairness in every action we take.",
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    aboutUsTitleDescription(
                                                      title: "Innovation",
                                                      description: "We are committed to fostering a culture of creativity and continuous improvement.",
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    aboutUsTitleDescription(
                                                      title: "Excellence",
                                                      description: "We strive for excellence in everything we do, delivering superior results that exceed expectations.",
                                                    ),
                                                    const SizedBox(
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
                                                    const SizedBox(
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
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Container(
                                                      height: 2.4,
                                                      width: 40,
                                                      decoration: const BoxDecoration(
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(aboutImage),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          width:
                                              (ResponsiveBreakpoints.of(context)
                                                          .screenWidth <
                                                      1280)
                                                  ? 452
                                                  : 633,
                                          padding: const EdgeInsets.symmetric(
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
                                              const SizedBox(
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
                                                  const SizedBox(
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
                                              const SizedBox(
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
                                                  const SizedBox(
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
                                              const SizedBox(
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
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Container(
                                                height: 2.4,
                                                width: 40,
                                                decoration: const BoxDecoration(
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
                        padding: const EdgeInsets.symmetric(vertical: 120),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                  const SizedBox(
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
                                  const SizedBox(
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
                                              loop: true,
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
                                  const SizedBox(
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
                                const SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 1
                                    ? activeIndicator()
                                    : inActiveIndicator(),
                                const SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 2
                                    ? activeIndicator()
                                    : inActiveIndicator(),
                                const SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 3
                                    ? activeIndicator()
                                    : inActiveIndicator(),
                                const SizedBox(
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
                        padding: const EdgeInsets.symmetric(vertical: 120),
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
                            const SizedBox(
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

                            const SizedBox(
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
                                  title1: 'Use-Case: Online Retail Stores',
                                  description1: 'Build sophisticated e-commerce platforms that provide a seamless shopping experience with features such as product listings, shopping carts, payment gateways, and order tracking. Utilize Flutter for creating responsive mobile and web applications, Firebase for real-time updates and user authentication, and RESTful APIs for secure payment integration.',
                                  title2: 'Use-Case: Subscription Services',
                                  description2: 'Develop robust subscription-based platforms that cater to various services, such as video streaming and digital content delivery. Implement Flutter for a sleek user interface, Firebase for managing user authentication and data storage, and AWS for scalable backend services to handle high user loads and subscription management.',

                                ),
                                companyGrowthWidget(
                                  image: Image.asset(
                                    education,
                                    height: 44,
                                    width: 44,
                                    // color: orangeColor,
                                  ),
                                  scores: "Education",
                                  title1: 'Use-Case: E-learning Platforms',
                                  description1: 'Create dynamic e-learning platforms that support interactive video lessons, quizzes, progress tracking, and community forums. Use Flutter for building cross-platform applications that work seamlessly on mobile and web, Firebase for real-time data synchronization, and GraphQL for efficient and flexible data fetching and management.',
                                  title2: 'Use-Case: School Management Systems',
                                  description2: 'Develop comprehensive school management systems that facilitate the management of student information, attendance records, grading, and communication between students, parents, and teachers. Leverage Flutter for a consistent user interface, Firebase for secure and scalable data storage, and RESTful APIs for integration with other educational tools and services.',
                                ),
                                companyGrowthWidget(
                                  image: Image.asset(
                                    finance,
                                    height: 44,
                                    width: 44,
                                    // color: primaryColor,
                                  ),
                                  scores: "Finance",
                                  title1: 'Use-Case: Fintech Solutions',
                                  description1: 'Design secure and scalable fintech applications that handle various aspects of banking, investment, and personal finance management. Employ Flutter for developing cross-platform applications that provide a smooth user experience, Firebase for real-time data synchronization, and RESTful APIs for connecting with financial services and managing transactions.',
                                  title2: 'Use-Case: Investment Platforms',
                                  description2: 'Create platforms dedicated to investment management, offering features such as portfolio tracking, market analysis, and trading functionalities. Use Flutter for the user interface, Firebase for real-time updates, and GraphQL for efficient data querying to deliver up-to-date investment information and insights.',
                                ),
                                companyGrowthWidget(
                                  image: Image.asset(
                                    realEstate,
                                    height: 44,
                                    width: 44,
                                    // color: primaryColor,
                                  ),
                                  scores: "Real Estate",
                                  title1: 'Use-Case: Property Listing Platforms',
                                  description1: 'Design platforms for listing and searching real estate properties, including features like advanced search filters, virtual property tours, and agent contact functionalities. Implement Flutter for cross-platform application development, Firebase for real-time updates and notifications, and RESTful APIs for integrating with external real estate services.',
                                  title2: 'Use-Case: Real Estate Management Systems',
                                  description2: 'Develop management systems for real estate operations that cover property management, tenant communication, and maintenance tracking. Use Flutter for a user-friendly interface, Firebase for efficient data storage, and AWS for scalable backend services to support the diverse needs of property management.',
                                ),
                                companyGrowthWidget(
                                  image: Image.asset(
                                    automotive,
                                    height: 44,
                                    width: 44,
                                    // color: primaryColor,
                                  ),
                                  scores: "Automotive",
                                  title1: 'Use-Case: Dealership Management Systems',
                                  description1: 'Streamline operations for car dealerships by creating systems that manage inventory, customer relationships, and sales tracking. Leverage Flutter for cross-platform application development, Firebase for real-time data management, and RESTful APIs for integrating with third-party services to enhance dealership operations.',
                                  title2: 'Use-Case: Car Rental Services',
                                  description2: 'Develop applications for managing car rentals, including features for booking, fleet management, and customer support. Use Flutter for mobile app development, Firebase for real-time data synchronization, and AWS for scalable backend services to efficiently handle rental transactions and fleet operations.',
                                ),

                                companyGrowthWidget(
                                  image: Image.asset(
                                    healthCare,
                                    height: 44,
                                    width: 44,
                                    // color: primaryColor,
                                  ),
                                  scores: "Healthcare",
                                  title1: 'Use-Case: Telemedicine Platforms',
                                  description1: 'Enable remote consultations between patients and healthcare providers with features such as video calls, appointment scheduling, and electronic health records (EHR) management. Utilize Flutter for both mobile and web applications, Firebase for real-time data updates, and RESTful APIs for integrating with EHR systems to support telemedicine functionalities.',
                                  title2: 'Use-Case: Patient Management Systems',
                                  description2: 'Create systems for managing patient information, appointments, billing, and communication in a unified platform. Implement Flutter for a user-friendly interface, Firebase for secure data storage, and GraphQL for efficient data querying to provide comprehensive patient management solutions.',
                                ),



                              ],
                            ),

                          ],
                        ),
                      ),
                      Container(
                        key: blogKey,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 120),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                  const SizedBox(
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
                                  const SizedBox(
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
                                              loop: true,
                                              itemBuilder: (context, itemIndex,
                                                  realIndex) {
                                                final item = whyChooseUsItems[itemIndex];

                                                return BlogSliderWidget(
                                                  whyChooseUsItems: item, itemIndex: itemIndex, title: item['title'].toString(), description: item['description'].toString(), image: item['image'].toString(),);
                                              },
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
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
                                const SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 1
                                    ? activeIndicator()
                                    : inActiveIndicator(),
                                const SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 2
                                    ? activeIndicator()
                                    : inActiveIndicator(),
                                const SizedBox(
                                  width: 20,
                                ),
                                portfolioPageNumber == 3
                                    ? activeIndicator()
                                    : inActiveIndicator(),
                                const SizedBox(
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
                        padding: const EdgeInsets.symmetric(vertical: 120),
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
                                                padding: const EdgeInsets.symmetric(
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
                                                              const DecorationImage(
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
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                decoration: BoxDecoration(
                                                  image: const DecorationImage(
                                                    image:
                                                        AssetImage(aboutImage),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        (ResponsiveBreakpoints.of(context)
                                                    .screenWidth <
                                                570)
                                            ? Padding(
                                                padding: const EdgeInsets.symmetric(
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


                                                      const SizedBox(
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
                                                      const SizedBox(
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
                                                      const SizedBox(
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
                                                      const SizedBox(
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
                                                      const SizedBox(
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
                                                            const TextStyle(
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

                                                    const SizedBox(
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
                                                    const SizedBox(
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
                                                    const SizedBox(
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
                                                    const SizedBox(
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
                                                    const SizedBox(
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
                                                          const TextStyle(
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
                                          padding: const EdgeInsets.symmetric(
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

                                              const SizedBox(
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
                                              const SizedBox(
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
                                              const SizedBox(
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
                                              const SizedBox(
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
                                              const SizedBox(
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
                                                buttonTitleStyle: const TextStyle(
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
                                        const SizedBox(
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
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
                          padding: const EdgeInsets.symmetric(vertical: 120),
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
                              const SizedBox(
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
                                      const SizedBox(
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
                                                    prefixButtonIcon: const Icon(
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
                                                    buttonTitleStyle: const TextStyle(
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
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: const Icon(
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
                                                    buttonTitleStyle: const TextStyle(
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
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: const Icon(
                                                      FontAwesomeIcons.twitter,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                    suffixButtonIcon: null,
                                                    isFullWidth: false,
                                                    isOutlined: true,
                                                    buttonTitle: null,
                                                    onPressed: () async {},
                                                    buttonTitleStyle: const TextStyle(
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
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: const Icon(
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
                                                    buttonTitleStyle: const TextStyle(
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
                                      const SizedBox(
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
                                                    "Copyright © 2024. All Rights Reserved",
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
                                                    prefixButtonIcon: const Icon(
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
                                                    buttonTitleStyle: const TextStyle(
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
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: const Icon(
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
                                                    buttonTitleStyle: const TextStyle(
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
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: const Icon(
                                                      FontAwesomeIcons.twitter,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                    suffixButtonIcon: null,
                                                    isFullWidth: false,
                                                    isOutlined: true,
                                                    buttonTitle: null,
                                                    onPressed: () async {},
                                                    buttonTitleStyle: const TextStyle(
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
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomizableTextButton(
                                                    prefixButtonIcon: const Icon(
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
                                                    buttonTitleStyle: const TextStyle(
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
                                                    "Copyright © 2024. All Rights Reserved",
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
                                            prefixButtonIcon: const Icon(
                                              FontAwesomeIcons.facebookF,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            suffixButtonIcon: null,
                                            isFullWidth: false,
                                            isOutlined: true,
                                            buttonTitle: null,
                                            onPressed: () async {},
                                            buttonTitleStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            buttonBorderRadius: 60,
                                            buttonColor: primaryColor,
                                            horizontalPadding: 40,
                                            verticalPadding: 16,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomizableTextButton(
                                            prefixButtonIcon: const Icon(
                                              FontAwesomeIcons.linkedinIn,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            suffixButtonIcon: null,
                                            isFullWidth: false,
                                            isOutlined: true,
                                            buttonTitle: null,
                                            onPressed: () async {},
                                            buttonTitleStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            buttonBorderRadius: 60,
                                            buttonColor: primaryColor,
                                            horizontalPadding: 40,
                                            verticalPadding: 16,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomizableTextButton(
                                            prefixButtonIcon: const Icon(
                                              FontAwesomeIcons.twitter,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            suffixButtonIcon: null,
                                            isFullWidth: false,
                                            isOutlined: true,
                                            buttonTitle: null,
                                            onPressed: () async {},
                                            buttonTitleStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            buttonBorderRadius: 60,
                                            buttonColor: primaryColor,
                                            horizontalPadding: 40,
                                            verticalPadding: 16,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomizableTextButton(
                                            prefixButtonIcon: const Icon(
                                              FontAwesomeIcons.instagram,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            suffixButtonIcon: null,
                                            isFullWidth: false,
                                            isOutlined: true,
                                            buttonTitle: null,
                                            onPressed: () async {},
                                            buttonTitleStyle: const TextStyle(
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
                                            "Copyright © 2024. All Rights Reserved",
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
      padding: const EdgeInsets.all(25),
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
      {required Widget image, required String scores, required String title1,required String description1, required String title2,required String description2}) {
    return (ResponsiveBreakpoints.of(context).screenWidth < 575)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          image,
                          const SizedBox(
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
                          const SizedBox(
                            height: 6,
                          ),
                          titleDescriptionWidget(title: title1,description: description1),
                          titleDescriptionWidget(title: title2,description: description2),

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
              padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image,
                  const SizedBox(
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
                  const SizedBox(
                    height: 6,
                  ),
                  titleDescriptionWidget(title: title1,description: description1),
                  titleDescriptionWidget(title: title2,description: description2),
                ],
              ),
            ),
          );
  }


  Widget titleDescriptionWidget({required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
            fontSize:
            (ResponsiveBreakpoints.of(context).screenWidth <
                765)
                ? 12
                : 14,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.75),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          description,
          textAlign: TextAlign.justify,
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
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }


  Widget activeIndicator() {
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: primaryColor,
      ),
      child: Container(
        height: 8,
        width: 8,
        decoration: const BoxDecoration(
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
      decoration: const BoxDecoration(
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
        const SizedBox(
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
        padding: const EdgeInsets.symmetric(vertical: 12),
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
      height: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
          ? (ResponsiveBreakpoints.of(context).screenWidth < 985)
          ? (ResponsiveBreakpoints.of(context).screenWidth < 765)
          ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
          ? 632 // Updated from 586
          : 877 // Updated from 815
          : 700 // Updated from 650
          : 890 // Updated from 826
          : 741, // Updated from 706



      // height: (ResponsiveBreakpoints.of(context).screenWidth < 1200)
      //     ? (ResponsiveBreakpoints.of(context).screenWidth < 985)
      //         ? (ResponsiveBreakpoints.of(context).screenWidth < 765)
      //             ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
      //                 ? 238
      //                 : 332
      //             : 264
      //         : 336
      //     : 286,
      width: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
          ? (ResponsiveBreakpoints.of(context).screenWidth < 985)
          ? (ResponsiveBreakpoints.of(context).screenWidth < 765)
          ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
          ? 905 // 550 adjusted to 905
          : 400 // 243 adjusted to 400
          : 548 // 333 adjusted to 548
          : 494 // 300 adjusted to 494
          : 605, // 380 adjusted to 625

      padding: EdgeInsets.symmetric(
          horizontal:
              (ResponsiveBreakpoints.of(context).screenWidth < 575) ? 23 : 30,
          vertical:
              (ResponsiveBreakpoints.of(context).screenWidth < 575) ? 32 : 40),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: icon),
            SizedBox(
              height: (ResponsiveBreakpoints.of(context).screenWidth < 985)
                  ? (ResponsiveBreakpoints.of(context).screenWidth < 765)
                      ? 22
                      : 10
                  : 22,
            ),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
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
      ),
    );
  }
}
