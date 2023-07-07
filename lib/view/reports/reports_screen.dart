import 'package:aksonhealth/constants.dart';
import 'package:aksonhealth/view/reports/report_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
          'Laporan',
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Reports')
            .where('uid', isEqualTo: _auth.currentUser!.uid.toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              strokeWidth: 1,
              color: primaryColor,
            ));
          } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            // got data from snapshot but it is empty

            return Center(child: Text("No Data Found"));
          } else {
            return Center(
              child: Container(
                width: size.width * 0.95,
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => ReportDetailScreen(
                              childName: snapshot.data!.docs[index]["childName"]
                                  .toString(),
                              childAge:
                                  snapshot.data!.docs[index]["age"].toString(),
                              childGender: snapshot.data!.docs[index]["gender"]
                                  .toString(),
                              childCase:
                                  snapshot.data!.docs[index]["case"].toString(),
                              childAdvice: snapshot.data!.docs[index]["advice"]
                                  .toString(),
                              date:
                                  snapshot.data!.docs[index]["date"].toString(),
                              total: snapshot.data!.docs[index]["score"],
                            ),
                            transitionsBuilder: (c, anim, a2, child) =>
                                FadeTransition(opacity: anim, child: child),
                            transitionDuration: Duration(milliseconds: 100),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 0, right: 0),
                        child: Container(
                          width: size.width * 0.95,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 0.5, color: primaryColor1),
                            borderRadius: BorderRadius.circular(10),
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
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      // color: Colors.green,
                                    ),
                                    width: size.width * 0.17,
                                    child: Image.network(
                                      snapshot.data!.docs[index]["childImage"]
                                          .toString(),
                                      fit: BoxFit.scaleDown,
                                      width: size.width * 0.17,
                                      height: size.height * 0.06,
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
                                            width: size.width * 0.48,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // color: Colors.yellow,
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    snapshot
                                                            .data!
                                                            .docs[index]
                                                                ["childName"]
                                                            .toString() +
                                                        " (" +
                                                        snapshot.data!
                                                            .docs[index]["type"]
                                                            .toString() +
                                                        " Report) ",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: secondaryColor1,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        height: 1.3),
                                                  ),
                                                ),
                                                Container(
                                                  // color: Colors.yellow,
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    snapshot.data!
                                                        .docs[index]["date"]
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: secondaryColor1,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.3),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (c, a1, a2) =>
                                                      ReportDetailScreen(
                                                    childName: snapshot
                                                        .data!
                                                        .docs[index]
                                                            ["childName"]
                                                        .toString(),
                                                    childAge: snapshot.data!
                                                        .docs[index]["age"]
                                                        .toString(),
                                                    childGender: snapshot.data!
                                                        .docs[index]["gender"]
                                                        .toString(),
                                                    childCase: snapshot.data!
                                                        .docs[index]["case"]
                                                        .toString(),
                                                    childAdvice: snapshot.data!
                                                        .docs[index]["advice"]
                                                        .toString(),
                                                    date: snapshot.data!
                                                        .docs[index]["date"]
                                                        .toString(),
                                                    total: snapshot.data!
                                                        .docs[index]["score"],
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
                                            },
                                            child: Container(
                                                height: size.height * 0.045,
                                                width: size.width * 0.25,
                                                decoration: BoxDecoration(
                                                    color: buttonColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                  child: Text(
                                                    "Lihat",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
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
    );
  }
}
