import 'package:aksonhealth/size_config.dart';
import 'package:aksonhealth/theme.dart';
import 'package:aksonhealth/view/specialists/consult_banner.dart';
import 'package:aksonhealth/view/specialists/doctor_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsultScreen extends StatefulWidget {
  @override
  _ConsultScreenState createState() => _ConsultScreenState();
}

class _ConsultScreenState extends State<ConsultScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                title: Text("Konsultasi",
                    style: GoogleFonts.nunito(color: darkBlueColor)),
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 30),
              ConsultBanner(),
              SpecialistScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
