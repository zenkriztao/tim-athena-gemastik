import 'package:aksonhealth/constants.dart';
import 'package:aksonhealth/theme.dart';
import 'package:aksonhealth/view/chat/chats.dart';
import 'package:aksonhealth/view/doctor/bookings/bookings_screen.dart';
import 'package:aksonhealth/view/parents/home/home_screen.dart';
import 'package:aksonhealth/view/parents/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDoctorBottomNavBarScreen extends StatefulWidget {
  final int index;
  final String title;
  final String subTitle;

  const AppDoctorBottomNavBarScreen({
    Key? key,
    required this.index,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  _AppDoctorBottomNavBarScreenState createState() =>
      _AppDoctorBottomNavBarScreenState();
}

class _AppDoctorBottomNavBarScreenState
    extends State<AppDoctorBottomNavBarScreen> {
  int _selectedIndex = 0;
  List<Widget> _pages = [
    HomeScreen(),
    Chats(),
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
    print(_pref.getString('customerAccessToken'));

    print('adminAccessToken');
    print(_pref.getString('adminAccessToken'));
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
      backgroundColor: lightGreyColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 55,
          //  color: Colors.white,
          child: SizedBox(
            height: 70,
            child: CupertinoTabBar(
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
                          _pages[1] = Chats();
                        });
                      },
                      child: FaIcon(
                        FontAwesomeIcons.message,
                        size: 23,
                      ),
                      //color: Color(0xFF3A5A98),
                    ),
                  ),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 2;
                          _pages[2] = DoctorBookingScreen();
                        });
                      },
                      child: FaIcon(
                        FontAwesomeIcons.bookMedical,
                        size: 23,
                      ),
                    ),
                  ),
                  label: 'Appointment',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 3;
                          _pages[3] = ProfileScreen();
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
