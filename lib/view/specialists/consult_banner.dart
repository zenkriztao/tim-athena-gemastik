import 'package:autism_perdiction_app/size_config.dart';
import 'package:autism_perdiction_app/theme.dart';
import 'package:autism_perdiction_app/view/parents/perdict/perdict_screen.dart';
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
                  color: darkBlueColor
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getRelativeWidth(0.03)),
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
                              Row(
                                children: [
                                  Flexible(
                                    child: ElevatedButton(
                                      onPressed: () {  },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(blueColor),
                                      ),
                                      child: Text(
                                        'Cari Dokter'
                                      ),
                                    )
                                  ),
                                ],
                              ),
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
