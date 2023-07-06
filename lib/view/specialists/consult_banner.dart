import 'package:aksonhealth/size_config.dart';
import 'package:aksonhealth/theme.dart';
import 'package:aksonhealth/view/parents/perdict/perdict_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsultBanner extends StatelessWidget {
  const ConsultBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(
        context); // Initialize SizeConfig before using screenWidth and screenHeight
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            // Belum diisi
          },
          child: Container(
            width: getRelativeWidth(0.94),
            height: getRelativeHeight(0.22),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: getRelativeWidth(0.88),
                  height: getRelativeHeight(0.50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: darkBlueColor),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getRelativeWidth(0.03)),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Apa kamu masih bingung? konsultasi dengan Dokter Langsung melalui chat",
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: getRelativeHeight(0.02)),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/doctor.png',
                                height: 300,
                                width: 100,
                              )
                            ],
                          ),
                          SizedBox(width: getRelativeWidth(0.012)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
