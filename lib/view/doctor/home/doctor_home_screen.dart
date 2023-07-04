import 'package:autism_perdiction_app/constants.dart';
import 'package:autism_perdiction_app/size_config.dart';
import 'package:autism_perdiction_app/view/parents/home/banner.dart';
import 'package:autism_perdiction_app/view/parents/home/doctors_list.dart';
import 'package:flutter/material.dart';
import 'appbar.dart';
import 'categories_list.dart';

class DoctorHomeScreen extends StatefulWidget {
  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              DoctorAppBar(),
              SizedBox(height: 30),
              DoctorBanner(),
              SizedBox(height: 30),
              CategoriesList(),
              SizedBox(height: 30),
              DoctorsList()
            ],
          ),
        ),
      ),
    );
  }
}