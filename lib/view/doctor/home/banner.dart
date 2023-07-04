import 'package:autism_perdiction_app/size_config.dart';
import 'package:autism_perdiction_app/theme.dart';
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
    return Stack(
      children: [
        Container(
          width: getRelativeWidth(0.94),
          height: getRelativeHeight(0.22),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: getRelativeWidth(0.88),
                height: getRelativeHeight(0.17),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 80,
                      offset: Offset(0, 15),
                      color: Color.fromARGB(255, 29, 70, 205),
                    )
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xffffff),
                      Color.fromARGB(255, 50, 168, 227),
                    ],
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getRelativeWidth(0.03)),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              left: 1.0,
                              top: 2.0,
                              child: Icon(
                                Icons.favorite,
                                color: Colors.black54,
                                size: getRelativeHeight(0.1),
                              ),
                            ),
                            Image.asset(
                              'assets/images/testautism.png',
                              height: 100,
                              width: 100,
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
                                "Autism & Dyslexia",
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
                                      "Test berdasarkan studi kasus yang kami buat dari survey Mchat dan SCQData dengan keakuratan 90%",
                                      style: GoogleFonts.nunito(
                                          color: Colors.white.withOpacity(0.85),
                                          fontSize: getRelativeWidth(0.033)),
                                    ),
                                  ),
                                  SizedBox(width: getRelativeWidth(0.03)),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    padding:
                                        EdgeInsets.all(getRelativeWidth(0.012)),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
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
    );
  }
}
