import 'package:autism_perdiction_app/constants.dart';
import 'package:autism_perdiction_app/model/firebase_auth.dart';
import 'package:autism_perdiction_app/theme.dart';
import 'package:autism_perdiction_app/view/aboutUs/about_us_screen.dart';
import 'package:autism_perdiction_app/view/doctor/bookings/bookings_screen.dart';
import 'package:autism_perdiction_app/view/parents/myBookings/my_bookings_screen.dart';
import 'package:autism_perdiction_app/view/parents/profile/update_profile_screen.dart';
import 'package:autism_perdiction_app/view/reports/reports_screen.dart';
import 'package:autism_perdiction_app/view/specialists/doctor_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  MethodsHandler _methodsHandler = MethodsHandler();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool status = false;

  String? profileImage,
      docId,
      userType,
      driverEmail = '',
      driverName = '',
      driverUid = '';

  getDriver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userType = prefs.getString('userType')!;
    });

    await FirebaseFirestore.instance
        .collection('Parents')
        .where('uid', isEqualTo: _auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        driverName = value.docs[0]['name'];
        driverEmail = value.docs[0]['email'];
        driverUid = _auth.currentUser!.uid;
      });
    });

    print(driverName.toString() + ' name is here');
  }

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      driverEmail = '';
      driverName = '';
    });
    getDriver();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 25),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: darkBlueColor,
        title: Text(
          'Profile',
          style: GoogleFonts.nunito(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
//                height: size.height*0.1,
                  width: size.width * 0.9,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Image.asset(
                          'assets/logo.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Center(
              child: Container(
                width: size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Pengaturan',
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  //<-- SEE HERE

                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: Colors.white,
                leading: Container(
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blueGrey, width: 1)),
                    width: 40,
                    height: 40, //devSize.height*0.05,
                    child: Image.asset("assets/edit_profile20.png")),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 15,
                ),
                title: Text('Ubah Profil', style: body4Black),
                onTap: () async {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (c, a1, a2) => UpdateProfileScreen(),
                      transitionsBuilder: (c, anim, a2, child) =>
                          FadeTransition(opacity: anim, child: child),
                      transitionDuration: Duration(milliseconds: 100),
                    ),
                  ).then((value) {
                    getDriver();
                    setState(() {});
                  });
                },
              ),
            ),
            userType == 'Doctors'
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, left: 10, right: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        //<-- SEE HERE

                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor: Colors.white,
                      leading: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blue, width: 1)),
                          width: 40,
                          height: 40, //devSize.height*0.05,
                          child: Image.asset(
                            "assets/autism_center20.png",
                            width: 20,
                            height: 20,
                          )),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15,
                      ),
                      title: Text('Autism Center', style: body4Black),
                      onTap: () async {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => SpecialistScreen(),
                            transitionsBuilder: (c, anim, a2, child) =>
                                FadeTransition(opacity: anim, child: child),
                            transitionDuration: Duration(milliseconds: 100),
                          ),
                        );
                      },
                    ),
                  ),
            userType == 'Doctors'
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, left: 10, right: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        //<-- SEE HERE
                        side: BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor: Colors.white,
                      leading: Container(
                          decoration: BoxDecoration(
                              color: authButtontextColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: authButtontextColor, width: 1)),
                          width: 40,
                          height: 40, //devSize.height*0.05,
                          child: Image.asset("assets/reports.png")),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15,
                      ),
                      title: Text('Laporan', style: body4Black),
                      onTap: () async {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => ReportScreen(),
                            transitionsBuilder: (c, anim, a2, child) =>
                                FadeTransition(opacity: anim, child: child),
                            transitionDuration: Duration(milliseconds: 100),
                          ),
                        );
                      },
                    ),
                  ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  //<-- SEE HERE
                  side: BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: Colors.white,
                leading: Container(
                    decoration: BoxDecoration(
                        color: authButtontextColor,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: authButtontextColor, width: 1)),
                    width: 40,
                    height: 40, //devSize.height*0.05,
                    child: Image.asset("assets/booking.png")),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 15,
                ),
                title: Text('Pesanan', style: body4Black),
                onTap: () async {
                  if (userType == 'Doctors') {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => DoctorBookingScreen(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 100),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => ParentBookingScreen(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 100),
                      ),
                    );
                  }
                },
              ),
            ),
            userType == 'Doctors'
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, left: 10, right: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        //<-- SEE HERE
                        side: BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor: Colors.white,
                      leading: Container(
                          decoration: BoxDecoration(
                              color: oneColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: oneColor, width: 1)),
                          width: 40,
                          height: 40, //devSize.height*0.05,
                          child: Image.asset(
                            "assets/faq24.png",
                          )),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15,
                      ),
                      title: Text('Pertanyaan Umum', style: body4Black),
                      onTap: () async {},
                    ),
                  ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  //<-- SEE HERE
                  side: BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: Colors.white,
                leading: Container(
                    decoration: BoxDecoration(
                        color: threeColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: threeColor, width: 1)),
                    width: 40,
                    height: 40, //devSize.height*0.05,
                    child: Image.asset("assets/about_us24.png")),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 15,
                ),
                title: Text('Tentang Kami', style: body4Black),
                onTap: () async {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (c, a1, a2) => AboutUsScreen(),
                      transitionsBuilder: (c, anim, a2, child) =>
                          FadeTransition(opacity: anim, child: child),
                      transitionDuration: Duration(milliseconds: 100),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  //<-- SEE HERE
                  side: BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: Colors.white,
                leading: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red, width: 1)),
                    width: 40,
                    height: 40, //devSize.height*0.05,
                    child: Image.asset(
                      "assets/logout.png",
                      color: Colors.white,
                    )),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 15,
                ),
                title: Text('Keluar', style: body4Black),
                onTap: () async {
                  _methodsHandler.signOut(context);
                  //SharedPreferences prefs = await SharedPreferences.getInstance();
                  // prefs.remove('userType').whenComplete(() {
                  //
                  // });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
