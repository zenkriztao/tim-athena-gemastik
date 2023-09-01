import 'package:aksonhealth/constants.dart';
import 'package:aksonhealth/data/data.dart';
import 'package:aksonhealth/model/doctor_model.dart';
import 'package:aksonhealth/size_config.dart';
import 'package:aksonhealth/theme.dart';
import 'package:aksonhealth/view/chatbot/chat_screen.dart';
import 'package:aksonhealth/view/gamification/pages/home_page.dart';
import 'package:aksonhealth/view/parenting/grid.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateScreenAutism(Doctor doctor) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatScreenBot()));
    }

    void navigateScreenGamification(Doctor doctor) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    void navigateScreenParenting(Doctor doctor) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Grid()));
    }

    void featuresAction(Doctor doctor) {
      if (doctor.name == "Tanya Autism bot") {
        navigateScreenAutism(doctor);
      } else if (doctor.name == "Gamification") {
        navigateScreenGamification(doctor);
      } else if (doctor.name == "Parenting") {
        navigateScreenParenting(doctor);
      } else {}
    }

    SizeConfig.init(context);
    return Container(
      height: getRelativeHeight(0.35),
      child: ListView.builder(
        itemCount: Data.doctorsList.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(0.035)),
        itemBuilder: (context, index) {
          final doctor = Data.doctorsList[index];
          final color = Color.fromARGB(255, 199, 209, 231);
          final circleColor = darkBlueColor;
          final cardWidth = getRelativeWidth(0.48);
          return Row(
            children: [
              GestureDetector(
                onTap: () => featuresAction(doctor),
                child: Container(
                  width: cardWidth,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                      ),
                                      color: color,
                                    ),
                                    height: getRelativeHeight(0.14),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            width: getRelativeHeight(0.13),
                                            height: getRelativeHeight(0.13),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 15,
                                                  color: darkBlueColor
                                                      .withOpacity(0.6)),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            width: getRelativeHeight(0.11),
                                            height: getRelativeHeight(0.11),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 15,
                                                  color: darkBlueColor 
                                                      .withOpacity(0.25)),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            width: getRelativeHeight(0.11),
                                            height: getRelativeHeight(0.11),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 15,
                                                  color: darkBlueColor
                                                      .withOpacity(0.17)),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  width: cardWidth,
                                  height: getRelativeHeight(0.23),
                                  child: Image.asset(doctor.image)),
                            ],
                          ),
                          Container(
                            height: getRelativeHeight(0.12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: getRelativeHeight(0.02),
                                  horizontal: getRelativeWidth((0.05))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doctor.name,
                                    style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.bold,
                                        color: blueColor,
                                        fontSize: getRelativeWidth(0.041)),
                                  ),
                                  SizedBox(height: getRelativeHeight(0.005)),
                                  Text(
                                    doctor.speciality,
                                    style: GoogleFonts.nunito(
                                        color: Colors.black.withOpacity(0.8),
                                        fontSize: getRelativeWidth(0.032)),
                                  ),
                                  SizedBox(height: getRelativeHeight(0.005)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: getRelativeWidth(0.04))
            ],
          );
        },
      ),
    );
  }
}
