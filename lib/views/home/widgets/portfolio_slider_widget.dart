import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/utils/image_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/colors.dart';

class PortfolioSliderWidget extends StatefulWidget {
  final int itemIndex;
  const PortfolioSliderWidget({super.key, required this.itemIndex});

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
                                  "Creative Agency",
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
                                  child: FadeInUp(
                                    from: 10,
                                    duration: Duration(milliseconds: 500),
                                    child: Text(
                                      (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                          ? "Lorem ipsum dolor sit amet, consec"
                                          : "Lorem ipsum dolor sit amet, consec tetur adipiscing elit.",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
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
                            "Creative Agency",
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
                            child: FadeInUp(
                              from: 10,
                              duration: Duration(milliseconds: 500),
                              child: Text(
                                (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                    ? "Lorem ipsum dolor sit amet, consec"
                                    : "Lorem ipsum dolor sit amet, consec tetur adipiscing elit.",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
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
