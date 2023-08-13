import 'package:aksonhealth/model/category_model.dart';
import 'package:aksonhealth/model/doctor_model.dart';
import 'package:line_icons/line_icons.dart';

class Data {
  static final categoriesList = [
    Category(
      title: "Cari Sekolah",
      doctorsNumber: 15,
      icon: LineIcons.spinner,
    ),
    Category(
      title: "Cari Klinik",
      doctorsNumber: 8,
      icon: LineIcons.spinner,
    ),
    Category(
      title: "Coming Soon",
      doctorsNumber: 7,
      icon: LineIcons.spinner,
    ),
    Category(
      title: "Coming Soon",
      doctorsNumber: 10,
      icon: LineIcons.spinner,
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
