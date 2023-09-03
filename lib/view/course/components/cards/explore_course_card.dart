import 'package:aksonhealth/model/course_model.dart';
import 'package:aksonhealth/view/parents/questionare/questionare_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ExploreCourseCard extends StatelessWidget {
  const ExploreCourseCard({required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) =>
                QuestionareScreen(number: 1, type: 'MChat'),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 100),
          ),
        ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 320.0,
            width: 350,
            decoration: BoxDecoration(gradient: course.background),
            child: Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Row(children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.courseSubtitle,
                        style: kCardSubtitleStyle,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        course.courseTitle,
                        style: kCardTitleStyle,
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      "assets/illustrations/${course.illustration}",
                      fit: BoxFit.cover,
                      height: 100,
                    )
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
