import 'dart:io';

import 'package:autism_perdiction_app/constants.dart';
import 'package:autism_perdiction_app/view/doctor/bookings/bookings_screen.dart';
import 'package:autism_perdiction_app/view/doctor/home/doctor_home_screen.dart';
import 'package:autism_perdiction_app/view/parents/home/home_screen.dart';
import 'package:autism_perdiction_app/view/parents/perdict/perdict_screen.dart';
import 'package:autism_perdiction_app/view/parents/profile/profile_screen.dart';
import 'package:autism_perdiction_app/view/resources/resource_screen.dart';
import 'package:autism_perdiction_app/view/specialists/specialist_screen.dart';
import 'package:autism_perdiction_app/view/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDoctorBottomNavBarScreen extends StatefulWidget {
  final int index;
  final String title;
  final String subTitle;

  const AppDoctorBottomNavBarScreen({Key? key, required this.index, required this.title, required this.subTitle,}) : super(key: key);

  @override
  _AppDoctorBottomNavBarScreenState createState() => _AppDoctorBottomNavBarScreenState();
}

class _AppDoctorBottomNavBarScreenState extends State<AppDoctorBottomNavBarScreen> {
  int _selectedIndex = 0;
  List<Widget> _pages = [

    DoctorHomeScreen(),
    DoctorBookingScreen(),
    ProfileScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  getToken() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print('customerAccessToken');
    print( _pref.getString('customerAccessToken'));

    print('adminAccessToken');
    print( _pref.getString('adminAccessToken'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('UserType');
    getToken();

  }



  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    //getToken();
    return Scaffold(
      extendBody: true,
      backgroundColor:  lightGreyColor,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: _selectedIndex == 2 ? primaryColor : Colors.blue,
      //   onPressed: () {
      //     setState(() {
      //       _selectedIndex = 2;
      //       _pages[2] = PerdictScreen();
      //     });
      //
      //   },
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      //   elevation: 2.0,
      // ),

      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 55,
          //  color: Colors.white,
          child: SizedBox(
            height: 70,
            child:

            CupertinoTabBar(
              activeColor: primaryColor,
              currentIndex: _selectedIndex,
              backgroundColor: Colors.white,
              iconSize: 40,
              onTap: _onItemTapped,
              items: [

                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 0;
                          _pages[0] = DoctorHomeScreen();
                        });
                      },
                      child: Icon(
                        Icons.home,
                        size: 25,
                        //color: Color(0xFF3A5A98),
                      ),
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 1;
                          _pages[1] = DoctorBookingScreen();
                        });
                      },
                      child: Icon(
                        Icons.perm_media_outlined,
                        size: 25,
                        //color: Color(0xFF3A5A98),
                      ),
                    ),
                  ),
                  label: 'Bookings',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 4;
                          _pages[4] = ProfileScreen();
                        });
                      },
                      child: Icon(
                        Icons.account_circle,
                        size: 25,
                      ),
                    ),
                  ),
                  label: 'Profile',
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
