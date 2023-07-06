import 'package:aksonhealth/constants.dart';
import 'package:aksonhealth/size_config.dart';
import 'package:aksonhealth/view/parents/home/banner.dart';
import 'package:aksonhealth/view/parents/home/doctors_list.dart';
import 'package:aksonhealth/view/parents/home/features_appbar.dart';
import 'package:flutter/material.dart';
import 'appbar.dart';
import 'categories_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              FeaturesAppBar(),
              DoctorsList()
            ],
          ),
        ),
      ),
    );
  }
}
