import 'package:autism_perdiction_app/constants.dart';
import 'package:autism_perdiction_app/size_config.dart';
import 'package:autism_perdiction_app/theme.dart';
import 'package:autism_perdiction_app/view/specialists/consult_banner.dart';
import 'package:autism_perdiction_app/view/specialists/doctor_screen.dart';
import 'package:flutter/material.dart';

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
                title: const Text(
                  "Konsultasi",
                style: TextStyle(
                  color: darkBlueColor
                )
                ),
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