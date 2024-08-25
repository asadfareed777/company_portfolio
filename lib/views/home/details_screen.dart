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
  final Map<String, String> whyChooseUsItems;

  const DetailsScreen(this.whyChooseUsItems, {super.key});

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
                                widget.whyChooseUsItems["title"]!.toUpperCase(),
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
                                child: Image.asset(widget.whyChooseUsItems["image"]!,
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width),
    ),

                              SizedBox(
                                height: 20,
                              ),
                              titleDescriptionWidget(
                                title: "Description",
                                description: widget.whyChooseUsItems["description"].toString(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.whyChooseUsItems["header"].toString(),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              titleDescriptionWidget(
                                title: widget.whyChooseUsItems["heading1"].toString(),
                                description: widget.whyChooseUsItems["description1"].toString()
                              ),
                              titleDescriptionWidget(
                                title: widget.whyChooseUsItems["heading2"].toString(),
                                description: widget.whyChooseUsItems["description2"].toString()
                              ),
                              titleDescriptionWidget(
                                  title: widget.whyChooseUsItems["heading3"].toString(),
                                  description: widget.whyChooseUsItems["description3"].toString()
                              ),
                              titleDescriptionWidget(
                                  title: widget.whyChooseUsItems["heading4"].toString(),
                                  description: widget.whyChooseUsItems["description4"].toString()
                              ),

                              SizedBox(
                                height: 34,
                              ),

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
                                          widget.whyChooseUsItems["title"]!.toUpperCase(),
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
                                          child: Image.asset(widget.whyChooseUsItems["image"]!,
                                              fit: BoxFit.cover,
                                              height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width),
                                        ),

                                        SizedBox(
                                          height: 20,
                                        ),
                                        titleDescriptionWidget(
                                          title: "Description",
                                          description: widget.whyChooseUsItems["description"].toString(),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          widget.whyChooseUsItems["header"].toString(),
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        titleDescriptionWidget(
                                            title: widget.whyChooseUsItems["heading1"].toString(),
                                            description: widget.whyChooseUsItems["description1"].toString()
                                        ),
                                        titleDescriptionWidget(
                                            title: widget.whyChooseUsItems["heading2"].toString(),
                                            description: widget.whyChooseUsItems["description2"].toString()
                                        ),
                                        titleDescriptionWidget(
                                            title: widget.whyChooseUsItems["heading3"].toString(),
                                            description: widget.whyChooseUsItems["description3"].toString()
                                        ),
                                        titleDescriptionWidget(
                                            title: widget.whyChooseUsItems["heading4"].toString(),
                                            description: widget.whyChooseUsItems["description4"].toString()
                                        ),

                                        SizedBox(
                                          height: 34,
                                        ),

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
