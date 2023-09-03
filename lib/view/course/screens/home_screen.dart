import 'package:aksonhealth/view/course/components/home_screen_navbar.dart';
import 'package:aksonhealth/view/course/components/list/explore_course_list.dart';
import 'package:aksonhealth/view/course/components/list/recent_course_list.dart';
import 'package:aksonhealth/view/course/screens/continue_watching_screen.dart';
import 'package:aksonhealth/view/parents/home/features_appbar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> with TickerProviderStateMixin {
  late Animation<Offset> sidebarAnimation;
  late Animation<double> fadeAnimation;
  late AnimationController sidebarAnimationController;

  bool sidebarHidden = true;

  @override
  void initState() {
    super.initState();
    sidebarAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    sidebarAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: sidebarAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: sidebarAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    sidebarAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  FeaturesAppBar(),
                  SizedBox(
                    height: 20,
                  ),
                  ExploreCourseList(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Daftar Pelatihan",
                          style: kTitle1Style,
                        ),
                      ],
                    ),
                  ),
                  RecentCourseList(),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
