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

class DetailsScreen extends ConsumerStatefulWidget {
  final String title;
  final String description;
  final String image;

  const DetailsScreen(this.title, this.description, this.image, {super.key});

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: (ResponsiveBreakpoints.of(context).screenWidth < 770)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              ResponsiveBreakpoints.of(context).largerOrEqualTo(DESKTOP) ? 50 : 15,
                          vertical: 10),
                      child: Image.asset(
                        logoImageInvertedTechnology,
                        height: (ResponsiveBreakpoints.of(context).screenWidth < 750) ? 50 : 60,
                        width: (ResponsiveBreakpoints.of(context).screenWidth < 750) ? 100 : 132,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: Icon(Icons.arrow_back),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Details",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GradientText(
                                widget.title.toUpperCase(),
                                style: GoogleFonts.anton(
                                  fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                      ? 30
                                      : 50,
                                  fontWeight: FontWeight.w600,
                                ),
                                colors: [
                                  gradientColor1,
                                  gradientColor2,
                                  gradientColor3,
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 30),
                                child: Image.asset(widget.image,
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width),
    ),

                              SizedBox(
                                height: 20,
                              ),
                              titleDescriptionWidget(
                                title: "Description",
                                description: widget.description,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              // titleDescriptionWidget(
                              //   title: "2. Scalability",
                              //   description:
                              //       "Startups are dynamic entities that grow and evolve rapidly. Custom software can be designed with scalability in mind, allowing for easy modifications and updates as the business grows. This flexibility ensures that the software remains relevant and useful throughout the startup's lifecycle.",
                              // ),
                              // titleDescriptionWidget(
                              //   title: "3. Competitive Advantage",
                              //   description:
                              //       "In a saturated market, differentiation is key. Custom software can provide startups with unique features and capabilities that competitors might not have. This can be a significant advantage when trying to establish a foothold in the market.",
                              // ),
                              // titleDescriptionWidget(
                              //   title: "4. Integration with Existing Systems",
                              //   description:
                              //       "Off-the-shelf software might not always integrate seamlessly with a startup's existing systems or third-party applications. Custom software can be designed to ensure smooth integration, reducing friction and inefficiencies.",
                              // ),
                              // titleDescriptionWidget(
                              //   title: "5. Cost-Effective in the Long Run",
                              //   description:
                              //       "While the initial investment in custom software might be higher than purchasing off-the-shelf solutions, the long-term benefits often outweigh the costs. Custom software can reduce the need for multiple software licenses, eliminate the costs associated with workarounds or additional integrations, and decrease training time for employees.",
                              // ),
                              // titleDescriptionWidget(
                              //   title: "6. Enhanced Security",
                              //   description:
                              //       "Custom software can be designed with a startup's specific security needs in mind. This can be especially important for startups dealing with sensitive data or operating in regulated industries. Custom-built solutions can offer enhanced security features tailored to the startup's requirements.",
                              // ),
                              // titleDescriptionWidget(
                              //   title: "7. Improved Customer Experience",
                              //   description:
                              //       "By designing software that aligns with a startup's operations and goals, it's possible to offer a better experience for customers. Whether it's through faster response times, personalized interactions, or unique features, custom software can enhance the overall customer journey.",
                              // ),
                              // titleDescriptionWidget(
                              //   title: "8. Ownership and Control",
                              //   description:
                              //       "Owning the rights to custom software gives startups full control over its features, updates, and modifications. This level of control can be crucial for startups that want to pivot, adapt, or introduce new features quickly.",
                              // ),
                              // titleDescriptionWidget(
                              //   title: "9. Support and Maintenance",
                              //   description:
                              //       "With custom software, startups often have direct access to the developers or the development team. This can lead to faster response times, better support, and more efficient troubleshooting compared to dealing with large software vendors.",
                              // ),
                              // titleDescriptionWidget(
                              //   title: "10. Future-Proofing the Business",
                              //   description:
                              //       "The digital landscape is constantly evolving. By investing in custom software, startups can ensure that they have a foundation that can adapt and evolve with technological advancements and market demands.",
                              // ),
                              // SizedBox(
                              //   height: 34,
                              // ),
                              // titleDescriptionWidget(
                              //   title: "Conclusion",
                              //   description:
                              //       """While the initial investment in custom software might seem daunting, the long-term benefits are undeniable. From tailored solutions and scalability to competitive advantages and enhanced security, custom software can provide startups with the tools they need to succeed in today's competitive market. As the saying goes, "You have to spend money to make money," and in the case of custom software, the investment can lead to significant returns.""",
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              ResponsiveBreakpoints.of(context).largerOrEqualTo(DESKTOP) ? 50 : 15,
                          vertical: 10),
                      child: Image.asset(
                        logoImageInvertedTechnology,
                        height: (ResponsiveBreakpoints.of(context).screenWidth < 750) ? 50 : 60,
                        width: (ResponsiveBreakpoints.of(context).screenWidth < 750) ? 100 : 132,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),
                                                  child: Center(
                                                    child: Icon(Icons.arrow_back),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Details",
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GradientText(
                                          widget.title.toUpperCase(),
                                          style: GoogleFonts.anton(
                                            fontSize: 50,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          colors: [
                                            gradientColor1,
                                            gradientColor2,
                                            gradientColor3,
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 30),
                                          child: Image.asset(widget.image,
                                              fit: BoxFit.cover,
                                              height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        titleDescriptionWidget(
                                          title: "Description",
                                          description: widget.description,
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        // SizedBox(
                                        //   height: 34,
                                        // ),
                                        // titleDescriptionWidget(
                                        //   title: "Conclusion",
                                        //   description:
                                        //       """While the initial investment in custom software might seem daunting, the long-term benefits are undeniable. From tailored solutions and scalability to competitive advantages and enhanced security, custom software can provide startups with the tools they need to succeed in today's competitive market. As the saying goes, "You have to spend money to make money," and in the case of custom software, the investment can lead to significant returns.""",
                                        // ),
                                      ],
                                    ),
                                  ),
                                  // Expanded(
                                  //   child: Column(
                                  //     mainAxisAlignment: MainAxisAlignment.start,
                                  //     children: [
                                  //       Image.asset(detailsPageImage),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          description,
          textAlign: TextAlign.justify,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
