import 'dart:async';
import 'package:aksonhealth/constants.dart';
import 'package:aksonhealth/view/onboarding/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:mec/constants.dart';

class SplashScreen extends StatefulWidget {
  //final Color backgroundColor = Colors.white;
  //final NotificationAppLaunchDetails? notificationAppLaunchDetails;
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 1; // delay for 5 seconds

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => OnboardingScreen()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: primaryColor,
      backgroundColor: whiteColor,

      body: Container(
        width: size.width,
        height: size.height,
        decoration: new BoxDecoration(

            // gradient: LinearGradient(begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   stops: [
            //   0.1,
            //   0.9
            // ], colors: [
            //   lightRedColor,
            //   darkRedColor
            // ],
            // ),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.scaleDown,
                )),
            //     Text('Autism', style: GoogleFonts.nunito(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 32),textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
