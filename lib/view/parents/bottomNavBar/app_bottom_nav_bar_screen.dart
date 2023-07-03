import 'dart:io';

import 'package:autism_perdiction_app/constants.dart';
import 'package:autism_perdiction_app/theme.dart';
import 'package:autism_perdiction_app/view/parents/home/home_screen.dart';
import 'package:autism_perdiction_app/view/parents/perdict/perdict_screen.dart';
import 'package:autism_perdiction_app/view/parents/profile/profile_screen.dart';
import 'package:autism_perdiction_app/view/resources/resource_screen.dart';
import 'package:autism_perdiction_app/view/specialists/specialist_screen.dart';
import 'package:autism_perdiction_app/view/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBottomNavBarScreen extends StatefulWidget {
  final int index;
  final String title;
  final String subTitle;

  const AppBottomNavBarScreen({Key? key, required this.index, required this.title, required this.subTitle,}) : super(key: key);

  @override
  _AppBottomNavBarScreenState createState() => _AppBottomNavBarScreenState();
}

class _AppBottomNavBarScreenState extends State<AppBottomNavBarScreen> {
  int _selectedIndex = 0;
  List<Widget> _pages = [

    HomeScreen(),
    ResourceScreen(),
    HomeScreen(),
    SpecialistScreen(),
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
    // if (widget.index == 1) {
    //   setState(() {
    //     _selectedIndex = 2;
    //     _pages[2] = SessionHistory();
    //   });
    // }

  }



  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    //getToken();
    return Scaffold(
      extendBody: true,
      backgroundColor:  lightGreyColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: _selectedIndex == 2 ? blueColor : darkBlueColor,
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
            _pages[2] = PerdictScreen();
          });

        },
        child: FaIcon(FontAwesomeIcons.bolt),
        elevation: 2.0,
      ),

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
              activeColor: darkBlueColor,
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
                          _pages[0] = HomeScreen();
                        });
                      },
                      child: FaIcon(
                        FontAwesomeIcons.home,
                        size: 23,
                        ),
                        //color: Color(0xFF3A5A98),
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
                          _pages[1] = SpecialistScreen();
                        });
                      },
                      child: FaIcon(
                        FontAwesomeIcons.stethoscope,
                        size: 23,
                        ), 
                        //color: Color(0xFF3A5A98),
                      ),
                    ),
                    label: 'Konsultasi',
                ),
                 BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 2;
                          _pages[2] = PerdictScreen();
                        });
                      },
                    ),
                  ),
                  label: 'Prediksi',
                ),
                 BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 3;
                          _pages[3] = ResourceScreen();
                        });
                      },
                      child:FaIcon(
                        FontAwesomeIcons.bookOpen,
                        size: 23,
                        ), 
                    ),
                  ),
                  label: 'Artikel',
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
                      child: FaIcon(
                        FontAwesomeIcons.bars,
                        size: 23,
                        ),  
                    ),
                  ),
                  label: 'Pengaturan',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
