import 'package:aksonhealth/constants.dart';
import 'package:aksonhealth/model/firebase_auth.dart';
import 'package:aksonhealth/view/doctor/doctorReportDetail/doctor_report_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PaymentType { Credit_Debit, ConDelivery }

class BookingDetailScreen extends StatefulWidget {
  final String childImage;
  final String parentName;
  final String parentEmail;
  final String childName;
  final String childCase;
  final String advice;
  final String date;
  final String age;
  final String gender;
  final int score;

  final String parentUid;
  final String status;
  final String payment;
  final String userIs;
  final String docId;

  const BookingDetailScreen({
    Key? key,
    required this.childImage,
    required this.age,
    required this.advice,
    required this.parentName,
    required this.parentEmail,
    required this.parentUid,
    required this.date,
    required this.childName,
    required this.childCase,
    required this.userIs,
    required this.gender,
    required this.payment,
    required this.score,
    required this.status,
    required this.docId,
  }) : super(key: key);

  @override
  _BookingDetailScreenState createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  final TextEditingController _cardUserControler = TextEditingController();
  final TextEditingController _cardNumberControler = TextEditingController();
  final TextEditingController _cardCVCControler = TextEditingController();
  final TextEditingController _cardDateControler = TextEditingController();
  MethodsHandler _methodsHandler = MethodsHandler();
  List<Map<String, dynamic>> _reports = [];
  PaymentType _site = PaymentType.ConDelivery;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String isCreated = '', endTime = '';
  DateTime? _chosenDateTime;
  int y = 0, index1 = -1;
  String? renterEmail = '', renterName = '', renterUid = '', isSelected = 'no';
  String? selectedDoctorEmail = '',
      selectedDoctorName = '',
      selectedDoctorUid = '',
      selectedDoctorPhone = '',
      selectedDoctorImage = '',
      selectedDoctorSpec = '',
      selectedDoctorCategory = '';
  bool _isLoading = false;

  String name = '',
      email = '',
      uid = '',
      childName = '',
      age = '',
      gender = '',
      childImage = '',
      showReport = '',
      childCase = '',
      childAdvice = '',
      date = '',
      selectedIndex = '';
  String text = '';
  int score = 0;

  @override
  void initState() {
    getData();
    setState(() {
      isSelected = 'no';
      showReport = '';
      y = 0;
      renterName = '';
      renterEmail = '';
      renterUid = '';
      isCreated = '';
      _isLoading = false;
    });
    getRenter();
    super.initState();
  }

  getRenter() async {
    setState(() {
      y = 1;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance
        .collection('Parents')
        .where('uid', isEqualTo: _auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        renterName = value.docs[0]['name'];
        renterEmail = value.docs[0]['email'];
        renterUid = _auth.currentUser!.uid;
      });
    });
    print(renterName.toString() + ' name is here');
    print(renterEmail.toString() + ' name is here');
  }

  getData() async {
    FirebaseFirestore.instance
        .collection('Parents')
        .where('uid', isEqualTo: widget.parentUid)
        .get()
        .then((value) {
      setState(() {
        childName = value.docs[0]['childName'];
        gender = value.docs[0]['gender'];
        age = value.docs[0]['childAge'];
        childImage = value.docs[0]['childImage'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: whiteColor, size: 25),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: appBarColor,
        title: Text(
          'Booking',
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              height: size.height * 0.15,
              width: size.width * 0.95,
              decoration: BoxDecoration(
                  color: buttonColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        widget.childImage.toString(),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.childName,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Text(
                        widget.age,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                      Text(
                        widget.gender,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.4),
                  //     offset: const Offset(6, 6),
                  //     blurRadius: 8,
                  //   ),
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.3),
                  //     offset: const Offset(4, 4),
                  //     blurRadius: 5,
                  //   ),
                  // ],
                  ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Card(
                            child: Container(
                              height: size.height * 0.055,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Parent Name ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      widget.parentName.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Card(
                            child: Container(
                              height: size.height * 0.055,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Parent Email ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      widget.parentEmail.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 4),
                                blurRadius: 5.0)
                          ],
                          border:
                              Border.all(color: Colors.white.withOpacity(0.5)),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.0, 1.0],
                            colors: [
                              buttonColor,
                              buttonColor,
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
                              backgroundColor:
                                  MaterialStateProperty.all(buttonColor),
                              // elevation: MaterialStateProperty.all(3),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) =>
                                      DoctorReportDetailScreen(
                                    childName: childName,
                                    childAge: age,
                                    childGender: gender,
                                    childCase: widget.childCase,
                                    childAdvice: widget.advice,
                                    date: widget.date,
                                    total: widget.score,
                                    parentUid: widget.parentUid,
                                    docId: widget.docId,
                                    user: 'doctor',
                                  ),
                                  transitionsBuilder: (c, anim, a2, child) =>
                                      FadeTransition(
                                          opacity: anim, child: child),
                                  transitionDuration:
                                      Duration(milliseconds: 100),
                                ),
                              );
                            },
                            child: Text('View Report', style: buttonStyle)),
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 16,right: 16),
                    //   child: Container(
                    //
                    //     decoration: BoxDecoration(
                    //       boxShadow: [
                    //         BoxShadow(
                    //             color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                    //       ],
                    //       border: Border.all(color: Colors.white.withOpacity(0.5)),
                    //       gradient: LinearGradient(
                    //         begin: Alignment.topLeft,
                    //         end: Alignment.bottomRight,
                    //         stops: [0.0, 1.0],
                    //         colors: [
                    //           buttonColor,
                    //           buttonColor,
                    //         ],
                    //       ),
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: ElevatedButton(
                    //         style: ButtonStyle(
                    //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    //             RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(10.0),
                    //             ),
                    //           ),
                    //           minimumSize: MaterialStateProperty.all(Size(size.width, 50)),
                    //           backgroundColor:
                    //           MaterialStateProperty.all(buttonColor),
                    //           // elevation: MaterialStateProperty.all(3),
                    //           shadowColor:
                    //           MaterialStateProperty.all(Colors.transparent),
                    //         ),
                    //
                    //         onPressed: () async {
                    //
                    //
                    //
                    //         }, child: Text('Evaluate', style: buttonStyle)),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: size.height * 0.02,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
