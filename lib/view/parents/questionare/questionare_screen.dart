import 'dart:convert';

import 'package:autism_perdiction_app/constants.dart';
import 'package:autism_perdiction_app/model/questionare_model.dart';
import 'package:autism_perdiction_app/theme.dart';
import 'package:autism_perdiction_app/view/parents/bottomNavBar/app_bottom_nav_bar_screen.dart';
import 'package:autism_perdiction_app/view/specialists/doctor_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuestionareScreen extends StatefulWidget {
  final int number;
  final String type;
  const QuestionareScreen(
      {super.key, required this.number, required this.type});

  @override
  State<QuestionareScreen> createState() => _QuestionareScreenState();
}

class _QuestionareScreenState extends State<QuestionareScreen> {
  String selected = '', selectedIndex = '', showResult = '', childImage = '';
  int total = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;

  QuestionareModel? _question;

  getQuestion() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore.instance
        .collection(widget.type == 'MChat' ? 'MChat' : 'SCQ')
        .where('id', isEqualTo: widget.number.toString())
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        for (int i = 1; i <= 10; i++) {
          FirebaseFirestore.instance
              .collection(widget.type == 'MChat' ? 'MChatData' : 'SCQData')
              .doc(_auth.currentUser!.uid + i.toString())
              .get()
              .then((value) {
            if (value.exists) {
              print(value['answer'].toString() + ' answer');
              setState(() {
                total = total + int.parse(value['answer'].toString());
              });
            } else {
              print('Sorry Not document exists ');
            }

            if (i == 10) {
              setState(() {
                showResult = 'yes';
              });
            }
          });
        }
      } else {
        print(value.docs[0].data().toString());
        // var data = JsonEncoder(value.docs[0].data());
        setState(() {
          _question = QuestionareModel.fromJson(value.docs[0].data());
        });

        print(_question!.id.toString());
        print(_question!.question.toString());
        print(_question!.answer.toString());
        print(_question!.options![0].toString());
        print(_question!.options![1].toString());
      }

      // setState(() {
      //   name = value.docs[0]['name'];
      //   email = value.docs[0]['email'];
      // });
    });
  }

  String name = '', email = '', uid = '', childName = '', age = '', gender = '';
  String text = '';
  int current = 0;

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
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    getQuestion();
    setState(() {
      selected = '';
      selectedIndex = '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getData();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        // New parameter:
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: darkBlueColor),
        title: showResult == 'yes' && _question == null
            ? Text(
                'Report',
                style: GoogleFonts.nunito(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.scaleDown,
                        height: 200,
                        width: 200,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
        centerTitle: true,
      ),
      body: showResult == 'yes' && _question == null
          ? Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      // borderRadius: BorderRadius.circular(5)

                      ),
                  width: size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.scaleDown,
                        height: 100,
                        width: 300,
                      ),
                    ),
                    
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  width: size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        width: size.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Nama Anak : ',
                            style: GoogleFonts.nunito(
                                color: darkBlueColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.58,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            childName,
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  width: size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        width: size.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Umur :',
                            style: GoogleFonts.nunito(
                                color: darkBlueColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.58,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          //border: Border.all(color: darkBlueColor,width: 0.5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            age.toString() + ' tahun',
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  width: size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        width: size.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Hasil : ',
                            style: GoogleFonts.nunito(
                                color: darkBlueColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.58,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            total.toString() + ' / 10',
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  width: size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        width: size.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Prediksi :',
                            style: GoogleFonts.nunito(
                                color: darkBlueColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.58,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            total <= 4
                                ? 'Hasil ini menunjukkan risiko rendah autisme, tidak perlu membawa anak Anda ke dokter'
                                : total > 4 && total <= 6
                                    ? 'Hasil ini menunjukkan risiko autisme sedang, Anda diharuskan membawa anak Anda ke dokter untuk pemeriksaan lanjutan. Anda juga dapat mencari layanan intervensi dini untuk anak Anda di Aplikasi Akson.'
                                    : total > 6
                                        ? 'Hasil ini menunjukkan risiko tinggi autisme, Anda wajib membawa anak Anda ke dokter untuk pemeriksaan lanjutan. Anda juga dapat mencari layanan intervensi dini untuk anak Anda di Aplikasi Akson'
                                        : 'Kalkulasi Autisme',
                            style: GoogleFonts.nunito(
                                color: total <= 4
                                    ? Colors.green
                                    : total > 4 && total <= 6
                                        ? Colors.blue
                                        : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                new CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 10.0,
                  percent: total / 10,
                  center: new Text('${(total / 10) * 100}' + '\%'),
                  progressColor: total <= 4
                      ? Colors.green
                      : total > 4 && total <= 6
                          ? Color.fromARGB(255, 30, 18, 160)
                          : total > 6
                              ? Colors.red
                              : darkBlueColor,
                ),
                SizedBox(
                  height: size.height * 0.05,
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
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        colors: [
                          darkBlueColor,
                          darkBlueColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          minimumSize:
                              MaterialStateProperty.all(Size(size.width, 50)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          // elevation: MaterialStateProperty.all(3),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('Reports')
                              .doc()
                              .set({
                            'uid': _auth.currentUser!.uid.toString(),
                            'parentName': name.toString(),
                            'type': widget.type == 'MChat' ? 'MChat' : 'SCQ',
                            'date': DateFormat.yMMMEd()
                                    .format(DateTime.now())
                                    .toString() +
                                ' ' +
                                DateFormat.jm()
                                    .format(DateTime.now())
                                    .toString(),
                            'childName': childName,
                            'childImage': childImage,
                            'age': age,
                            'gender': gender,
                            'score': total,
                            'advice': total <= 4
                                ? 'Low risk don\'t need to take your child to doctor'
                                : total > 4 && total <= 9
                                    ? 'You should take your child to his/her doctor to follow up screening.You can also seek early intervention services for your child.'
                                    : total == 10
                                        ? 'You must have to take your child to his/her doctor to follow up screening.You can also seek early intervention services for your child.'
                                        : 'Calculation Autism',
                            'case': total <= 4
                                ? 'This score indicates Low risk of autism'
                                : total > 4 && total <= 6
                                    ? 'This score indicates Medium risk of autism'
                                    : total > 6
                                        ? 'This score indicates High risk of autism'
                                        : 'Calculation Autism',
                          }).then((value) {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (c, a1, a2) => SpecialistScreen(),
                                transitionsBuilder: (c, anim, a2, child) =>
                                    FadeTransition(opacity: anim, child: child),
                                transitionDuration: Duration(milliseconds: 100),
                              ),
                            );
                          });
                        },
                        child: Text('Tanyakan ke Dokter Akson',
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16))),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.025,
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
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        colors: [
                          darkBlueColor,
                          darkBlueColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    
                  ),
                ),
              ],
            )
          : _question == null && showResult == ''
              ? Center(
                  child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Colors.green,
                ))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 5.0)
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Center(
                          child: Container(
                            child: Text(
                              " Pertanyaan dari " +
                                  widget.number.toString() +
                                  '/10',
                              style: GoogleFonts.notoSans(
                                  color: darkBlueColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 50,
                            animation: true,
                            lineHeight: 20.0,
                            // animationDuration: 2500,
                            percent: widget.number / 10,
                            // center: Text("80.0%"),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.green,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Center(
                          child: Container(
                            width: size.width * 0.9,
                            child: Text(
                              _question!.question.toString(),
                              style: GoogleFonts.nunito(
                                  color: darkBlueColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Center(
                          child: Container(
                            width: size.width * 0.95,
                            child: ListView.builder(
                              itemCount: _question!.options!.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected =
                                          _question!.options![index].toString();
                                      selectedIndex = index.toString();
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: selectedIndex == index.toString()
                                            ? Colors.green
                                            : Color.fromARGB(
                                                255, 219, 219, 219),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Row(
                                        children: [
                                          Radio(
                                            activeColor: Colors.white,
                                            value: selectedIndex ==
                                                    index.toString()
                                                ? false
                                                : true,
                                            groupValue: false,
                                            onChanged: (value) {
                                              // setState(() {
                                              //   _site = value!;
                                              // });
                                              // print(_site.toString());
                                            },
                                          ),
                                          Container(
                                            width: size.width * 0.7,
                                            child: Text(
                                              _question!.options![index]
                                                  .toString(),
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.nunito(
                                                  fontSize: 15,
                                                  color: selectedIndex ==
                                                          index.toString()
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              //Container(child: Text('AdminHome'),),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Container(
                          width: size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: size.width * 0.35,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(0, 4),
                                        blurRadius: 5.0)
                                  ],
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops: [0.0, 1.0],
                                    colors: [
                                      greyColor,
                                      greyColor,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(30)),
                                ),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                      ),
                                      minimumSize: MaterialStateProperty.all(
                                          Size(size.width, 50)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      // elevation: MaterialStateProperty.all(3),
                                      shadowColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                    ),
                                    onPressed: () async {
                                      if (widget.number == 1) {
                                        Navigator.of(context).pop();
                                      } else {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (c, a1, a2) =>
                                                QuestionareScreen(
                                              number: widget.number - 1,
                                              type: widget.type,
                                            ),
                                            transitionsBuilder:
                                                (c, anim, a2, child) =>
                                                    FadeTransition(
                                                        opacity: anim,
                                                        child: child),
                                            transitionDuration:
                                                Duration(milliseconds: 100),
                                          ),
                                        );
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_back,
                                          color:
                                              Color.fromARGB(255, 73, 73, 73),
                                        ),
                                        Spacer(),
                                        Text('Kembali',
                                            style: GoogleFonts.nunito(
                                                color: Color.fromARGB(
                                                    255, 73, 73, 73),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        Spacer(),
                                      ],
                                    )),
                              ),
                              isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.red,
                                      strokeWidth: 1,
                                    ))
                                  : Container(
                                      width: size.width * 0.35,
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
                                            greenColor,
                                            greenColor,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30)),
                                      ),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
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
                                            if (selected == '') {
                                              var snackBar = SnackBar(
                                                content: Text(
                                                  'Jawaban harus diisi',
                                                  style: GoogleFonts.nunito(
                                                      color: Colors.white),
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
                                                  .collection(
                                                      widget.type == 'MChat'
                                                          ? 'MChatData'
                                                          : 'SCQData')
                                                  .doc(_auth.currentUser!.uid +
                                                      widget.number.toString())
                                                  .set({
                                                'uid': _auth.currentUser!.uid,
                                                'type': widget.type == 'MChat'
                                                    ? 'MChat'
                                                    : 'SCQ',
                                                'id': widget.number.toString(),
                                                'answer': selected.toString() ==
                                                        _question!.answer
                                                            .toString()
                                                    ? 1
                                                    : 0,
                                              }).then((value) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                Navigator.pop(context);

                                                Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (c, a1, a2) =>
                                                        QuestionareScreen(
                                                      number: widget.number + 1,
                                                      type: widget.type,
                                                    ),
                                                    transitionsBuilder:
                                                        (c, anim, a2, child) =>
                                                            FadeTransition(
                                                                opacity: anim,
                                                                child: child),
                                                    transitionDuration:
                                                        Duration(
                                                            milliseconds: 100),
                                                  ),
                                                );

                                                print('name updated');
                                              });
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Spacer(),
                                              Text('Lanjut',
                                                  style: GoogleFonts.nunito(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16)),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                              ),
                                              Spacer(),
                                            ],
                                          )),
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
