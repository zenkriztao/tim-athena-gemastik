// <<<<<<< HEAD
import 'package:aksonhealth/view/gamification/phonetic%20list/phonetic_list.dart';
// =======
import 'package:aksonhealth/view/gamification/pages/home_page.dart';
// >>>>>>> 7c011123d9d6daca0b7e98595e0539787a0de769
import 'package:aksonhealth/view/parenting/grid.dart';
import 'package:aksonhealth/view/parents/clinic/clinic_test.dart';
import 'package:aksonhealth/view/parents/schools/schools.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../donasi/donasi.dart';
import '../../event/event.dart';
import '../../../size_config.dart';
import '../../gamification/phonetic list/new_phonetic_list.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/clinic.png", "text": "Klinik"},
      {"icon": "assets/icons/school.png", "text": "Sekolah"},
      {"icon": "assets/icons/forum.png", "text": "Forum"},
      {"icon": "assets/icons/parenting.png", "text": "Parenting"},
    ];

    List<Map<String, dynamic>> categorize = [
      {"icon": "assets/icons/charity.png", "text": "Donasi"},
      {"icon": "assets/icons/training.png", "text": "Pelatihan"},
      {"icon": "assets/icons/event.png", "text": "Event"},
      {"icon": "assets/icons/game.png", "text": "Permainan"},
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
                  if (categories[index]["text"] == "Klinik") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ClinicTesting()), // Replace "Donasi()" with your actual page route
                    );
                  } else if (categories[index]["text"] == "Sekolah") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SchoolsForChildren(),
                      ), // Replace "Donasi()" with your actual page route
                    );
                  } else if (categories[index]["text"] == "Forum") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClinicTesting(),
                      ), // Replace "Donasi()" with your actual page route
                    );
                  } else if (categories[index]["text"] == "Parenting") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Grid(),
                      ), // Replace "Donasi()" with your actual page route
                    );
                  }
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
                  if (categorize[index]["text"] == "Donasi") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Donation(),
                      ), // Replace "Donasi()" with your actual page route
                    );
                  } else if (categorize[index]["text"] == "Pelatihan") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClinicTesting(),
                      ), // Replace "Donasi()" with your actual page route
                    );
                  } else if (categorize[index]["text"] == "Event") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Event(),
                      ), // Replace "Donasi()" with your actual page route
                    );
                  } else if (categorize[index]["text"] == "Permainan") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ), // Replace "Donasi()" with your actual page route
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PhonetikList()));
            },
            child: Text('Phonetic Testing'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewPhoneticList()));
            },
            child: Text('New Phonetic Testing'),
          ),
        ],
      ),
    );
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
        width: getScreenWidth(60), // Mengubah lebar container
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
                height: 100,
              ),
            ),
            SizedBox(height: 10), // Mengubah jarak antara ikon dan teks
            Text(
              text!,
              style: GoogleFonts.nunito(
                color: Color.fromARGB(255, 113, 113, 113),
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
