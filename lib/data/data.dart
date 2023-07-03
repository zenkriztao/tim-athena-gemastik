import 'package:autism_perdiction_app/model/category_model.dart';
import 'package:autism_perdiction_app/model/doctor_model.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';

class Data {
  static final categoriesList = [
    Category(
      title: "Lorem",
      doctorsNumber: 15,
      icon: Icons.favorite,
    ),
    Category(
      title: "Lorem",
      doctorsNumber: 8,
      icon: LineIcons.child,
    ),
    Category(
      title: "Lorem",
      doctorsNumber: 7,
      icon: Icons.line_style,
    ),
    Category(
      title: "Lorem",
      doctorsNumber: 10,
      icon: LineIcons.eye,
    ),
  ];

  static final doctorsList = [
    Doctor(
        name: "Tanya Autism bot",
        speciality: "Integrasi AI",
        image: "assets/images/aihelp.png",
        reviews: 80,
        reviewScore: 4),
    Doctor(
        name: "Gamification",
        speciality: "Social Skills Game",
        image: "assets/images/gamification.png",
        reviews: 67,
        reviewScore: 5),
    Doctor(
        name: "Parenting",
        speciality: "Multiple Literacies, Recognitive dan HSP",
        image: "assets/images/parenting.png",
        reviews: 19,
        reviewScore: 3),
   
  ];
}
