import 'dart:io';

import 'package:autism_perdiction_app/constants.dart';
import 'package:autism_perdiction_app/model/firebase_auth.dart';
import 'package:autism_perdiction_app/model/input_validator.dart';
import 'package:autism_perdiction_app/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  final String userType;
  const SignUpScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailControoler = TextEditingController();
  final TextEditingController _phoneControoler = TextEditingController();
  final TextEditingController _passwordControoler = TextEditingController();
  final TextEditingController _confirmPasswordControoler =
      TextEditingController();
  final TextEditingController _firstNameControoler = TextEditingController();
  final TextEditingController _addressControoler = TextEditingController();
  final TextEditingController _childNameControoler = TextEditingController();
  final TextEditingController _childAgeControoler = TextEditingController();
  final TextEditingController _clinicNameControoler = TextEditingController();

  MethodsHandler _methodsHandler = MethodsHandler();
  String dropdownvalue = 'Pilih Jenis Kelamin';
  InputValidator _inputValidator = InputValidator();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _imageLoading = false;
  PickedFile? _pickedFile;

  bool _isLoading = false;
  bool _isVisible = false;
  bool _isVisibleC = false;

  String? profileImage = '',
      docId,
      userType,
      driverEmail = '',
      driverName = '',
      driverUid = '';

  void _showPicker(context, bool isProfile) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(isProfile);

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(isProfile);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera(bool isProfile) async {
    _pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50))!;
    setState(() {
      _imageLoading = true;
      print('List Printed');
      getUrl(_pickedFile!.path).then((value) {
        if (value != null) {
          setState(() {
            profileImage = value.toString();
            _imageLoading = false;
          });
        } else {
          setState(() {
            _imageLoading = false;
          });
          print('sorry error');
        }
      });
    });
  }

  _imgFromGallery(bool isProfile) async {
    _pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50))!;
    setState(() {
      _imageLoading = true;
      print('List Printed');
      getUrl(_pickedFile!.path).then((value) {
        if (value != null) {
          setState(() {
            profileImage = value.toString();
            _imageLoading = false;
          });
        } else {
          setState(() {
            _imageLoading = false;
          });
          print('sorry error');
        }
      });
    });
  }

  Future<String?> getUrl(String path) async {
    final file = File(path);
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref()
        .child("image" + DateTime.now().toString())
        .putFile(file);
    if (snapshot.state == TaskState.success) {
      return await snapshot.ref.getDownloadURL();
    }
  }

  List items = [
    'Pilih Jenis Kelamin',
    'Laki - Laki',
    'Perempuan',
  ];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isVisible = false;
      _isVisibleC = false;
      _isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      //resizeToAvoidBottomInset: false,
      body: widget.userType == 'Doctors'
          ? SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Container(
                      width: size.width,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  size: 30,
                                  color: blackColor,
                                )),
                          )
                        ],
                      ),
                    ),

                    // SizedBox(
                    //   height: size.height*0.012,
                    // ),

                    Container(
                      decoration: BoxDecoration(
                          //color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30))),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.01,
                            ),

                            Center(
                              child: SizedBox(
                                child: Image.asset(
                                  'assets/logo.png',
                                  fit: BoxFit.scaleDown,
                                  height: 200,
                                  width: 200,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: size.height * 0.03,
                            ),

                            Center(
                                child: Text(
                              'Buat Akun',
                              style: GoogleFonts.nunito(
                                  color: blueColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            )),

                            SizedBox(
                              height: size.height * 0.05,
                            ),

                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 0),
                              child: TextFormField(
                                controller: _firstNameControoler,
                                keyboardType: TextInputType.name,
                                style: GoogleFonts.nunito(
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  focusColor: Colors.white,
                                  //add prefix icon

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: blueColor, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: "Nama Dokter",

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
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 0),
                              child: TextFormField(
                                controller: _clinicNameControoler,
                                keyboardType: TextInputType.name,
                                style: GoogleFonts.nunito(
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  focusColor: Colors.white,
                                  //add prefix icon

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: blueColor, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: "Nama Klinik",

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
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 0),
                              child: TextFormField(
                                controller: _emailControoler,
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.nunito(
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  focusColor: Colors.white,
                                  //add prefix icon

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: blueColor, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: "Email Dokter",

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
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 0),
                              child: TextFormField(
                                controller: _phoneControoler,
                                keyboardType: TextInputType.phone,
                                style: GoogleFonts.nunito(
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

                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  focusColor: Colors.white,
                                  //add prefix icon

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: blueColor, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: "Nomor Handphone",

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
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 0),
                              child: TextFormField(
                                controller: _addressControoler,
                                keyboardType: TextInputType.streetAddress,
                                style: GoogleFonts.nunito(
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  focusColor: Colors.white,
                                  //add prefix icon

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: blueColor, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: "Address",

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
                                  borderRadius: BorderRadius.circular(10)),
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 0),
                              child: TextFormField(
                                autofocus: true,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                controller: _passwordControoler,
                                style: GoogleFonts.nunito(
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: blueColor, width: 1.0),
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
                              height: size.height * 0.02,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 0),
                              child: TextFormField(
                                autofocus: true,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                controller: _confirmPasswordControoler,
                                style: GoogleFonts.nunito(
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: blueColor, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: "Konfirmasi Password",

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

                            Column(
                              children: [
                                Container(
                                  //color: whiteColor,
                                  width: size.width * 0.9,
                                  height: size.height * 0.055,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _showPicker(context, true);
                                        },
                                        child: Container(
                                          width: size.width * 0.9,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1)),
                                          //  width: size.width*0.15,
                                          alignment: Alignment.centerLeft,
                                          //  height: size.height*0.08,
                                          child: Center(
                                              child: Text(
                                            'Upload Clinic Image',
                                            style: GoogleFonts.nunito(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            _imageLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))
                                : Container(),

                            profileImage == ""
                                ? Container()
                                : Container(
                                    height: 120,
                                    width: 120,
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              profileImage.toString(),
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.white,
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  profileImage = "";
                                                });
                                              },
                                              icon: Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                                size: 20,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: size.height * .03,
                            ),

                            // SizedBox(
                            //   height: size.height*0.05,
                            // ),

                            _isLoading
                                ? CircularProgressIndicator(
                                    color: darkBlueColor,
                                    strokeWidth: 2,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 4),
                                              blurRadius: 5.0)
                                        ],
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          stops: [0.0, 1.0],
                                          colors: [
                                            darkBlueColor,
                                            darkBlueColor,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(size.width, 50)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            // elevation: MaterialStateProperty.all(3),
                                            shadowColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                          ),
                                          onPressed: () async {
                                            if (_inputValidator.validateEmail(
                                                        _emailControoler
                                                            .text) !=
                                                    'success' &&
                                                _emailControoler
                                                    .text.isNotEmpty) {
                                              Fluttertoast.showToast(
                                                  msg: "Wrong email address",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }

                                            // else if (_inputValidator.validateMobile(
                                            //     _phoneControoler.text) !=
                                            //     'success' &&
                                            //     _phoneControoler.text.isNotEmpty) {
                                            //   Fluttertoast.showToast(
                                            //       msg: "Nomor Handphone Starts with + followed by code then number (Hint +923346567876)",
                                            //       toastLength: Toast.LENGTH_SHORT,
                                            //       gravity: ToastGravity.BOTTOM,
                                            //       timeInSecForIosWeb: 1,
                                            //       backgroundColor: Colors.black,
                                            //       textColor: Colors.white,
                                            //       fontSize: 16.0
                                            //   );
                                            // }

                                            else if ((_passwordControoler
                                                            .text.length <
                                                        7 &&
                                                    _passwordControoler
                                                        .text.isNotEmpty) &&
                                                (_confirmPasswordControoler
                                                            .text.length <
                                                        7 &&
                                                    _confirmPasswordControoler
                                                        .text.isNotEmpty)) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Password and Konfirmasi Password harus sama",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else if (_passwordControoler
                                                    .text !=
                                                _confirmPasswordControoler
                                                    .text) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Password and Konfirmasi Password harus sama",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              if (_firstNameControoler
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Doctor Name harus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              }

                                              // else  if(_clinicNameControoler.text.isEmpty)
                                              // {
                                              //   Fluttertoast.showToast(
                                              //       msg: "Clinic Name harus diisi",
                                              //       toastLength: Toast.LENGTH_SHORT,
                                              //       gravity: ToastGravity.BOTTOM,
                                              //       timeInSecForIosWeb: 1,
                                              //       backgroundColor: Colors.black,
                                              //       textColor: Colors.white,
                                              //       fontSize: 16.0
                                              //   );
                                              // }

                                              else if (_emailControoler
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Email Address harus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else if (_phoneControoler
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg: "",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else if (_addressControoler
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg: "Address harus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else if (_passwordControoler
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg: "Password harus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else if (_confirmPasswordControoler
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Konfirmasi Password harus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else if (profileImage == "") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Clinic picture harus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else {
                                                setState(() {
                                                  _isLoading = true;
                                                  print('We are in loading');
                                                  //  state = ButtonState.loading;
                                                });

                                                print(_firstNameControoler.text
                                                    .toString());
                                                print(_emailControoler.text
                                                    .toString());
                                                print(_passwordControoler.text
                                                    .toString());
                                                print(_phoneControoler.text
                                                    .toString());
                                                //createAccount();
                                                //_methodsHandler.createAccount(name: _controllerClinic.text, email: _controller.text, password: _controllerPass.text, context: context);
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();

                                                FirebaseFirestore.instance
                                                    .collection(widget.userType
                                                        .toString())
                                                    .where("email",
                                                        isEqualTo:
                                                            _emailControoler
                                                                .text
                                                                .trim())
                                                    .get()
                                                    .then((value) async {
                                                  if (value.docs.isNotEmpty) {
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "Sorry email account already exists",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 4,
                                                    );
                                                  } else {
                                                    try {
                                                      User? result = (await _auth
                                                              .createUserWithEmailAndPassword(
                                                                  email:
                                                                      _emailControoler
                                                                          .text
                                                                          .trim(),
                                                                  password:
                                                                      _passwordControoler
                                                                          .text
                                                                          .trim()))
                                                          .user;

                                                      if (result != null) {
                                                        var user = result;

                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(widget
                                                                .userType
                                                                .toString())
                                                            .doc()
                                                            .set({
                                                          "email":
                                                              _emailControoler
                                                                  .text
                                                                  .trim(),
                                                          "password":
                                                              _passwordControoler
                                                                  .text
                                                                  .trim(),
                                                          "uid": user.uid,
                                                          "name":
                                                              _firstNameControoler
                                                                  .text,
                                                          "phone":
                                                              _phoneControoler
                                                                  .text,
                                                          "address":
                                                              _addressControoler
                                                                  .text,
                                                          "image": profileImage
                                                              .toString(),
                                                          "clinicName":
                                                              _clinicNameControoler
                                                                  .text
                                                                  .toString(),
                                                        }).then((value) =>
                                                                print(
                                                                    'success'));

                                                        prefs.setString(
                                                            'userType',
                                                            'Users');
                                                        prefs.setString(
                                                            'userEmail',
                                                            _emailControoler
                                                                .text
                                                                .trim());
                                                        prefs.setString(
                                                            'userPassword',
                                                            _passwordControoler
                                                                .text
                                                                .trim());
                                                        prefs.setString(
                                                            'name',
                                                            _firstNameControoler
                                                                .text
                                                                .trim());
                                                        prefs.setString(
                                                            'userId', user.uid);
                                                        print(
                                                            'Account creation successful');
                                                        setState(() {
                                                          _isLoading = false;
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                        // Navigator.pushReplacement(
                                                        //   context,
                                                        //   PageRouteBuilder(
                                                        //     pageBuilder: (c, a1, a2) => HomeScreen(),
                                                        //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                        //     transitionDuration: Duration(milliseconds: 100),
                                                        //   ),
                                                        // );
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              "Account created successfully",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 4,
                                                        );
                                                      } else {
                                                        setState(() {
                                                          _isLoading = false;
                                                        });
                                                        print('error');
                                                      }
                                                    } on FirebaseAuthException catch (e) {
                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                      if (e.code ==
                                                          'email-already-in-use') {
                                                        showAlertDialog(
                                                            context,
                                                            'Sorry',
                                                            'The email address is already in use by another account.');
                                                      }
                                                      print(e.message);
                                                      print(e.code);
                                                    }

                                                    await Future.delayed(
                                                        Duration(seconds: 1));
                                                  }
                                                });
                                              }
                                            }
                                          },
                                          child: Text('Sign Up',
                                              style: buttonStyle)),
                                    ),
                                  ),
                            SizedBox(
                              height: size.height * .03,
                            ),
                            // SizedBox(
                            //   height: size.height*0.1,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Container(
                      width: size.width,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  size: 30,
                                  color: blackColor,
                                )),
                          )
                        ],
                      ),
                    ),

                    // SizedBox(
                    //   height: size.height*0.012,
                    // ),

                    Container(
                      decoration: BoxDecoration(
                          //color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30))),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Center(
                              child: SizedBox(
                                child: Image.asset(
                                  'assets/logo.png',
                                  fit: BoxFit.scaleDown,
                                  height: 200,
                                  width: 200,
                                ),
                              ),
                            ),

                            Center(
                                child: Text(
                              'Buat Akun',
                              style: GoogleFonts.nunito(
                                  color: blackColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            )),

                            SizedBox(
                              height: size.height * 0.05,
                            ),

                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 0),
                              child: TextFormField(
                                controller: _firstNameControoler,
                                keyboardType: TextInputType.name,
                                style: GoogleFonts.nunito(
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  focusColor: Colors.white,
                                  //add prefix icon

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: blueColor, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: "Nama Orang tua",

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
                              height: size.height * 0.01,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 0),
                              child: TextFormField(
                                controller: _emailControoler,
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.nunito(
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  focusColor: Colors.white,
                                  //add prefix icon

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: blueColor, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: "Email Orang tua",

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
                              height: size.height * 0.01,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 0),
                              child: TextFormField(
                                controller: _phoneControoler,
                                keyboardType: TextInputType.phone,
                                style: GoogleFonts.nunito(
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

                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  focusColor: Colors.white,
                                  //add prefix icon

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: blueColor, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: "Nomor Handphone",

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
                              height: size.height * 0.01,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 0),
                              child: TextFormField(
                                controller: _addressControoler,
                                keyboardType: TextInputType.streetAddress,
                                style: GoogleFonts.nunito(
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  focusColor: Colors.white,
                                  //add prefix icon

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: blueColor, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: "Alamat",

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
                              height: size.height * 0.01,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 0),
                              child: TextFormField(
                                autofocus: true,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                controller: _passwordControoler,
                                style: GoogleFonts.nunito(
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: blueColor, width: 1.0),
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
                              height: size.height * 0.01,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 0),
                              child: TextFormField(
                                autofocus: true,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                controller: _confirmPasswordControoler,
                                style: GoogleFonts.nunito(
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: blueColor, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: "Konfirmasi Password",

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
                              height: size.height * 0.01,
                            ),

                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 0),
                              child: TextFormField(
                                autofocus: true,
                                keyboardType: TextInputType.name,
                                controller: _childNameControoler,
                                style: GoogleFonts.nunito(
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: blueColor, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: "Nama Anak",

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
                              height: size.height * 0.01,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 0),
                              child: TextFormField(
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                controller: _childAgeControoler,
                                style: GoogleFonts.nunito(
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
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: blueColor, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: "Umur Anak",

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
                              height: size.height * 0.01,
                            ),

                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                ),
                                child: Container(
                                  width: size.width * 0.9,
                                  height: size.height * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: darkGreyTextColor1),
                                    color: Colors.white,
                                    // image: DecorationImage(
                                    //   image: AssetImage("assets/images/signin/textfield.png"),
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        value: dropdownvalue,
                                        hint: const Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Text(
                                            'Pilih Spesialis',
                                            style: TextStyle(
                                                color: textColor,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12),
                                          ),
                                        ),
                                        dropdownColor: Colors.white,
                                        isExpanded: true,
                                        isDense:
                                            true, // Reduces the dropdowns height by +/- 50%
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: blueColor,
                                          ),
                                        ),
                                        items: items.map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Text(
                                                item,
                                                style: GoogleFonts.nunito(
                                                    fontWeight: FontWeight.w400,
                                                    color: blueColor,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (selectedItem) {
                                          setState(() {
                                            dropdownvalue =
                                                selectedItem.toString();
                                          });
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .01,
                            ),

                            Column(
                              children: [
                                Container(
                                  //color: whiteColor,
                                  width: size.width * 0.9,
                                  height: size.height * 0.055,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _showPicker(context, true);
                                        },
                                        child: Container(
                                          width: size.width * 0.9,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: darkBlueColor,
                                                  width: 1)),
                                          //  width: size.width*0.15,
                                          alignment: Alignment.centerLeft,
                                          //  height: size.height*0.08,
                                          child: Center(
                                              child: Text(
                                            'Upload foto Anak',
                                            style: GoogleFonts.nunito(
                                                color: darkBlueColor,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            _imageLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))
                                : Container(),

                            profileImage == ""
                                ? Container()
                                : Container(
                                    height: 120,
                                    width: 120,
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              profileImage.toString(),
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.white,
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  profileImage = "";
                                                });
                                              },
                                              icon: Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                                size: 20,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: size.height * .03,
                            ),

                            // SizedBox(
                            //   height: size.height*0.05,
                            // ),

                            _isLoading
                                ? CircularProgressIndicator(
                                    color: darkBlueColor,
                                    strokeWidth: 2,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 4),
                                              blurRadius: 5.0)
                                        ],
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          stops: [0.0, 1.0],
                                          colors: [
                                            darkBlueColor,
                                            darkBlueColor,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(size.width, 50)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            // elevation: MaterialStateProperty.all(3),
                                            shadowColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                          ),
                                          onPressed: () async {
                                            if (_inputValidator.validateEmail(
                                                        _emailControoler
                                                            .text) !=
                                                    'success' &&
                                                _emailControoler
                                                    .text.isNotEmpty) {
                                              Fluttertoast.showToast(
                                                  msg: "Wrong email address",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }

                                            // else if (_inputValidator.validateMobile(
                                            //     _phoneControoler.text) !=
                                            //     'success' &&
                                            //     _phoneControoler.text.isNotEmpty) {
                                            //   Fluttertoast.showToast(
                                            //       msg: "Nomor Handphone Starts with + followed by code then number (Hint +923346567876)",
                                            //       toastLength: Toast.LENGTH_SHORT,
                                            //       gravity: ToastGravity.BOTTOM,
                                            //       timeInSecForIosWeb: 1,
                                            //       backgroundColor: Colors.black,
                                            //       textColor: Colors.white,
                                            //       fontSize: 16.0
                                            //   );
                                            // }

                                            else if ((_passwordControoler
                                                            .text.length <
                                                        7 &&
                                                    _passwordControoler
                                                        .text.isNotEmpty) &&
                                                (_confirmPasswordControoler
                                                            .text.length <
                                                        7 &&
                                                    _confirmPasswordControoler
                                                        .text.isNotEmpty)) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Password and Confirm Password must be same",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else if (_passwordControoler
                                                    .text !=
                                                _confirmPasswordControoler
                                                    .text) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Password and Confirm Password must be same",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              if (_firstNameControoler
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Nama Orangtua harus diharus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else if (_emailControoler
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Email Address harus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else if (_phoneControoler
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Nomor Handphone harus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else if (_addressControoler
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg: "Alamat harus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else if (_passwordControoler
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg: "Password harus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else if (_confirmPasswordControoler
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Konfirmasi Password harus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else if (_childNameControoler
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Nama Anak harus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else if (_childAgeControoler
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Umur Anak harus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else if (dropdownvalue ==
                                                  "Pilih Jenis Kelamin") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Child gender harus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else if (profileImage == "") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Child picture harus diisi",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else {
                                                setState(() {
                                                  _isLoading = true;
                                                  print('We are in loading');
                                                  //  state = ButtonState.loading;
                                                });

                                                print(_firstNameControoler.text
                                                    .toString());
                                                print(_emailControoler.text
                                                    .toString());
                                                print(_passwordControoler.text
                                                    .toString());
                                                print(_phoneControoler.text
                                                    .toString());
                                                //createAccount();
                                                //_methodsHandler.createAccount(name: _controllerClinic.text, email: _controller.text, password: _controllerPass.text, context: context);
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();

                                                FirebaseFirestore.instance
                                                    .collection(widget.userType
                                                        .toString())
                                                    .where("email",
                                                        isEqualTo:
                                                            _emailControoler
                                                                .text
                                                                .trim())
                                                    .get()
                                                    .then((value) async {
                                                  if (value.docs.isNotEmpty) {
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "Sorry email account already exists",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 4,
                                                    );
                                                  } else {
                                                    try {
                                                      User? result = (await _auth
                                                              .createUserWithEmailAndPassword(
                                                                  email:
                                                                      _emailControoler
                                                                          .text
                                                                          .trim(),
                                                                  password:
                                                                      _passwordControoler
                                                                          .text
                                                                          .trim()))
                                                          .user;

                                                      if (result != null) {
                                                        var user = result;

                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(widget
                                                                .userType
                                                                .toString())
                                                            .doc()
                                                            .set({
                                                          "email":
                                                              _emailControoler
                                                                  .text
                                                                  .trim(),
                                                          "password":
                                                              _passwordControoler
                                                                  .text
                                                                  .trim(),
                                                          "uid": user.uid,
                                                          "name":
                                                              _firstNameControoler
                                                                  .text,
                                                          "phone":
                                                              _phoneControoler
                                                                  .text,
                                                          "address":
                                                              _addressControoler
                                                                  .text,
                                                          "childImage":
                                                              profileImage
                                                                  .toString(),
                                                          "childName":
                                                              _childNameControoler
                                                                  .text
                                                                  .toString(),
                                                          "childAge":
                                                              _childAgeControoler
                                                                  .text
                                                                  .toString(),
                                                          "gender":
                                                              dropdownvalue
                                                                  .toString(),
                                                        }).then((value) =>
                                                                print(
                                                                    'success'));

                                                        prefs.setString(
                                                            'userType',
                                                            'Users');
                                                        prefs.setString(
                                                            'userEmail',
                                                            _emailControoler
                                                                .text
                                                                .trim());
                                                        prefs.setString(
                                                            'userPassword',
                                                            _passwordControoler
                                                                .text
                                                                .trim());
                                                        prefs.setString(
                                                            'name',
                                                            _firstNameControoler
                                                                .text
                                                                .trim());
                                                        prefs.setString(
                                                            'userId', user.uid);
                                                        print(
                                                            'Account creation successful');
                                                        setState(() {
                                                          _isLoading = false;
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                        // Navigator.pushReplacement(
                                                        //   context,
                                                        //   PageRouteBuilder(
                                                        //     pageBuilder: (c, a1, a2) => HomeScreen(),
                                                        //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                        //     transitionDuration: Duration(milliseconds: 100),
                                                        //   ),
                                                        // );
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              "Account created successfully",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 4,
                                                        );
                                                      } else {
                                                        setState(() {
                                                          _isLoading = false;
                                                        });
                                                        print('error');
                                                      }
                                                    } on FirebaseAuthException catch (e) {
                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                      if (e.code ==
                                                          'email-already-in-use') {
                                                        showAlertDialog(
                                                            context,
                                                            'Sorry',
                                                            'The email address is already in use by another account.');
                                                      }
                                                      print(e.message);
                                                      print(e.code);
                                                    }

                                                    await Future.delayed(
                                                        Duration(seconds: 1));
                                                  }
                                                });
                                              }
                                            }
                                          },
                                          child: Text('Daftar',
                                              style: GoogleFonts.nunito(
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.w600))),
                                    ),
                                  ),
                            SizedBox(
                              height: size.height * .03,
                            ),
                            // SizedBox(
                            //   height: size.height*0.1,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

showAlertDialog(BuildContext context, String title, String content) {
  // set up the button

  CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: Text("$title"),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("$content"),
    ),
    actions: [
      // CupertinoDialogAction(
      //     child: Text("YES"),
      //     onPressed: ()
      //     {
      //       Navigator.of(context).pop();
      //     }
      // ),
      CupertinoDialogAction(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          })
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class FoodItem {
  final String image;
  final String title;
  final String description;

  FoodItem({
    required this.image,
    required this.title,
    required this.description,
  });
}
