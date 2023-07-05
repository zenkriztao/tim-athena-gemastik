import 'package:autism_perdiction_app/constants.dart';
import 'package:autism_perdiction_app/data/data.dart';
import 'package:autism_perdiction_app/model/doctor_model.dart';
import 'package:autism_perdiction_app/size_config.dart';
import 'package:autism_perdiction_app/theme.dart';
import 'package:autism_perdiction_app/view/auth/login/login_screen.dart';
import 'package:autism_perdiction_app/view/chatbot/chat_screen.dart';
import 'package:autism_perdiction_app/view/gamification/widget_tree.dart';
import 'package:autism_perdiction_app/view/onboarding/onboarding_1.dart';
import 'package:autism_perdiction_app/view/parenting/parenting.view.dart';
import 'package:autism_perdiction_app/view/parents/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateScreenAutism(Doctor doctor) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ChatScreenBot()));
    }

    void navigateScreenGamification(Doctor doctor) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => WidgetTree()));
    }

    void navigateScreenParenting(Doctor doctor) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ParentingView()));
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
          final color = secondaryColor;
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
                                                color: circleColor
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
                                                color: circleColor
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
                                                color: circleColor
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
