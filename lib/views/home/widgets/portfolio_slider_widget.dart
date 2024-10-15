import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/utils/image_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/colors.dart';
import '../../artificialintelligence/home/home.dart';

class PortfolioSliderWidget extends StatefulWidget {
  final int itemIndex;
  final String stackName;
  final String projectName;
  final String explanation;
  final String image;
  const PortfolioSliderWidget({super.key, required this.itemIndex, required this.stackName, required this.projectName, required this.explanation, required this.image});

  @override
  State<PortfolioSliderWidget> createState() => _PortfolioSliderWidgetState();
}

class _PortfolioSliderWidgetState extends State<PortfolioSliderWidget> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        print(value);
        isHovered = value;
        setState(() {});
      },
      onTap: () {
        isHovered = !isHovered;
        setState(() {});

        if (widget.itemIndex == 0) {
        // Navigate to NewHomePage when the first item is clicked
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const HomePageAIModule(),
        //   ),
        // );
        // Navigate to NewHomePage when the first item is clicked
        launch('https://www.invertedtechnology.com/facial');
        }
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
                            widget.image
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
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    widget.stackName,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 500)
                                          ? 12  // Font size for screens smaller than 500px
                                          : (ResponsiveBreakpoints.of(context).screenWidth < 600)
                                          ? 13  // Font size for screens between 500px and 600px
                                          : (ResponsiveBreakpoints.of(context).screenWidth < 700)
                                          ? 14  // Font size for screens between 600px and 700px
                                          : (ResponsiveBreakpoints.of(context).screenWidth < 800)
                                          ? 15  // Font size for screens between 700px and 800px
                                          : (ResponsiveBreakpoints.of(context).screenWidth < 900)
                                          ? 16  // Font size for screens between 800px and 900px
                                          : (ResponsiveBreakpoints.of(context).screenWidth < 1000)
                                          ? 16  // Font size for screens between 900px and 1000px
                                          : (ResponsiveBreakpoints.of(context).screenWidth < 1200)
                                          ? 16  // Font size for screens between 1000px and 1200px
                                          : 16,  // Font size for screens larger than 1200px
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white.withOpacity(0.75),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.projectName,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                        ? 24
                                        : 30,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Visibility(
                                  visible: isHovered,
                                  child: SizedBox(
                                    height: (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                        ? 5
                                        : 15,
                                  ),
                                ),
                                Visibility(
                                  visible: isHovered,
                                  child: Text(
                                    (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                        ? widget.explanation
                                        : widget.explanation,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 500)
                                          ? 12  // Font size for screens smaller than 500px
                                          : (ResponsiveBreakpoints.of(context).screenWidth < 600)
                                          ? 13  // Font size for screens between 500px and 600px
                                          : (ResponsiveBreakpoints.of(context).screenWidth < 700)
                                          ? 14  // Font size for screens between 600px and 700px
                                          : (ResponsiveBreakpoints.of(context).screenWidth < 800)
                                          ? 15  // Font size for screens between 700px and 800px
                                          : (ResponsiveBreakpoints.of(context).screenWidth < 900)
                                          ? 16  // Font size for screens between 800px and 900px
                                          : (ResponsiveBreakpoints.of(context).screenWidth < 1000)
                                          ? 16  // Font size for screens between 900px and 1000px
                                          : (ResponsiveBreakpoints.of(context).screenWidth < 1200)
                                          ? 16  // Font size for screens between 1000px and 1200px
                                          : 16,  // Font size for screens larger than 1200px
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white.withOpacity(0.75),
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
                    widget.image,
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
                  borderRadius: BorderRadius.circular(10),

                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                widget.stackName,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 500)
                                      ? 12  // Font size for screens smaller than 500px
                                      : (ResponsiveBreakpoints.of(context).screenWidth < 600)
                                      ? 13  // Font size for screens between 500px and 600px
                                      : (ResponsiveBreakpoints.of(context).screenWidth < 700)
                                      ? 14  // Font size for screens between 600px and 700px
                                      : (ResponsiveBreakpoints.of(context).screenWidth < 800)
                                      ? 15  // Font size for screens between 700px and 800px
                                      : (ResponsiveBreakpoints.of(context).screenWidth < 900)
                                      ? 16  // Font size for screens between 800px and 900px
                                      : (ResponsiveBreakpoints.of(context).screenWidth < 1000)
                                      ? 16  // Font size for screens between 900px and 1000px
                                      : (ResponsiveBreakpoints.of(context).screenWidth < 1200)
                                      ? 16  // Font size for screens between 1000px and 1200px
                                      : 16,  // Font size for screens larger than 1200px
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white.withOpacity(0.75),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.projectName,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontSize:
                                    (ResponsiveBreakpoints.of(context).screenWidth < 990) ? 24 : 30,
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
                              child: FadeInDown(
                                from: 10,
                                duration: Duration(milliseconds: 500),
                                child: Text(
                                  (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                      ? widget.explanation
                                      : widget.explanation,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 500)
                                        ? 12  // Font size for screens smaller than 500px
                                        : (ResponsiveBreakpoints.of(context).screenWidth < 600)
                                        ? 13  // Font size for screens between 500px and 600px
                                        : (ResponsiveBreakpoints.of(context).screenWidth < 700)
                                        ? 14  // Font size for screens between 600px and 700px
                                        : (ResponsiveBreakpoints.of(context).screenWidth < 800)
                                        ? 15  // Font size for screens between 700px and 800px
                                        : (ResponsiveBreakpoints.of(context).screenWidth < 900)
                                        ? 16  // Font size for screens between 800px and 900px
                                        : (ResponsiveBreakpoints.of(context).screenWidth < 1000)
                                        ? 16  // Font size for screens between 900px and 1000px
                                        : (ResponsiveBreakpoints.of(context).screenWidth < 1200)
                                        ? 16  // Font size for screens between 1000px and 1200px
                                        : 16,  // Font size for screens larger than 1200px
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white.withOpacity(0.75),
                                  ),
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
            ),
    );
  }

  String portfolioImages(int index) {
    if (index == 0) {
      return quranApp;
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
