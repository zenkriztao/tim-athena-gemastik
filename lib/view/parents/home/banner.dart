import 'package:aksonhealth/size_config.dart';
import 'package:aksonhealth/theme.dart';
import 'package:aksonhealth/view/parents/questionare/questionare_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorBanner extends StatefulWidget {
  const DoctorBanner({
    Key? key,
  }) : super(key: key);

  @override
  _DoctorBannerState createState() => _DoctorBannerState();
}

class _DoctorBannerState extends State<DoctorBanner> {
  final List<Map<String, String>> cardData = [
    {
      'title': 'Autism MCT',
      'description':
          'Test berdasarkan studi kasus yang kami buat dari survey Mchat dengan keakuratan 90%',
      'image': 'assets/images/testautism.png',
    },
    {
      'title': 'Autism SCQ Data',
      'description':
          'Test berdasarkan studi kasus yang kami buat dari survey SCQData dengan keakuratan 90%',
      'image': 'assets/images/dyslexia.png',
    },
  ];

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 2), () {
      if (_currentPage == cardData.length - 1) {
        _currentPage = 0;
      } else {
        _currentPage++;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      _startAutoSlide();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: getRelativeWidth(0.94),
            height: getRelativeHeight(0.22),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: getRelativeWidth(0.88),
                  height: getRelativeHeight(0.17),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 80,
                        offset: Offset(0, 15),
                        color: Color.fromARGB(255, 29, 70, 205),
                      )
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xffffff),
                        Color.fromARGB(255, 50, 168, 227),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getRelativeWidth(0.03)),
                    child: Container(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: cardData.length,
                        itemBuilder: (context, index) {
                          return AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, child) {
                              double value = 1.0;
                              if (_pageController.position.haveDimensions) {
                                value = _pageController.page! - index;
                                value =
                                    (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                              }
                              return Center(
                                child: SizedBox(
                                  height: Curves.easeInOut.transform(value) *
                                      getRelativeHeight(0.17),
                                  width: Curves.easeInOut.transform(value) *
                                      getRelativeWidth(0.88),
                                  child: child,
                                ),
                              );
                            },
                            child: GestureDetector(
                              onTap: () {
                                if (index == 0) {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (c, a1, a2) =>
                                          QuestionareScreen(
                                              number: 1, type: 'MChat'),
                                      transitionsBuilder:
                                          (c, anim, a2, child) =>
                                              FadeTransition(
                                                  opacity: anim, child: child),
                                      transitionDuration:
                                          Duration(milliseconds: 100),
                                    ),
                                  ).then((value) {});
                                } else if (index == 1) {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (c, a1, a2) =>
                                          QuestionareScreen(
                                              number: 1, type: 'SCQ'),
                                      transitionsBuilder:
                                          (c, anim, a2, child) =>
                                              FadeTransition(
                                                  opacity: anim, child: child),
                                      transitionDuration:
                                          Duration(milliseconds: 100),
                                    ),
                                  ).then((value) {});
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: getRelativeWidth(0.03)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          cardData[index]['image']!,
                                          height: 100,
                                          width: 100,
                                        )
                                      ],
                                    ),
                                    SizedBox(width: getRelativeWidth(0.012)),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            cardData[index]['title']!,
                                            style: GoogleFonts.nunito(
                                              color: darkBlueColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: getRelativeWidth(0.055),
                                            ),
                                          ),
                                          SizedBox(
                                              height: getRelativeHeight(0.02)),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  cardData[index]
                                                      ['description']!,
                                                  style: GoogleFonts.nunito(
                                                    color: Colors.white
                                                        .withOpacity(0.85),
                                                    fontSize:
                                                        getRelativeWidth(0.033),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      getRelativeWidth(0.03)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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
