import 'package:aksonhealth/theme.dart';
import 'package:aksonhealth/view/doctor/bottomNavBarDoctor/doctor_nav_bar_screen.dart';
import 'package:aksonhealth/view/parents/bottomNavBar/app_bottom_nav_bar_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aksonhealth/model/firebase_auth.dart';
import 'package:aksonhealth/model/input_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorLoginScreen extends StatefulWidget {
  final String userType;
  const DoctorLoginScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _DoctorLoginScreenState createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isVisible = false;
  MethodsHandler _methodsHandler = MethodsHandler();
  InputValidator _inputValidator = InputValidator();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String isCreated = '';
  String isCreatedStudent = '';

  @override
  void initState() {
    print('Admin ${widget.userType}');
    setState(() {
      isCreated = '';
      isCreatedStudent = '';
      _isVisible = false;
      _isLoading = false;
    });
    print('userType');
    print(widget.userType.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: darkBlueColor,
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          //height: size.height,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                height: size.height * 2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Center(
                      child: SizedBox(
                        child: Image.asset(
                          'assets/aksondokter.png',
                          fit: BoxFit.scaleDown,
                          height: 200,
                          width: 200,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      //  color: Colors.white,
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                      child: TextFormField(
                        controller: _emailAddressController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   userInput.text = value.toString();
                          // });
                        },
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusColor: Colors.white,
                          //add prefix icon

                          // errorText: "Error",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: blueColor, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.white,
                          hintText: "Email",

                          //make hint text
                          hintStyle: GoogleFonts.nunito(
                            color: darkBlueColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(left: 16, right: 16, top: 0),
                      child: TextFormField(
                        autofocus: true,
                        controller: _passwordController,
                        obscureText: true,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   userInput.text = value.toString();
                          // });
                        },
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                          focusColor: Colors.white,
                          //add prefix icon
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

                          // errorText: "Error",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: blueColor, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.grey,
                          hintText: "Password",

                          //make hint text
                          hintStyle: GoogleFonts.nunito(
                            color: darkBlueColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    _isLoading
                        ? CircularProgressIndicator(
                            color: blueColor,
                            strokeWidth: 2,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 4),
                                      blurRadius: 5.0)
                                ],
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.5)),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.0, 1.0],
                                  colors: [
                                    blueColor,
                                    blueColor,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(size.width, 50)),
                                    backgroundColor: MaterialStateProperty.all(
                                        darkBlueColor),
                                    // elevation: MaterialStateProperty.all(3),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  onPressed: () async {
                                    print(_emailAddressController.text);
                                    print(_passwordController.text);
                                    print(widget.userType.toString());
                                    if (_inputValidator.validateEmail(
                                                _emailAddressController.text) !=
                                            'success' &&
                                        _emailAddressController
                                            .text.isNotEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Wrong email, please use a correct email')));
                                    } else {
                                      if (_emailAddressController
                                          .text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Enter Email Address')));
                                      } else if (_passwordController
                                          .text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('Enter Password')));
                                      } else {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();

                                        try {
                                          if (widget.userType == 'Doctors') {
                                            final snapshot =
                                                await FirebaseFirestore.instance
                                                    .collection('Doctors')
                                                    .get();
                                            snapshot.docs.forEach((element) {
                                              print('user data');
                                              if (element['email'] ==
                                                  _emailAddressController.text
                                                      .toString()
                                                      .trim()) {
                                                print(
                                                    'user age in if of current user ');
                                                //   print(element['age']);
                                                setState(() {
                                                  isCreated = 'yes';
                                                });
                                              }
                                            });

                                            if (isCreated == 'yes') {
                                              final result = await _auth
                                                  .signInWithEmailAndPassword(
                                                      email:
                                                          _emailAddressController
                                                              .text
                                                              .trim()
                                                              .toString(),
                                                      password:
                                                          _passwordController
                                                              .text);
                                              final user = result.user;

                                              prefs.setString('userEmail',
                                                  _emailAddressController.text);
                                              prefs.setString('userPassword',
                                                  _passwordController.text);
                                              prefs.setString(
                                                  'userId', user!.uid);
                                              prefs.setString('userType',
                                                  widget.userType.toString());
                                              print(
                                                  'Account creation successful');
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              Navigator.pushReplacement(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (c, a1, a2) =>
                                                      AppDoctorBottomNavBarScreen(
                                                    index: 0,
                                                    title: '',
                                                    subTitle: '',
                                                  ),
                                                  transitionsBuilder:
                                                      (c, anim, a2, child) =>
                                                          FadeTransition(
                                                              opacity: anim,
                                                              child: child),
                                                  transitionDuration: Duration(
                                                      milliseconds: 100),
                                                ),
                                              );
                                              // ScaffoldMessenger.of(context).showSnackBar(
                                              //     const  SnackBar(
                                              //         content:  Text('Successfully Login')
                                              //     )
                                              // );
                                            } else {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              _methodsHandler.showAlertDialog(
                                                  context,
                                                  'Sorry',
                                                  'User Not Found');
                                            }
                                          } else if (widget.userType ==
                                              'Parents') {
                                            final snapshot =
                                                await FirebaseFirestore.instance
                                                    .collection('Parents')
                                                    .get();
                                            snapshot.docs.forEach((element) {
                                              print('user data');
                                              if (element['email'] ==
                                                  _emailAddressController.text
                                                      .toString()
                                                      .trim()) {
                                                print(
                                                    'user age in if of current user ');
                                                //   print(element['age']);
                                                setState(() {
                                                  isCreated = 'yes';
                                                });
                                              }
                                            });

                                            if (isCreated == 'yes') {
                                              final result = await _auth
                                                  .signInWithEmailAndPassword(
                                                      email:
                                                          _emailAddressController
                                                              .text
                                                              .trim()
                                                              .toString(),
                                                      password:
                                                          _passwordController
                                                              .text);
                                              final user = result.user;

                                              prefs.setString('userEmail',
                                                  _emailAddressController.text);
                                              prefs.setString('userPassword',
                                                  _passwordController.text);
                                              prefs.setString(
                                                  'userId', user!.uid);
                                              prefs.setString('userType',
                                                  widget.userType.toString());
                                              print(
                                                  'Account creation successful');
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              Navigator.pushReplacement(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (c, a1, a2) =>
                                                      AppBottomNavBarScreen(
                                                    index: 0,
                                                    title: '',
                                                    subTitle: '',
                                                  ),
                                                  transitionsBuilder:
                                                      (c, anim, a2, child) =>
                                                          FadeTransition(
                                                              opacity: anim,
                                                              child: child),
                                                  transitionDuration: Duration(
                                                      milliseconds: 100),
                                                ),
                                              );
                                              // ScaffoldMessenger.of(context).showSnackBar(
                                              //     const  SnackBar(
                                              //         content:  Text('Successfully Login')
                                              //     )
                                              // );
                                            } else {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              _methodsHandler.showAlertDialog(
                                                  context,
                                                  'Sorry',
                                                  'User Not Found');
                                            }
                                          } else {
                                            if (widget.userType == 'Admin' &&
                                                _emailAddressController.text ==
                                                    'admin@gmail.com' &&
                                                _passwordController.text ==
                                                    '12345678') {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              prefs.setString('userEmail',
                                                  _emailAddressController.text);
                                              prefs.setString('userPassword',
                                                  _passwordController.text);
                                              print(widget.userType.toString());
                                              prefs.setString('userType',
                                                  widget.userType.toString());

                                              // Navigator.pushReplacement(
                                              //   context,
                                              //   PageRouteBuilder(
                                              //     pageBuilder: (c, a1, a2) => AdminHomeScreen(),
                                              //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                              //     transitionDuration: Duration(milliseconds: 100),
                                              //   ),
                                              // );
                                            } else {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              _methodsHandler.showAlertDialog(
                                                  context,
                                                  'Sorry',
                                                  'User Not Found');
                                            }
                                          }
                                        } on FirebaseAuthException catch (e) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          print(e.code);
                                          switch (e.code) {
                                            case 'invalid-email':
                                              _methodsHandler.showAlertDialog(
                                                  context,
                                                  'Sorry',
                                                  'Invalid Email Address');

                                              setState(() {
                                                _isLoading = false;
                                              });
                                              break;
                                            case 'wrong-password':
                                              _methodsHandler.showAlertDialog(
                                                  context,
                                                  'Sorry',
                                                  'Wrong Password');
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              break;
                                            case 'user-not-found':
                                              _methodsHandler.showAlertDialog(
                                                  context,
                                                  'Sorry',
                                                  'User Not Found');
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              break;
                                            case 'user-disabled':
                                              _methodsHandler.showAlertDialog(
                                                  context,
                                                  'Sorry',
                                                  'User Disabled');
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              break;
                                          }
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }
                                      }
                                    }

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => HomeScreen()),
                                    // );
                                  },
                                  child: Text('Login Dokter',
                                      style: GoogleFonts.nunito(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600))),
                            ),
                          ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
