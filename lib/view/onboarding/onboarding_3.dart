// ignore_for_file: prefer_const_constructors
import 'package:aksonhealth/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Onboarding3Screen extends StatelessWidget {
  const Onboarding3Screen({Key? key, this.color}) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffEBF5FB),
                Color(0xff8FC5F6),
              ],
              stops: [
                0.0,
                1.0,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: Image.asset('assets/images/aihelp2.png'),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
            child: Image.asset('assets/images/aihelp.png'),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.49,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 34, right: 34, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dengan',
                      style: GoogleFonts.spectral(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: blackColor,
                      ),
                    ),
                    Text(
                      "bantuan AI!",
                      style: GoogleFonts.spectral(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: darkBlueColor),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Kami akan mencarikan jalan terbaik untuk kesembuhanmu!',
                      style: GoogleFonts.nunito(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: grayColor,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ]),
    );
  }
}
