import 'package:autism_perdiction_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorAppBar extends StatelessWidget {
  const DoctorAppBar({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
  SizeConfig.init(context); // Initialize SizeConfig before using screenWidth and screenHeight
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(0.04)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi Akson",
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: getRelativeWidth(0.09)),
              ),
              SizedBox(height: getRelativeHeight(0.003)),
              Text(
                "Kamu bisa prediksi disini",
                style: GoogleFonts.nunito(
                    color: Colors.blueGrey[400],
                    fontSize: getRelativeWidth(0.036)),
              ),
            ],
          ),
          Container(
            height: getRelativeHeight(0.06),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    offset: Offset(0, 4),
                    color: Colors.black54,
                  )
                ],
                color: Color(0xffA295FD),
                borderRadius: BorderRadius.circular(5)),
          )
        ],
      ),
    );
  }
}