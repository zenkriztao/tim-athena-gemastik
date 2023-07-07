import 'package:aksonhealth/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: whiteColor, size: 25),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 18,
              color: whiteColor,
            )),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: appBarColor,
        title: Text(
          'Tentang Kami',
          style: GoogleFonts.nunito(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: Column(
              children: [
                Container(
                  width: size.width * 0.95,
                  child: Image.asset(
                    "assets/logo.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Fitur aplikasi ASD nya\n"
                    "- Diagnosis berdasarkan survei pada Anak ASD (menggunakan form dan gambar)\n"
                    "- AI chatbot untuk orang tua yang ingin mendapatkan informasi dengan jelas\n"
                    "- Konsultasi dgn ahli via real-time chat dengan orang tua (Firebase)\n"
                    "- Berbagi aktivitas sesama orangtua ASD dan tindakan informasi (seperti P92 Meta atau Threads)\n"
                    "- Gamification pada anak ASD\n"
                    "- Social Skills\n"
                    "- Imaginations\n"
                    "- Fitur parenting seperti, Multiple Literacies, Recognitive, dan HSP",
                    style: GoogleFonts.nunito(
                      fontSize: 12
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                )
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
