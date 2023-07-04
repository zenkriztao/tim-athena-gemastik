import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:autism_perdiction_app/view/auth/login/login_screen.dart';
import 'package:autism_perdiction_app/view/auth/userType/usertype_screen.dart';
import 'package:autism_perdiction_app/view/onboarding/onboarding_1.dart';
import 'package:autism_perdiction_app/view/onboarding/onboarding_2.dart';
import 'package:autism_perdiction_app/view/onboarding/onboarding_3.dart';
import 'package:autism_perdiction_app/theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

void _selectUserType(String userType) {
  if (userType == 'Parents') {
    Get.to(() => LoginScreen(userType: 'Parents'));
  } else if (userType == 'Doctors') {
    Get.to(() => LoginScreen(userType: 'Doctors'));
  }
}

void _handleTap() {
  _controller.nextPage(
    duration: const Duration(milliseconds: 500),
    curve: Curves.ease,
  );
  if (onLastPage) {
    // Replace 'Parents' with the desired user type
    _selectUserType('Parents');
  }
}



  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      // Wrap your app with GetMaterialApp
      home: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = index == 2;
                });
              },
              children: const [
                Onboarding1Screen(),
                Onboarding2Screen(),
                Onboarding3Screen(),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const Spacer(),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      dotColor: grayColor,
                      activeDotColor: blueColor,
                      expansionFactor: 4,
                      spacing: 5,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: _handleTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 13.0,
                            horizontal: 100.0,
                          ),
                          child: Center(
                            child: Text(
                              onLastPage ? 'Mulai' : 'Lanjut',
                              style: GoogleFonts.nunito(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  onLastPage
                      ? SizedBox(
                          height: 18,
                        )
                      : GestureDetector(
                          onTap: () {
                            Get.to(() => UserType());
                          },
                          child: Text(
                            'Lewati',
                            style: GoogleFonts.nunito(
                              color: blueColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
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
