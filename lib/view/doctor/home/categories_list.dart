import 'package:aksonhealth/data/data.dart';
import 'package:aksonhealth/size_config.dart';
import 'package:aksonhealth/theme.dart';
import 'package:aksonhealth/view/chatbot/chat_screen.dart';
import 'package:aksonhealth/view/parents/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
        height: getRelativeHeight(0.085),
        child: ListView.builder(
          itemCount: Data.categoriesList.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(0.05)),
          itemBuilder: (context, index) {
            final category = Data.categoriesList[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: getRelativeHeight(0.05),
                  width: getRelativeWidth(1),
                  constraints: BoxConstraints(minWidth: getRelativeWidth(0.41)),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 234, 234, 234),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getRelativeWidth(0.00)),
                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(getRelativeWidth(0.025)),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    blueColor,
                                    darkBlueColor,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset("assets/images/chatbot.png")),
                        SizedBox(width: getRelativeWidth(0.02)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.title,
                              style: GoogleFonts.nunito(
                                  fontSize: getRelativeWidth(0.038),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: getRelativeHeight(0.005)),
                          ],
                        ),
                        SizedBox(width: getRelativeWidth(0.02)), 
                        Text(
                              "*free",
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreenBot()));
                            },
                            style: ElevatedButton.styleFrom(
                              primary:
                                  darkBlueColor, // Warna latar belakang tombol
                              onPrimary: Colors.white, // Warna teks pada tombol
                              padding: EdgeInsets.all(10), // Padding tombol
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Bentuk sudut tombol
                              ),
                              elevation: 4, // Tinggi bayangan tombol
                            ),
                            child: Text(
                              'Mulai Chat',
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                fontSize: 13, // Ukuran teks
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: getRelativeWidth(0.04))
              ],
            );
          },
        ));
  }
}
