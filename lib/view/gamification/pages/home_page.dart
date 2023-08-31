import 'package:aksonhealth/size_config.dart';
import 'package:aksonhealth/theme.dart';
import 'package:aksonhealth/view/gamification/auth.dart';
import 'package:aksonhealth/view/gamification/storylines/first_storyline.dart';
import 'package:aksonhealth/view/gamification/storylines/second_storyline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key});
  @override
  _HomePageState createState() => _HomePageState();
}

final User? user = Auth().currentUser;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(66, 168, 168, 168),
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0),
                    ],
                  ),
                  child: Hero(
                    tag: 'assets/logo.png',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image(
                        image: AssetImage("assets/images/game.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20.0,
                  bottom: 20.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Gamification",
                        style: GoogleFonts.nunito(
                          color: darkBlueColor,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FirstStoryLine(user: user)));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: getRelativeWidth(0.90),
                    height: getRelativeHeight(0.20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green),
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
                                    "Permainan Pra Membaca cocok gambar NST untuk Disleksia",
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
                                  'assets/images/autism1.png',
                                  height: 300,
                                  width: 100,
                                )
                              ],
                            ),
                            // SizedBox(width: getRelativeWidth(0.012)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SecondStoryLine(user: user)));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: getRelativeWidth(0.90),
                    height: getRelativeHeight(0.20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 12, 91, 156)),
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
                                    "Game untuk penyandang Dislexia",
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
                                  'assets/images/dyslexia1.png',
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
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SecondStoryLine(user: user)));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: getRelativeWidth(0.90),
                    height: getRelativeHeight(0.20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green),
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
                                    "Daftar kata dengan 2 suku kata",
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
                                  'assets/images/dyslexia1.png',
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
          ],
        ),
      ),
    );
  }
}
