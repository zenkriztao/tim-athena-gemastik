import 'package:aksonhealth/view/parenting/grid.dart';
import 'package:aksonhealth/view/parenting/parenting.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/clinic.png", "text": "Klinik"},
      {"icon": "assets/icons/school.png", "text": "Sekolah"},
      {"icon": "assets/icons/forum.png", "text": "Forum"},
      {"icon": "assets/icons/parent.png", "text": "Parenting"},
    ];

    List<Map<String, dynamic>> categorize = [
      {"icon": "assets/icons/training.png", "text": "Donasi"},
      {"icon": "assets/icons/donate.png", "text": "Pelatihan"},
      {"icon": "assets/icons/error.png", "text": "Coming Soon"},
      {"icon": "assets/icons/error.png", "text": "Coming Soon"},
    ];
    return Padding(
      padding: EdgeInsets.all(getScreenWidth(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              categories.length,
              (index) => CategoryCard(
                icon: categories[index]["icon"],
                text: categories[index]["text"],
                press: () {
                  navigateToScreenTop(index, context);
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              categorize.length,
              (index) => CategoryCard(
                icon: categorize[index]["icon"],
                text: categorize[index]["text"],
                press: () {
                  navigateToScreenBottom(index, context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void navigateToScreenTop(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Grid()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Grid()));
        break;
      default:
        print('Invalid Category Index');
        break;
    }
  }

void navigateToScreenBottom(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Grid()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Grid()));
        break;
      default:
        print('Invalid Category Index');
        break;
    }
  }


class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getScreenWidth(80), // Mengubah lebar container
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getScreenWidth(5)), // Mengubah padding
              height: getScreenWidth(70), // Mengubah tinggi container
              width: getScreenWidth(70), // Mengubah lebar container
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Color.fromARGB(255, 226, 233, 239),
                    width: 1,
                  )),
              child: Image.asset(
                icon!,
              ),
            ),
            SizedBox(height: 10), // Mengubah jarak antara ikon dan teks
            Text(
              text!,
              style: TextStyle(
                fontSize: 13, // Mengubah ukuran teks
                fontWeight: FontWeight.bold, // Menambah tebal pada teks
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
