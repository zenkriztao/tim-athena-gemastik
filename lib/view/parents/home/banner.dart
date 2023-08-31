import 'package:aksonhealth/size_config.dart';
import 'package:aksonhealth/theme.dart';
import 'package:aksonhealth/view/parents/questionare/questionare_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorBanner extends StatelessWidget {
  const DoctorBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(
        context); // Initialize SizeConfig before using screenWidth and screenHeight
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) =>
                QuestionareScreen(number: 1, type: 'MChat'),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 100),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: getRelativeWidth(0.94),
            height: getRelativeHeight(2),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: getRelativeWidth(0.88),
                  height: getRelativeHeight(1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 30,
                        offset: Offset(0, 15),
                        color: Color.fromARGB(255, 29, 70, 205),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getRelativeWidth(0.03)),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/testautism.png',
                                height: 200,
                                width: 110,
                              )
                            ],
                          ),
                          SizedBox(width: getRelativeWidth(0.012)),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Skrining Autisme",
                                  style: GoogleFonts.nunito(
                                    color: darkBlueColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getRelativeWidth(0.055),
                                  ),
                                ),
                                SizedBox(height: getRelativeHeight(0.02)),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Test berdasarkan studi kasus yang kami buat dari survey MCHAT dengan keakuratan sangat baik",
                                        style: GoogleFonts.nunito(
                                            color: Color.fromARGB(255, 0, 0, 0)
                                                .withOpacity(0.85),
                                            fontSize: getRelativeWidth(0.033)),
                                      ),
                                    ),
                                    SizedBox(width: getRelativeWidth(0.03)),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                                  255, 153, 46, 46)
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      padding: EdgeInsets.all(
                                          getRelativeWidth(0.012)),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: const Color.fromARGB(
                                            255, 187, 24, 24),
                                        size: getRelativeWidth(0.038),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                  height: getRelativeWidth(0.12),
                  width: getRelativeWidth(0.12),
                  child: Image.asset("assets/images/gradient.png")),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getRelativeHeight(0.01),
                    horizontal: getRelativeWidth(0.07)),
                child: Container(
                    height: getRelativeWidth(0.08),
                    width: getRelativeWidth(0.08),
                    child: Image.asset("assets/images/gradient.png")),
              ),
            ),
          )
        ],
      ),
    );
  }
}
