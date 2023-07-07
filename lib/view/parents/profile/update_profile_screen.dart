import 'dart:io';
import 'package:aksonhealth/constants.dart';
import 'package:aksonhealth/model/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String name = '', image = '', docId1 = '';

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
        .collection(userType == 'Doctors' ? 'Doctors' : 'Parents')
        .where('uid', isEqualTo: _auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        driverName = value.docs[0]['name'];
        _nameController.text = value.docs[0]['name'];
        driverEmail = value.docs[0]['email'];
        docId1 = value.docs[0].id.toString();
        driverUid = _auth.currentUser!.uid;
      });
    });

    print(driverName.toString() + ' name is here');
    print(docId1.toString() + ' name is here');
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      driverEmail = '';
      driverName = '';
    });
    getDriver();
    getData();
    setState(() {
      image = '';
    });
    super.initState();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('userEmail') != null) {
      setState(() {
        _emailAddressController.text = prefs.getString('userEmail')!;
        //name =  prefs.getString('userName')!;
      });
    }
  }

  PickedFile? _pickedFile;
  File? imageFile;
  bool isLoading = false;
  bool isLoadingImage = false;

  //final FirebaseAuth auth = FirebaseAuth.instance;

  void _showPicker(context) {
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
                        _imgFromGallery();
                        setState(() {
                          isLoadingImage = true;
                        });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      setState(() {
                        isLoadingImage = true;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50))!;

    getUrl(_pickedFile!.path).then((value) {
      if (value != null) {
        setState(() {
          profileImage = value.toString();
          prefs.setString('profileImage', profileImage.toString());
          isLoadingImage = false;
        });
      } else {
        setState(() {
          isLoadingImage = false;
        });
        print('sorry error');
      }
    });

    setState(() {
      imageFile = File(_pickedFile!.path);
      image = 'done';
      // isLoadingImage = false;
      print('List Printed');
    });
  }

  _imgFromGallery() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50))!;
    getUrl(_pickedFile!.path).then((value) {
      if (value != null) {
        setState(() {
          profileImage = value.toString();
          prefs.setString('profileImage', profileImage.toString());
          isLoadingImage = false;
        });
      } else {
        setState(() {
          isLoadingImage = false;
        });
        print('sorry error');
      }
    });
    setState(() {
      imageFile = File(_pickedFile!.path);
      //  isLoadingImage = false;
      image = 'done';
      print('List Printed');
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Ubah Profil',
            style: GoogleFonts.nunito(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                  width: size.width,
                  child: Center(
                    child: Text(
                      '$name',
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                      child: TextFormField(
                        controller: _nameController,
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
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "",
    
                          //make hint text
                          hintStyle: GoogleFonts.nunito(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          //create lable
                          labelText: 'Nama Lengkap',
                          //lable style
                          labelStyle: GoogleFonts.nunito(
                            color: darkRedColor,
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
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                      child: TextFormField(
                        controller: _emailAddressController,
                        enabled: false,
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
                                BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "",
    
                          //make hint text
                          hintStyle: GoogleFonts.nunito(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
    
                          //create lable
                          labelText: 'Email',
                          //lable style
                          labelStyle: GoogleFonts.nunito(
                            color: darkRedColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    isLoading
                        ? Center(
                              child: CircularProgressIndicator(
                              color: darkRedColor,
                            strokeWidth: 1,
                          ))
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
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.0, 1.0],
                                  colors: [
                                    darkRedColor,
                                    lightRedColor,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(size.width, 50)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    // elevation: MaterialStateProperty.all(3),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  onPressed: () async {
                                    if (_nameController.text.isEmpty) {
                                      var snackBar = SnackBar(
                                        content: Text(
                                          'Nama harus diisi',
                                          style: GoogleFonts.nunito(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.red,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      setState(() {
                                        isLoading = true;
                                      });
    
                                      await FirebaseFirestore.instance
                                          .collection(userType == 'Doctors'
                                              ? 'Doctors'
                                              : 'Parents')
                                          .doc(docId1)
                                          .update({
                                        'name': _nameController.text,
                                      }).then((value) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.pop(context);
                                        print('name updated');
                                      });
                                    }
                                  },
                                  child: Text('', style: buttonStyle)),
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
                    primary: Colors.green,
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
                    primary: redColor,
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
