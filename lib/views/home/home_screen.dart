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
import 'package:url_launcher/url_launcher.dart';
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
      "image": quranApp,
      "explanation":
      "Kuwait Mushaf, developed with Flutter, is a user-friendly Quran app offering a complete Quran text with audio from renowned reciters. Explore translations, detailed Tafseer, and study the 10 readings with highlighted words. Customize your experience with downloadable recitations and personalized settings for language and appearance."
    },
    {
      "stackName": "Java & Kotlin",
      "projectName": "Urbie - IoT-Based Home Automation App",
      "image": portfolio2Image,
      "explanation":
      "Urbie, built with Java and Kotlin, is an IoT-based Android app for smart home automation. It lets users control home appliances like fans, LEDs, and water tanks, using AWS MQTT for real-time cloud control and secure databases for device status management."
    },
    {
      "stackName": "Java & Kotlin",
      "image": portfolioTwo,
      "projectName": "Salama",
      "explanation": "Salama is an application which is developed for UAE states. It's enforce that the companies operating in UAE are taking appropriate safety measures for their employees.",
    },
    {
      "stackName": "Java & Kotlin",
      "image": portfolioThree,
      "projectName": "Yo Promos",
      "explanation": "Discover the best promotions and deals from top brands with our promotional app, showcasing exclusive offers and discounts tailored just for you.",
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


  void _sendEmail() async {
    final String yourName = yourNameEditingController.text;
    final String yourPhone = yourPhoneEditingController.text;
    final String yourEmail = yourEmailEditingController.text;
    final String yourMessage = yourMessageEditingController.text;

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'invertedtec@gmail.com',
      query: Uri.encodeFull(
          'subject=Contact Form Submission&'
              'body=Name: $yourName\n'
              'Phone: $yourPhone\n'
              'Email: $yourEmail\n'
              'Message: $yourMessage'
      ),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
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
                        logoImageInvertedTechnologyWhite,
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
                // drawerNavButton(
                //   title: "Blog",
                //   onPressed: () async {
                //     Navigator.pop(context);
                //     await Scrollable.ensureVisible(blogKey.currentContext!,
                //         duration: const Duration(milliseconds: 1000),
                //         curve: Curves.fastEaseInToSlowEaseOut);
                //   },
                // ),
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
                                  // navButton(
                                  //   title: "Blog",
                                  //   textColor: Colors.black,
                                  //   onPressed: () async {
                                  //     await Scrollable.ensureVisible(
                                  //         blogKey.currentContext!,
                                  //         duration: const Duration(
                                  //             milliseconds: 1000),
                                  //         curve:
                                  //             Curves.fastEaseInToSlowEaseOut);
                                  //   },
                                  // ),
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
                        height: (ResponsiveBreakpoints.of(context).screenWidth < 1000)
                            ? (ResponsiveBreakpoints.of(context).screenWidth < 760)
                            ? (ResponsiveBreakpoints.of(context).screenWidth < 550)
                            ? 600  // Height for screens smaller than 550px
                            : 660  // Height for screens between 550px and 760px
                            : 720  // Height for screens between 760px and 1000px
                            : 720, // Height for screens larger than 1000px
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
                                        logoImageInvertedTechnologyWhite,
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

                                                  // navButton(
                                                  //   title: "Blog",
                                                  //   onPressed: () async {
                                                  //     await Scrollable.ensureVisible(
                                                  //         blogKey
                                                  //             .currentContext!,
                                                  //         duration:
                                                  //             const Duration(
                                                  //                 milliseconds:
                                                  //                     1000),
                                                  //         curve: Curves
                                                  //             .fastEaseInToSlowEaseOut);
                                                  //   },
                                                  // ),
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
                                        "Honor Our Commitments With Integrity And Quality.",
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
                                    const SizedBox(height: 10,),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 80.w),
                                      child: Text(
                                        "At Inverted Technology, we are committed to empowering businesses through innovative, high-impact software solutions. With a foundation rooted in integrity and driven by quality, we specialize in cutting-edge technologies like Flutter, Android, iOS, AI/ML, and web development. Our mission is to translate ideas into transformative digital experiences that not only exceed expectations but also drive lasting success for our clients. We foster transparent communication and build trust through our multidisciplinary tech team, ensuring that every partnership is grounded in mutual respect and exceptional results.",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              (ResponsiveBreakpoints.of(context)
                                                          .screenWidth <
                                                      765)
                                                  ? 13
                                                  : 21,
                                          fontWeight: FontWeight.w100,
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
                            GradientText(
                              textAlign: TextAlign.center,
                              "Cutting-Edge Technology",
                              style: GoogleFonts
                                  .montserrat(
                                fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                                    ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                                    ? (ResponsiveBreakpoints.of(context).screenWidth < 550)
                                    ? 18  // Font size for screens smaller than 550px
                                    : 23  // Font size for screens between 550px and 755px
                                    : 34  // Font size for screens between 755px and 1250px
                                    : 45, // Font size for screens larger than 1250px

                                fontWeight:
                                FontWeight.w900,
                              ),
                              colors: [
                                gradientColor1,
                                gradientColor2,
                                gradientColor3,
                              ],
                            ),
                            const SizedBox(height: 50),
                            Wrap(
                          //       spacing: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                          //           ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                          //           ? (ResponsiveBreakpoints.of(context).screenWidth < 550)
                          //           ? 40  // Width for screens smaller than 550px
                          //           : 60  // Width for screens between 550px and 755px
                          //           : 90   // Width for screens between 755px and 1250px
                          //           : 120,
                          //     runSpacing: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                          // ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                          // ? (ResponsiveBreakpoints.of(context).screenWidth < 550)
                          // ? 40  // Width for screens smaller than 550px
                          // : 60  // Width for screens between 550px and 755px
                          // : 90   // Width for screens between 755px and 1250px
                          // : 120,
                              spacing: 30,
                              runSpacing: 30,
                              children: [
                                companyStacksWidget(
                                    image: Image.asset(
                                      flutterIcon,
                                      // color: lightBlueColor,
                                        height: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                                            ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                                            ? (ResponsiveBreakpoints.of(context).screenWidth < 550)
                                            ? 40  // Height for screens smaller than 550px
                                            : 50  // Height for screens between 550px and 755px
                                            : 75      // Height for screens between 755px and 1250px
                                            : 100,       // Height for screens larger than 1250px
                                        width: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                                            ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                                            ? (ResponsiveBreakpoints.of(context).screenWidth < 550)
                                            ? 40  // Width for screens smaller than 550px
                                            : 50  // Width for screens between 550px and 755px
                                            : 75      // Width for screens between 755px and 1250px
                                            : 100,  // Width for screens larger than 1250px
                                    ),
                                  title: 'Flutter Development',
                                  description: 'Experience the power of cross-platform development with Flutter. We craft stunning, high-performance mobile applications that deliver a consistent and seamless experience across both Android and iOS, ensuring your brand shines on every device.',
                                ),
                                companyStacksWidget(
                                  image: Image.asset(
                                    appleIcon,
                                    // color: lightBlueColor,
                                      height: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 550)
                                          ? 40  // Height for screens smaller than 550px
                                          : 50  // Height for screens between 550px and 755px
                                          : 75      // Height for screens between 755px and 1250px
                                          : 100,       // Height for screens larger than 1250px
                                      width: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 550)
                                          ? 40  // Width for screens smaller than 550px
                                          : 50  // Width for screens between 550px and 755px
                                          : 75      // Width for screens between 755px and 1250px
                                          : 100,  // Width for screens larger than 1250px
                                  ),
                                  title: 'iOS Development',
                                  description: 'Elevate your business in the Apple ecosystem with sophisticated iOS applications. Our expert developers use the latest in Swift technology to deliver elegant, secure, and intuitive apps that resonate with users and enhance your brand\'s digital presence.',
                                ),
                                companyStacksWidget(
                                  image: Image.asset(
                                    androidIcon,
                                    // color: lightBlueColor,
                                    height: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                                        ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                                        ? (ResponsiveBreakpoints.of(context).screenWidth < 550)
                                        ? 40  // Height for screens smaller than 550px
                                        : 50  // Height for screens between 550px and 755px
                                        : 75      // Height for screens between 755px and 1250px
                                        : 100,       // Height for screens larger than 1250px
                                    width: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                                        ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                                        ? (ResponsiveBreakpoints.of(context).screenWidth < 550)
                                        ? 40  // Width for screens smaller than 550px
                                        : 50  // Width for screens between 550px and 755px
                                        : 75      // Width for screens between 755px and 1250px
                                        : 100,  // Width for screens larger than 1250px
                                  ),
                                  title: 'Android Development',
                                  description: 'Unlock the full potential of the Android ecosystem with custom-built applications. Our Android development team combines cutting-edge technology with innovative design to create robust, user-friendly apps that engage your audience and drive business success.',
                                ),
                                companyStacksWidget(
                                  image: Image.asset(
                                    artificialIntelligence,
                                    // color: lightBlueColor,
                                      height: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 550)
                                          ? 40  // Height for screens smaller than 550px
                                          : 50  // Height for screens between 550px and 755px
                                          : 75      // Height for screens between 755px and 1250px
                                          : 100,       // Height for screens larger than 1250px
                                      width: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                                          ? (ResponsiveBreakpoints.of(context).screenWidth < 550)
                                          ? 40  // Width for screens smaller than 550px
                                          : 50  // Width for screens between 550px and 755px
                                          : 75      // Width for screens between 755px and 1250px
                                          : 100,  // Width for screens larger than 1250px
                                  ),
                                  title: 'Artificial Intelligence & Machine Learning',
                                  description: 'Transform your business with the power of AI and Machine Learning. Our advanced AI/ML solutions unlock new opportunities for innovation, from predictive analytics to intelligent automation, driving smarter decisions and creating a competitive edge.',
                                ),
                                companyStacksWidget(
                                  image: Image.asset(
                                    webIcon,
                                    // color: lightBlueColor,
                                    height: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                                        ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                                        ? (ResponsiveBreakpoints.of(context).screenWidth < 550)
                                        ? 40  // Height for screens smaller than 550px
                                        : 50  // Height for screens between 550px and 755px
                                        : 75      // Height for screens between 755px and 1250px
                                        : 100,       // Height for screens larger than 1250px
                                    width: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                                        ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                                        ? (ResponsiveBreakpoints.of(context).screenWidth < 550)
                                        ? 40  // Width for screens smaller than 550px
                                        : 50  // Width for screens between 550px and 755px
                                        : 75      // Width for screens between 755px and 1250px
                                        : 100,  // Width for screens larger than 1250px
                                  ),
                                  title: 'Web Development',
                                  description: 'Captivate and convert with a website that stands out. Our web development services blend cutting-edge technologies like Laravel, ReactJS, and WordPress to create responsive, secure, and visually compelling websites that make a lasting impact.',
                                ),
                              ],
                            ),
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
                                                        AssetImage(aboutImage1),
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
                                                          fontSize: (ResponsiveBreakpoints.of(
                                                              context)
                                                              .screenWidth <
                                                              765)
                                                              ? 16
                                                              : 50,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        colors: [
                                                          gradientColor1,
                                                          gradientColor2,
                                                          gradientColor3,
                                                        ],
                                                      ),
                                                      // SizedBox(
                                                      //   height: 12.h,
                                                      // ),
                                                      Visibility(
                                                        visible: false,
                                                        child: Text(
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
                                                      ),
                                                      SizedBox(
                                                        height: 16.h,
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
                                                        height: 40,
                                                      ),
                                                      aboutUsTitleDescription(
                                                        title: "Integrity",
                                                        description: "We uphold the highest standards of integrity, building trust through transparency and ethical practices.",
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      aboutUsTitleDescription(
                                                        title: "Innovation",
                                                        description: "We drive innovation in everything we do, leveraging cutting-edge technology to keep our clients ahead.",
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      aboutUsTitleDescription(
                                                        title: "Excellence",
                                                        description: "WWe pursue excellence in every project, delivering superior quality through meticulous attention to detail.",
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      aboutUsTitleDescription(
                                                        title: "Collaboration",
                                                        description: "We believe in the power of collaboration, working closely with clients to co-create tailored solutions.",
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      aboutUsTitleDescription(
                                                        title: "Reliability",
                                                        description: "We are committed to being a reliable partner, ensuring consistent and timely delivery of results.",
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      aboutUsTitleDescription(
                                                        title: "Client Focus",
                                                        description: "Our clients are at the center of our work, prioritizing their needs to deliver tailored, impactful solutions.",
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
                                                        fontSize: (ResponsiveBreakpoints.of(
                                                            context)
                                                            .screenWidth <
                                                            765)
                                                            ? 16
                                                            : 50,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                      ),
                                                      colors: [
                                                        gradientColor1,
                                                        gradientColor2,
                                                        gradientColor3,
                                                      ],
                                                    ),
                                                    // SizedBox(
                                                    //   height: 12.h,
                                                    // ),
                                                    Visibility(
                                                      visible: false,
                                                      child: Text(
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
                                                    ),
                                                    SizedBox(
                                                      height: 16.h,
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
                                                      height: 40,
                                                    ),
                                                    aboutUsTitleDescription(
                                                      title: "Integrity",
                                                      description: "We uphold the highest standards of integrity, building trust through transparency and ethical practices.",
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    aboutUsTitleDescription(
                                                      title: "Innovation",
                                                      description: "We drive innovation in everything we do, leveraging cutting-edge technology to keep our clients ahead.",
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    aboutUsTitleDescription(
                                                      title: "Excellence",
                                                      description: "WWe pursue excellence in every project, delivering superior quality through meticulous attention to detail.",
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    aboutUsTitleDescription(
                                                      title: "Collaboration",
                                                      description: "We believe in the power of collaboration, working closely with clients to co-create tailored solutions.",
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    aboutUsTitleDescription(
                                                      title: "Reliability",
                                                      description: "We are committed to being a reliable partner, ensuring consistent and timely delivery of results.",
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    aboutUsTitleDescription(
                                                      title: "Client Focus",
                                                      description: "Our clients are at the center of our work, prioritizing their needs to deliver tailored, impactful solutions.",
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
                                              image: AssetImage(aboutImage1),
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
                                                style: GoogleFonts
                                                    .montserrat(
                                                  fontSize: (ResponsiveBreakpoints.of(
                                                      context)
                                                      .screenWidth <
                                                      765)
                                                      ? 16
                                                      : 50,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                ),
                                                colors: [
                                                  gradientColor1,
                                                  gradientColor2,
                                                  gradientColor3,
                                                ],
                                              ),
                                              // SizedBox(
                                              //   height: 12.h,
                                              // ),
                                              Visibility(
                                                visible: false,
                                                child: Text(
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
                                              ),
                                              SizedBox(
                                                height: 16.h,
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
                                                height: 40,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: aboutUsTitleDescription(
                                                      title: "Integrity",
                                                      description: "We uphold the highest standards of integrity, building trust through transparency and ethical practices.",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child: aboutUsTitleDescription(
                                                      title: "Innovation",
                                                      description: "We drive innovation in everything we do, leveraging cutting-edge technology to keep our clients ahead.",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child:  aboutUsTitleDescription(
                                                      title: "Excellence",
                                                      description: "We pursue excellence in every project, delivering superior quality through meticulous attention to detail.",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child:aboutUsTitleDescription(
                                                      title: "Collaboration",
                                                      description: "We believe in the power of collaboration, working closely with clients to co-create tailored solutions.",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: aboutUsTitleDescription(
                                                      title: "Reliability",
                                                      description: "We are committed to being a reliable partner, ensuring consistent and timely delivery of results.",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child:aboutUsTitleDescription(
                                                      title: "Client Focus",
                                                      description: "Our clients are at the center of our work, prioritizing their needs to deliver tailored, impactful solutions.",
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
                              height: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                                  ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                  ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                  ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                  ? 600.h   // Adjusted height for screens smaller than 575px
                                  : 363     // Adjusted height for screens between 575px and 770px
                                  : 328         // Adjusted height for screens between 770px and 990px
                                  : 419             // Adjusted height for screens between 990px and 1270px
                                  : 534,                // Adjusted height for screens larger than 1270px

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
                                                  explanation: item['explanation']!,
                                                  image: item['image']!,);
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
                                  scores: "E-commerce",
                                  description: 'Transform your online business with scalable, high-performance e-commerce solutions. Our platforms enhance user experience, streamline operations, and seamlessly integrate with the latest payment systems and analytics tools, driving your digital growth.',
                                ),
                                companyGrowthWidget(
                                  scores: "Innovative Education",
                                  description: 'Revolutionize the education sector with cutting-edge digital solutions. We develop intuitive platforms that support educators and students, improving engagement, facilitating remote learning, and optimizing administrative efficiency.',
                                ),
                                companyGrowthWidget(
                                  scores: "Financial Empowerment",
                                  description: 'Elevate your financial services with secure, compliant software solutions. Our expertise in mobile banking, investment management, and financial analytics empowers institutions to deliver advanced, efficient, and innovative services.',
                                ),
                                companyGrowthWidget(
                                  scores: "Real Estate Optimization",
                                  description: 'Unlock new opportunities in real estate with digital tools designed to streamline property management, enhance client engagement, and drive sales. Our solutions are tailored to the unique needs of agents, brokers, and firms.',
                                ),
                                companyGrowthWidget(
                                  scores: "Automotive Innovation",
                                  description: 'Drive the future of the automotive industry with advanced software that enhances vehicle connectivity, streamlines dealership operations, and improves customer experience. Our technology supports innovation in vehicle management and sales..',
                                ),

                                companyGrowthWidget(
                                  scores: "Healthcare Advancement",
                                  description: 'Advance patient care and operational efficiency with secure, compliant healthcare solutions. We specialize in developing applications for patient management, telemedicine, and health monitoring, ensuring improved outcomes for all.',
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Container(
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
                              SizedBox(
                                height: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                                    ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                    ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                    ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                    ? 600.h   // Adjusted height for screens smaller than 575px
                                    : 363     // Adjusted height for screens between 575px and 770px
                                    : 328         // Adjusted height for screens between 770px and 990px
                                    : 419             // Adjusted height for screens between 990px and 1270px
                                    : 534,                // Adjusted height for screens larger than 1270px

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
                                                loop: false,
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
                                                                contactUs),
                                                            fit:
                                                                BoxFit.cover,
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
                                                        AssetImage(contactUs),
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
                                                              FontWeight.w600,
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
                                                        onPressed: () async {
                                                          _sendEmail();
                                                        },
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
                                                            FontWeight.w600,
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
                                                      onPressed: () async {
                                                        _sendEmail();
                                                      },
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
                                                onPressed: () async {
                                                  _sendEmail();
                                                },
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
                                              image: AssetImage(contactUs),
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
                      Visibility(
                          visible: false,
                        child: Container(
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
                                                    logoImageInvertedTechnologyWhite,
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
                                                    logoImageInvertedTechnologyWhite,
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
                                                    onPressed: () async {
                                                      const url = 'https://www.facebook.com/invertedtec';
                                                      if (await canLaunch(url)) {
                                                        await launch(url);
                                                      } else {
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
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
                                                    onPressed: () async {
                                                      const url = 'https://www.linkedin.com/in/inverted-technology-240029258/';
                                                      if (await canLaunch(url)) {
                                                        await launch(url);
                                                      } else {
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
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
                                                    onPressed: () async {
                                                      const url = 'https://x.com/invertedtec';
                                                      if (await canLaunch(url)) {
                                                        await launch(url);
                                                      } else {
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
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
                                                    onPressed: () async {
                                                      const url = 'https://www.instagram.com/invertedtechnology/';
                                                      if (await canLaunch(url)) {
                                                        await launch(url);
                                                      } else {
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
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
                                            logoImageInvertedTechnologyWhite,
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
                                            onPressed: () async {
                                              const url = 'https://www.facebook.com/invertedtec';
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            },
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
                                            onPressed: () async {
                                              const url = 'https://www.linkedin.com/in/inverted-technology-240029258/';
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            },
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
                                            onPressed: () async {
                                              const url = 'https://x.com/invertedtec';
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            },
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
                                            onPressed: () async {
                                              const url = 'https://www.instagram.com/invertedtechnology/';
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            },
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
      {
        // required Widget image,
        required String scores, required String description,}) {
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
                          // image,
                          // const SizedBox(
                          //   height: 20,
                          // ),
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
                  // image,
                  // const SizedBox(
                  //   height: 20,
                  // ),
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
                ],
              ),
            ),
          );
  }



  Widget companyStacksWidget(
      {required Widget image,required String title,required String description}) {
    return (ResponsiveBreakpoints.of(context).screenWidth < 575)
        ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
            Expanded(
              child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    width: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                        ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
                        ? 185 // Updated width for screens smaller than 755px
                        : 213 // Updated width for screens between 755px and 1250px
                        : 250,   // Updated width for screens larger than 1250px
                    decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      image,
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        title,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontSize:
                          (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                              ?  13
                          : 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        description,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontSize:
                          (ResponsiveBreakpoints.of(context).screenWidth <
                              1250)
                              ? 12
                              : 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),
          ],
        )
        : Container(
        width: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
            ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
            ? 185 // Updated width for screens smaller than 755px
            : 213 // Updated width for screens between 755px and 1250px
            : 250,   // Updated width for screens larger than 1250px



        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image,
              const SizedBox(
                height: 20,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize:
                  (ResponsiveBreakpoints.of(context).screenWidth < 1250)
                      ? 13
                      : 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.75),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                description,
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontSize:
                  (ResponsiveBreakpoints.of(context).screenWidth <
                      1250)
                      ? 12
                      : 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.75),
                ),
              ),

            ],
          ),
        ));
  }


  // Widget companyStacksWidget(
  //     {required Widget image,}) {
  //   return (ResponsiveBreakpoints.of(context).screenWidth < 575)
  //       ? Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Expanded(
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: Container(
  //               width: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
  //                   ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
  //                   ? 148 // Updated width for screens smaller than 755px
  //                   : 170 // Updated width for screens between 755px and 1250px
  //                   : 200,  // Updated width for screens larger than 1250px
  //
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 40),
  //                 child: image,
  //               )),
  //         ),
  //       ),
  //     ],
  //   )
  //       : Container(
  //       width: (ResponsiveBreakpoints.of(context).screenWidth < 1250)
  //           ? (ResponsiveBreakpoints.of(context).screenWidth < 755)
  //           ? 148 // Updated width for screens smaller than 755px
  //           : 170 // Updated width for screens between 755px and 1250px
  //           : 200,  // Updated width for screens larger than 1250px
  //
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 40),
  //         child: image,
  //       ));
  // }


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
