import 'package:aksonhealth/constants.dart';
import 'package:aksonhealth/model/firebase_auth.dart';
import 'package:aksonhealth/theme.dart';
import 'package:aksonhealth/view/aboutUs/about_us_screen.dart';
import 'package:aksonhealth/view/doctor/bookings/bookings_screen.dart';
import 'package:aksonhealth/view/parents/myBookings/my_bookings_screen.dart';
import 'package:aksonhealth/view/parents/profile/update_profile_screen.dart';
import 'package:aksonhealth/view/reports/reports_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white, size: 25),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: darkBlueColor,
          title: Text(
            'Pengaturan',
            style: GoogleFonts.nunito(
                fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
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
                         ),
                      width: 40,
                      height: 40, //devSize.height*0.05,
                      child: Image.asset("assets/icons/edit.png")),
                  trailing: Icon(
                    Icons.arrow_forward,
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
                                shape: BoxShape.circle,
                                ),
                            width: 40,
                            height: 40, //devSize.height*0.05,
                            child: Image.asset("assets/icons/laporan.png")),
                        trailing: Icon(
                          Icons.arrow_forward,
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
                          shape: BoxShape.circle,
                          ),
                      width: 40,
                      height: 40, //devSize.height*0.05,
                      child: Image.asset("assets/icons/janji.png")),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 15,
                  ),
                  title: Text('Buat Janji', style: body4Black),
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
                          shape: BoxShape.circle,
                          ),
                      width: 40,
                      height: 40, //devSize.height*0.05,
                      child: Image.asset("assets/icons/about.png")),
                  trailing: Icon(
                    Icons.arrow_forward,
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
                          shape: BoxShape.circle,
                         ),
                      width: 40,
                      height: 40, //devSize.height*0.05,
                      child: Image.asset(
                        "assets/icons/keluar.png",
                        color: Colors.blueGrey,
                      )),
                  trailing: Icon(
                    Icons.arrow_forward,
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
      ),
    );
  }

   Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Keluar Aplikasi'),
            content: Text('Kamu ingin keluar aplikasi?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: greenColor,
                    textStyle: GoogleFonts.nunito(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text('Tidak'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    textStyle: GoogleFonts.nunito(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                child: Text('Ya'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }
  
}
