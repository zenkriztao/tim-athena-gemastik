import 'package:aksonhealth/constants.dart';
import 'package:aksonhealth/model/firebase_auth.dart';
import 'package:aksonhealth/theme.dart';
import 'package:aksonhealth/view/chat/chat_dao.dart';
import 'package:aksonhealth/view/chat/chat_room.dart';
import 'package:aksonhealth/view/reports/report_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PaymentType { Credit_Debit, ConDelivery }

class SpecialistDetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final String userName;
  final String userEmail;
  final String phone;
  final String doctorId;
  final String email;
  final String specialization;
  final String category;
  final String status;
  final String payment;
  final String userIs;
  final String userId;
  final String profileUrl;

  const SpecialistDetailScreen({
    Key? key,
    required this.userId,
    required this.userName,
    required this.image,
    required this.name,
    required this.doctorId,
    required this.specialization,
    required this.category,
    required this.phone,
    required this.userEmail,
    required this.email,
    required this.status,
    required this.payment,
    required this.userIs,
    required this.profileUrl,
  }) : super(key: key);

  @override
  _SpecialistDetailScreenState createState() => _SpecialistDetailScreenState();
}

class _SpecialistDetailScreenState extends State<SpecialistDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  late var chatDao;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  Future<void> _set() async {
    chatDao = ChatDao(user.uid);
  }

  final TextEditingController _cardUserControler = TextEditingController();
  final TextEditingController _cardNumberControler = TextEditingController();
  final TextEditingController _cardCVCControler = TextEditingController();
  final TextEditingController _cardDateControler = TextEditingController();
  MethodsHandler _methodsHandler = MethodsHandler();
  List<Map<String, dynamic>> _reports = [];
  PaymentType _site = PaymentType.ConDelivery;
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
    _getUser();
    _set();
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
        .where('uid', isEqualTo: _auth.currentUser!.uid.toString())
        .get()
        .then((value) {
      setState(() {
        childName = value.docs[0]['childName'];
        gender = value.docs[0]['gender'];
        age = value.docs[0]['childAge'];
        childImage = value.docs[0]['childImage'];
      });
    });

    FirebaseFirestore.instance
        .collection('Reports')
        .where('uid', isEqualTo: _auth.currentUser!.uid.toString())
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (int i = 0; i < value.docs.length; i++) {
          setState(() {
            _reports.add({
              'uid': value.docs[i]['uid'].toString(),
              'advice': value.docs[i]['advice'].toString(),
              'case': value.docs[i]['case'].toString(),
              'childAge': value.docs[i]['childAge'].toString(),
              'childName': value.docs[i]['childName'].toString(),
              'childImage': value.docs[i]['childImage'].toString(),
              'childGender': value.docs[i]['childGender'].toString(),
              'score': value.docs[i]['score'],
              'date': value.docs[i]['date'].toString(),
              'type': value.docs[i]['type'].toString(),
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return widget.userIs == 'Clinic'
        ? Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white, size: 25),
              automaticallyImplyLeading: true,
              elevation: 0,
              backgroundColor: darkBlueColor,
              title: Text(
                'Konsultasi',
                style: GoogleFonts.nunito(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
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
                              widget.image.toString(),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Text(
                              widget.email,
                              style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                            Text(
                              widget.phone,
                              style: GoogleFonts.nunito(
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          offset: const Offset(6, 6),
                          blurRadius: 8,
                        ),
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: const Offset(4, 4),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          widget.status != "view"
                              ? SizedBox()
                              : Column(
                                  children: [
                                    Container(
                                      height: size.height * 0.055,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Patient Name ',
                                              style: GoogleFonts.nunito(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              widget.userName.toString(),
                                              style: GoogleFonts.nunito(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: size.height * 0.055,
                                      // color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Patient Email ',
                                              style: GoogleFonts.nunito(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              widget.userEmail.toString(),
                                              style: GoogleFonts.nunito(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          widget.status == "view"
                              ? SizedBox()
                              : Column(
                                  children: [
                                    Container(
                                      width: size.width * .9,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    SizedBox(
                                      height: size.height * .01,
                                    ),
                                    Container(
                                      width: size.width * .9,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: size.width * .9,
                                            child: Text(
                                              'Janji Tanggal dan Waktu',
                                              style: GoogleFonts.nunito(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();

                                              showCupertinoModalPopup(
                                                  context: context,
                                                  builder: (_) => Container(
                                                        height: 500,
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 255, 255, 255),
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 400,
                                                              child:
                                                                  CupertinoDatePicker(
                                                                      mode: CupertinoDatePickerMode
                                                                          .dateAndTime,
                                                                      use24hFormat:
                                                                          true,
                                                                      minimumDate: DateTime
                                                                              .now()
                                                                          .subtract(Duration(
                                                                              days:
                                                                                  1)),
                                                                      initialDateTime:
                                                                          DateTime
                                                                              .now(),
                                                                      onDateTimeChanged:
                                                                          (val) {
                                                                        Duration
                                                                            diff =
                                                                            val.difference(DateTime.now());
                                                                        //DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");

                                                                        setState(
                                                                            () {
                                                                          _chosenDateTime =
                                                                              val;
                                                                          String
                                                                              string1 =
                                                                              DateFormat().add_yMMMd().format(val);
                                                                          String
                                                                              time3 =
                                                                              DateFormat().add_jm().format(val);

                                                                          endTime = string1.toString() +
                                                                              ' at ' +
                                                                              time3.toString();
                                                                        });
                                                                        prefs.setString(
                                                                            'selectedMorningTime',
                                                                            endTime.toString());
                                                                      }),
                                                            ),

                                                            // Close the modal
                                                            CupertinoButton(
                                                              child: const Text(
                                                                  'OK'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context,
                                                                        rootNavigator:
                                                                            true)
                                                                    .pop();
                                                                //  _zonedScheduleNotification(selectedSeconds, morningH,morningM,'morning');
                                                                //}
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                      ));
                                            },
                                            child: Container(
                                              width: size.width * 0.9,
                                              height: size.height * 0.05,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  endTime.toString() == ''
                                                      ? 'Pick Date & Time'
                                                      : endTime.toString(),
                                                  //time.toString(),
                                                  //' 07 : 10 ',
                                                  style: GoogleFonts.nunito(
                                                      color: endTime == ''
                                                          ? Colors.grey
                                                              .withOpacity(0.5)
                                                          : Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.04,
                                    ),
                                    _isLoading
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : SizedBox(
                                            height: size.height * 0.06,
                                            width: size.width * 0.9,
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  getRenter();
                                                  print(_site.toString());
                                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SingnIn()));
                                                  if (isSelected == '') {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Select Doctor')));
                                                  } else if (endTime
                                                          .toString() ==
                                                      '') {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Pilih Tanggal & Waktu.')));
                                                  } else if (_chosenDateTime!
                                                      .isBefore(
                                                          DateTime.now())) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Sorry Date is in past')));
                                                  } else {
                                                    if (_site.toString() ==
                                                        'PaymentType.Credit_Debit') {
                                                      if (_cardUserControler
                                                          .text.isEmpty) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Enter Card User Name')));
                                                      } else if (_cardNumberControler
                                                          .text.isEmpty) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Enter Card Number')));
                                                      } else if (_cardDateControler
                                                          .text.isEmpty) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Enter Card Date')));
                                                      } else if (_cardCVCControler
                                                          .text.isEmpty) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Enter Card CVV')));
                                                      } else {
                                                        setState(() {
                                                          _isLoading = true;
                                                        });
                                                        print(
                                                            'we are in BookingVehicle');
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Appointments')
                                                            .doc()
                                                            .set({
                                                          "clinicName":
                                                              widget.name,
                                                          "clinicEmail":
                                                              widget.email,
                                                          "clinicPhone":
                                                              widget.phone,
                                                          "clinicUid":
                                                              widget.doctorId,
                                                          "doctorName":
                                                              selectedDoctorName,
                                                          "doctorEmail":
                                                              selectedDoctorEmail,
                                                          "doctorId":
                                                              selectedDoctorUid,
                                                          "doctorImage":
                                                              selectedDoctorImage,
                                                          "doctorPhone":
                                                              selectedDoctorPhone,
                                                          "doctorSpec":
                                                              selectedDoctorSpec,
                                                          "doctorCategory":
                                                              selectedDoctorCategory,
                                                          "bookingStatus":
                                                              "Pending",
                                                          "bookingTime":
                                                              DateTime.now()
                                                                  .toString(),
                                                          "appointmentTime":
                                                              endTime
                                                                  .toString(),
                                                          "userEmail":
                                                              renterEmail,
                                                          "evaluation": 0,
                                                          "userName":
                                                              renterName,
                                                          "userId": _auth
                                                              .currentUser!.uid
                                                              .toString(),
                                                          "paymentMethod": _site
                                                                      .toString() ==
                                                                  'PaymentType.Credit_Debit'
                                                              ? 'Credit/Debit Card'
                                                              : 'Cash',
                                                          "paymentPaid": _site
                                                                      .toString() ==
                                                                  'PaymentType.Credit_Debit'
                                                              ? 'yes'
                                                              : 'no',
                                                          "cardHolderName":
                                                              _cardUserControler
                                                                  .text,
                                                          "cardDate":
                                                              _cardDateControler
                                                                  .text,
                                                          "cardCVC":
                                                              _cardCVCControler
                                                                  .text,
                                                          "cardHolderCardNumber":
                                                              _cardNumberControler
                                                                  .text,
                                                        }).then((value) {
                                                          setState(() {
                                                            _isLoading = false;
                                                          });
                                                          // Navigator.pop(context)

                                                          // Navigator.of(context).pop();
                                                          // Navigator.pushReplacement(
                                                          //   context,
                                                          //   PageRouteBuilder(
                                                          //     pageBuilder: (c, a1, a2) => AppBottomNavBarScreen(index: 1, title: "", subTitle:""),
                                                          //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                          //     transitionDuration: Duration(milliseconds: 100),
                                                          //   ),
                                                          // );
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                "Successfully Booked",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                4,
                                                          );
                                                        });
                                                      }
                                                    } else {
                                                      setState(() {
                                                        _isLoading = true;
                                                      });
                                                      print(
                                                          'we are in BookingVehicle');
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'Appointments')
                                                          .doc()
                                                          .set({
                                                        "clinicName":
                                                            widget.name,
                                                        "clinicEmail":
                                                            widget.email,
                                                        "clinicPhone":
                                                            widget.phone,
                                                        "clinicUid":
                                                            widget.doctorId,
                                                        "doctorId":
                                                            selectedDoctorUid,
                                                        "doctorName":
                                                            selectedDoctorName,
                                                        "doctorEmail":
                                                            selectedDoctorEmail,
                                                        "doctorImage":
                                                            selectedDoctorImage,
                                                        "doctorPhone":
                                                            selectedDoctorPhone,
                                                        "doctorSpec":
                                                            selectedDoctorSpec,
                                                        "doctorCategory":
                                                            selectedDoctorCategory,
                                                        "bookingStatus":
                                                            "Pending",
                                                        "evaluation": 0,
                                                        "bookingTime":
                                                            DateTime.now()
                                                                .toString(),
                                                        "appointmentTime":
                                                            endTime.toString(),
                                                        "userEmail":
                                                            renterEmail,
                                                        "userName": renterName,
                                                        "userId": _auth
                                                            .currentUser!.uid
                                                            .toString(),
                                                        "paymentMethod": _site
                                                                    .toString() ==
                                                                'PaymentType.Credit_Debit'
                                                            ? 'Credit/Debit Card'
                                                            : 'Cash',
                                                        "paymentPaid": _site
                                                                    .toString() ==
                                                                'PaymentType.Credit_Debit'
                                                            ? 'yes'
                                                            : 'no',
                                                        "cardHolderName":
                                                            _cardUserControler
                                                                .text,
                                                        "cardDate":
                                                            _cardDateControler
                                                                .text,
                                                        "cardCVC":
                                                            _cardCVCControler
                                                                .text,
                                                        "cardHolderCardNumber":
                                                            _cardNumberControler
                                                                .text,
                                                      }).then((value) {
                                                        setState(() {
                                                          _isLoading = false;
                                                        });
                                                        // Navigator.pop(context)

                                                        // Navigator.of(context).pop();
                                                        // Navigator.push(
                                                        //   context,
                                                        //   PageRouteBuilder(
                                                        //     pageBuilder: (c, a1, a2) => AppBottomNavBarScreen(index: 0, title: "", subTitle:""),
                                                        //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                        //     transitionDuration: Duration(milliseconds: 100),
                                                        //   ),
                                                        // );
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              "Successfully Booked",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 4,
                                                        );
                                                      });
                                                    }
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: darkBlueColor,
                                                  shadowColor:
                                                      Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                ),
                                                child: Text("Book",
                                                    style: subtitleWhite)),
                                          ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white, size: 25),
              automaticallyImplyLeading: true,
              elevation: 0,
              backgroundColor: darkBlueColor,
              title: Text(
                'Konsultasi',
                style: GoogleFonts.nunito(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(20.0)),
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
                            padding: const EdgeInsets.all(20.0),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                widget.image.toString(),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(
                                widget.email,
                                style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              ),
                              Text(
                                widget.phone,
                                style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.all(5.0)),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: greenColor),
                                      child: const FaIcon(
                                          FontAwesomeIcons.message),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatRoom(
                                                user2Id: widget.userId,
                                                user2Name: widget.name,
                                                profileUrl: widget.image,
                                              ),
                                            ));
                                      },
                                    ),
                                  ),
                                  Text(
                                    "Chat",
                                    style: GoogleFonts.nunito(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: size.width * .9,
                              decoration: BoxDecoration(
                                  color: greyColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      width: size.width * .9,
                                      child: Center(
                                        child: Text(
                                          'Kalender',
                                          style: GoogleFonts.nunito(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (_) => Container(
                                                height: 500,
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 400,
                                                      child:
                                                          CupertinoDatePicker(
                                                              mode: CupertinoDatePickerMode
                                                                  .dateAndTime,
                                                              use24hFormat:
                                                                  true,
                                                              minimumDate: DateTime
                                                                      .now()
                                                                  .subtract(
                                                                      Duration(
                                                                          days:
                                                                              1)),
                                                              initialDateTime:
                                                                  DateTime
                                                                      .now(),
                                                              onDateTimeChanged:
                                                                  (val) {
                                                                Duration diff =
                                                                    val.difference(
                                                                        DateTime
                                                                            .now());
                                                                //DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");

                                                                setState(() {
                                                                  _chosenDateTime =
                                                                      val;
                                                                  String
                                                                      string1 =
                                                                      DateFormat()
                                                                          .add_yMMMd()
                                                                          .format(
                                                                              val);
                                                                  String time3 =
                                                                      DateFormat()
                                                                          .add_jm()
                                                                          .format(
                                                                              val);

                                                                  endTime = string1
                                                                          .toString() +
                                                                      ' at ' +
                                                                      time3
                                                                          .toString();
                                                                });
                                                                prefs.setString(
                                                                    'selectedMorningTime',
                                                                    endTime
                                                                        .toString());
                                                              }),
                                                    ),

                                                    // Close the modal
                                                    CupertinoButton(
                                                      child: const Text('OK'),
                                                      onPressed: () {
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .pop();
                                                        //  _zonedScheduleNotification(selectedSeconds, morningH,morningM,'morning');
                                                        //}
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ));
                                    },
                                    child: Container(
                                      width: size.width * 0.9,
                                      height: size.height * 0.05,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        //  color: greyColor.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          endTime.toString() == ''
                                              ? 'Pilih Tanggal dan Jam'
                                              : endTime.toString(),
                                          style: GoogleFonts.nunito(
                                              color: endTime == ''
                                                  ? Colors.grey.withOpacity(0.5)
                                                  : Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            SizedBox(
                              height: size.height * 0.06,
                              width: size.width * 0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: size.height * 0.06,
                                    width: size.width * 0.3,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          if (showReport == '') {
                                            setState(() {
                                              showReport = 'show';
                                            });
                                          } else {
                                            setState(() {
                                              showReport = '';
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: darkBlueColor,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                        ),
                                        child: FaIcon(FontAwesomeIcons.add)),
                                  ),
                                ],
                              ),
                            ),
                            showReport == ''
                                ? SizedBox()
                                : Container(
                                    width: size.width * 0.95,
                                    height: size.height * 0.2,
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('Reports')
                                          .where('uid',
                                              isEqualTo: _auth.currentUser!.uid
                                                  .toString())
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                              child: CircularProgressIndicator(
                                            strokeWidth: 1,
                                            color: darkBlueColor,
                                          ));
                                        } else if (snapshot.hasData &&
                                            snapshot.data!.docs.isEmpty) {
                                          // got data from snapshot but it is empty

                                          return Center(
                                              child: Text("Tidak Ada Data"));
                                        } else {
                                          return Center(
                                            child: Container(
                                              width: size.width * 0.95,
                                              child: ListView.builder(
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder: (context, index) {
                                                  DocumentSnapshot ds = snapshot
                                                      .data!.docs[index];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        PageRouteBuilder(
                                                          pageBuilder: (c, a1,
                                                                  a2) =>
                                                              ReportDetailScreen(
                                                            childName: snapshot
                                                                .data!
                                                                .docs[index][
                                                                    "childName"]
                                                                .toString(),
                                                            childAge: snapshot
                                                                .data!
                                                                .docs[index]
                                                                    ["age"]
                                                                .toString(),
                                                            childGender: snapshot
                                                                .data!
                                                                .docs[index]
                                                                    ["gender"]
                                                                .toString(),
                                                            childCase: snapshot
                                                                .data!
                                                                .docs[index]
                                                                    ["case"]
                                                                .toString(),
                                                            childAdvice: snapshot
                                                                .data!
                                                                .docs[index]
                                                                    ["advice"]
                                                                .toString(),
                                                            date: snapshot
                                                                .data!
                                                                .docs[index]
                                                                    ["date"]
                                                                .toString(),
                                                            total: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ["score"],
                                                          ),
                                                          transitionsBuilder: (c,
                                                                  anim,
                                                                  a2,
                                                                  child) =>
                                                              FadeTransition(
                                                                  opacity: anim,
                                                                  child: child),
                                                          transitionDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      100),
                                                        ),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8,
                                                              bottom: 8,
                                                              left: 0,
                                                              right: 0),
                                                      child: Container(
                                                        width:
                                                            size.width * 0.95,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 0.5,
                                                              color: blueColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3),
                                                          // gradient:  LinearGradient(
                                                          //   begin: Alignment.centerRight,
                                                          //   end: Alignment.centerLeft,
                                                          //   colors:
                                                          //
                                                          //   <Color>[Color((math.Random().nextDouble() * 0xFFFFFF).toInt()),Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5), ],
                                                          // ),

                                                          //whiteColor,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8,
                                                                  bottom: 8),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    // color: Colors.green,
                                                                  ),
                                                                  width:
                                                                      size.width *
                                                                          0.17,
                                                                  child: Image
                                                                      .network(
                                                                    snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                            [
                                                                            "childImage"]
                                                                        .toString(),
                                                                    fit: BoxFit
                                                                        .scaleDown,
                                                                    width: size
                                                                            .width *
                                                                        0.17,
                                                                    height: size
                                                                            .height *
                                                                        0.06,
                                                                  )),
                                                              Container(
                                                                //  color: redColor,
                                                                // width: size.width * 0.73,

                                                                child: Column(
                                                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Container(
                                                                          //  color: Colors.orange,
                                                                          width:
                                                                              size.width * 0.48,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                // color: Colors.yellow,
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  snapshot.data!.docs[index]["childName"].toString() + " (" + snapshot.data!.docs[index]["type"].toString() + " Report) ",
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: GoogleFonts.nunito(color: secondaryColor1, fontSize: 13, fontWeight: FontWeight.w800, height: 1.3),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                // color: Colors.yellow,
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  snapshot.data!.docs[index]["date"].toString(),
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: GoogleFonts.nunito(color: secondaryColor1, fontSize: 12, fontWeight: FontWeight.w400, height: 1.3),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            if (selectedIndex ==
                                                                                "") {
                                                                              setState(() {
                                                                                selectedIndex = index.toString();
                                                                                age = snapshot.data!.docs[index]["age"].toString();
                                                                                childAdvice = snapshot.data!.docs[index]["advice"].toString();
                                                                                childCase = snapshot.data!.docs[index]["case"].toString();
                                                                                childName = snapshot.data!.docs[index]["childName"].toString();
                                                                                childImage = snapshot.data!.docs[index]["childImage"].toString();
                                                                                date = snapshot.data!.docs[index]["date"].toString();
                                                                                score = snapshot.data!.docs[index]["score"];
                                                                                gender = snapshot.data!.docs[index]["gender"].toString();
                                                                              });
                                                                            } else {
                                                                              setState(() {
                                                                                selectedIndex = "";
                                                                              });
                                                                            }

                                                                            // Navigator.push(
                                                                            //   context,
                                                                            //   PageRouteBuilder(
                                                                            //     pageBuilder: (c, a1, a2) => ReportDetailScreen(
                                                                            //       childName: snapshot.data!.docs[index]["childName"].toString(),
                                                                            //       childAge: snapshot.data!.docs[index]["age"].toString(),
                                                                            //       childGender: snapshot.data!.docs[index]["gender"].toString(),
                                                                            //       childCase: snapshot.data!.docs[index]["case"].toString(),
                                                                            //       childAdvice: snapshot.data!.docs[index]["advice"].toString(),
                                                                            //       date: snapshot.data!.docs[index]["date"].toString(),
                                                                            //       total: snapshot.data!.docs[index]["score"],
                                                                            //     ),
                                                                            //     transitionsBuilder: (c, anim, a2, child) =>
                                                                            //         FadeTransition(opacity: anim, child: child),
                                                                            //     transitionDuration: Duration(milliseconds: 100),
                                                                            //   ),
                                                                            // );
                                                                          },
                                                                          child: Container(
                                                                              height: size.height * 0.045,
                                                                              width: size.width * 0.25,
                                                                              decoration: BoxDecoration(color: selectedIndex == index.toString() ? Colors.green : buttonColor, borderRadius: BorderRadius.circular(10)),
                                                                              child: Center(
                                                                                child: selectedIndex == index.toString()
                                                                                    ? Icon(
                                                                                        Icons.check,
                                                                                        color: Colors.white,
                                                                                      )
                                                                                    : Text(
                                                                                        "Select",
                                                                                        style: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white),
                                                                                      ),
                                                                              )),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                //Container(child: Text('AdminHome'),),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            _isLoading
                                ? Center(child: CircularProgressIndicator())
                                : SizedBox(
                                    height: size.height * 0.06,
                                    width: size.width * 0.9,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            getRenter();
                                            print(_site.toString());
                                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SingnIn()));

                                            if (selectedIndex.toString() ==
                                                '') {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Harus dipilih laporan dulu')));
                                            } else if (endTime.toString() ==
                                                '') {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Pilih Jam dan Tanggal')));
                                            } else if (_chosenDateTime!
                                                .isBefore(DateTime.now())) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Sorry Date is in past')));
                                            } else {
                                              if (_site.toString() ==
                                                  'PaymentType.Credit_Debit') {
                                                if (_cardUserControler
                                                    .text.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Enter Card User Name')));
                                                } else if (_cardNumberControler
                                                    .text.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Enter Card Number')));
                                                } else if (_cardDateControler
                                                    .text.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Enter Card Date')));
                                                } else if (_cardCVCControler
                                                    .text.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Enter Card CVV')));
                                                } else {
                                                  setState(() {
                                                    _isLoading = true;
                                                  });
                                                  print(
                                                      'we are in BookingVehicle');
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'Appointments')
                                                      .doc()
                                                      .set({
                                                    "doctorName":
                                                        widget.name.toString(),
                                                    "doctorId": widget.doctorId
                                                        .toString(),
                                                    "doctorImage":
                                                        widget.image.toString(),
                                                    "doctorPhone":
                                                        widget.phone.toString(),
                                                    "bookingStatus": "Pending",
                                                    "appointmentTime":
                                                        endTime.toString(),
                                                    "parentEmail": renterEmail,
                                                    "parentName": renterName,
                                                    "evaluation": 0,
                                                    "parentId": _auth
                                                        .currentUser!.uid
                                                        .toString(),
                                                    "paymentMethod": _site
                                                                .toString() ==
                                                            'PaymentType.Credit_Debit'
                                                        ? 'Credit/Debit Card'
                                                        : 'Cash',
                                                    "paymentPaid": _site
                                                                .toString() ==
                                                            'PaymentType.Credit_Debit'
                                                        ? 'yes'
                                                        : 'no',
                                                    "cardHolderName":
                                                        _cardUserControler.text,
                                                    "cardDate":
                                                        _cardDateControler.text,
                                                    "cardCVC":
                                                        _cardCVCControler.text,
                                                    "cardHolderCardNumber":
                                                        _cardNumberControler
                                                            .text,
                                                    "date": date,
                                                    "childName": childName,
                                                    "childImage": childImage,
                                                    "gender": gender,
                                                    "age": age,
                                                    "case": childCase,
                                                    "advice": childAdvice,
                                                    "score": score,
                                                  }).then((value) {
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                    Navigator.pop(context);

                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "Successfully Booked",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 4,
                                                    );
                                                  });
                                                }
                                              } else {
                                                setState(() {
                                                  _isLoading = true;
                                                });
                                                print(
                                                    'we are in BookingVehicle');
                                                FirebaseFirestore.instance
                                                    .collection('Bookings')
                                                    .doc()
                                                    .set({
                                                  "doctorName":
                                                      widget.name.toString(),
                                                  "doctorId": widget.doctorId
                                                      .toString(),
                                                  "doctorImage":
                                                      widget.image.toString(),
                                                  "doctorPhone":
                                                      widget.phone.toString(),
                                                  "bookingStatus": "Pending",
                                                  "appointmentTime":
                                                      endTime.toString(),
                                                  "parentEmail": renterEmail,
                                                  "parentName": renterName,
                                                  "evaluation": 0,
                                                  "parentId": _auth
                                                      .currentUser!.uid
                                                      .toString(),
                                                  "paymentMethod": _site
                                                              .toString() ==
                                                          'PaymentType.Credit_Debit'
                                                      ? 'Credit/Debit Card'
                                                      : 'Cash',
                                                  "paymentPaid": _site
                                                              .toString() ==
                                                          'PaymentType.Credit_Debit'
                                                      ? 'yes'
                                                      : 'no',
                                                  "cardHolderName":
                                                      _cardUserControler.text,
                                                  "cardDate":
                                                      _cardDateControler.text,
                                                  "cardCVC":
                                                      _cardCVCControler.text,
                                                  "cardHolderCardNumber":
                                                      _cardNumberControler.text,
                                                  "date": date,
                                                  "childName": childName,
                                                  "childImage": childImage,
                                                  "gender": gender,
                                                  "age": age,
                                                  "case": childCase,
                                                  "advice": childAdvice,
                                                  "score": score,
                                                }).then((value) {
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                  // Navigator.pop(context)

                                                  Navigator.of(context).pop();
                                                  // Navigator.push(
                                                  //   context,
                                                  //   PageRouteBuilder(
                                                  //     pageBuilder: (c, a1, a2) => AppBottomNavBarScreen(index: 0, title: "", subTitle:""),
                                                  //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                  //     transitionDuration: Duration(milliseconds: 100),
                                                  //   ),
                                                  // );
                                                  Fluttertoast.showToast(
                                                    msg: "Successfully Booked",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 4,
                                                  );
                                                });
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: greenColor,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                          ),
                                          child: Text("Buat Janji",
                                              style: subtitleWhite)),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
