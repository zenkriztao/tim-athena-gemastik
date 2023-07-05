import 'dart:io';
import 'package:autism_perdiction_app/view/doctor/bottomNavBarDoctor/doctor_nav_bar_screen.dart';
import 'package:autism_perdiction_app/view/parents/bottomNavBar/app_bottom_nav_bar_screen.dart';
import 'package:autism_perdiction_app/view/parents/home/home_screen.dart';
import 'package:autism_perdiction_app/view/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.length == 0) {


    if (Platform.isIOS) {
      // await Firebase.initializeApp(
      //     options: FirebaseOptions(apiKey: 'AIzaSyAFFk4hXMpio9X_Gz0wVCQvk4a5QAzllXM',
      //         appId: '1:97089701565:android:02972d723ec132a52119d4',
      //         messagingSenderId: '97089701565',
      //         storageBucket:  "agriculture-store-flutter.appspot.com",
      //         projectId: 'agriculture-store-flutter')
      // );
    }
    else {
      await Firebase.initializeApp(
          options: FirebaseOptions(apiKey: 'AIzaSyBHlyvmiwPQqbaIXEHvw12LzNoIhtuHtEY',
          appId: '1:849090647277:android:3400fa8f113e69b41d28e4',
          messagingSenderId: '849090647277',
          projectId: 'autism-gemastik',
          storageBucket: 'autism-gemastik.appspot.com',
          )
      );
    }

  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  String userType = '',email = '', uid = '';



  getData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Starting usertype ' + prefs.getString('userType').toString());
    if(prefs.getString('userType') != null) {
      setState(() {
        userType = prefs.getString('userType')!;
        email = prefs.getString('userEmail')!;
        // uid = prefs.getString('userId')!;
      });
      print(userType.toString() + ' This is user type');
    } else {
      print('Starting usertype');
    }


  }
  @override
  void initState() {
    print('Starting usertype');

    // TODO: implement initState
    // setState(() {
    //   userType = '';
    //   email = '';
    //   uid = '';
    // });

    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:
      userType == 'Parents' ? AppBottomNavBarScreen(index: 0, title: '', subTitle: '',) :
      userType == 'Doctors' ? AppDoctorBottomNavBarScreen(index: 0, title: '', subTitle: '',)  :
      SplashScreen(),
    );
  }
}


