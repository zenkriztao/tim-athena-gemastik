import 'package:aksonhealth/constants.dart';
import 'package:aksonhealth/model/firebase_auth.dart';
import 'package:aksonhealth/view/parents/bookingDetail/parent_booking_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentBookingScreen extends StatefulWidget {
  const ParentBookingScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ParentBookingScreenState createState() => _ParentBookingScreenState();
}

class _ParentBookingScreenState extends State<ParentBookingScreen> {
  MethodsHandler _methodsHandler = MethodsHandler();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? renterEmail = '', renterName = '', renterUid = '';
  getRenter() async {
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
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      renterName = '';
      renterEmail = '';
      renterUid = '';
    });
    getRenter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            iconTheme: IconThemeData(color: Colors.white),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            backgroundColor: appBarColor,
            bottom: TabBar(
              onTap: (index) {
                // Tab index when user select it, it start from zero
              },
              tabs: [
                Tab(
                  text: 'Baru',
                ),
                Tab(
                  text: 'Diterima',
                ),
                Tab(
                  text: 'Batalkan',
                ),
              ],
            ),
            centerTitle: true,
            title: Text('Janji temu'),
          ),
          body: TabBarView(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Bookings")
                    .where("parentId",
                        isEqualTo: _auth.currentUser!.uid.toString())
                    .where("bookingStatus", isEqualTo: "Pending")
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ParentBookingDetailScreen(
                                                childName: snapshot.data!
                                                    .docs[index]["childName"]
                                                    .toString(),
                                                childImage: snapshot.data!
                                                    .docs[index]["childImage"]
                                                    .toString(),
                                                age: snapshot
                                                    .data!.docs[index]["age"]
                                                    .toString(),
                                                childCase: snapshot
                                                    .data!.docs[index]["case"]
                                                    .toString(),
                                                advice: snapshot
                                                    .data!.docs[index]["advice"]
                                                    .toString(),
                                                parentName: snapshot.data!
                                                    .docs[index]["parentName"]
                                                    .toString(),
                                                parentEmail: snapshot.data!
                                                    .docs[index]["parentEmail"]
                                                    .toString(),
                                                parentUid: snapshot.data!
                                                    .docs[index]["parentId"]
                                                    .toString(),
                                                gender: snapshot
                                                    .data!.docs[index]["gender"]
                                                    .toString(),
                                                score: snapshot
                                                    .data!.docs[index]["score"],
                                                status: "view",
                                                payment: snapshot
                                                    .data!
                                                    .docs[index]
                                                        ["paymentMethod"]
                                                    .toString(),
                                                userIs: "Doctor",
                                                date: snapshot
                                                    .data!.docs[index]["date"]
                                                    .toString(),
                                                docId: snapshot
                                                    .data!.docs[index].id,
                                                evaluation: int.parse(snapshot
                                                    .data!
                                                    .docs[index]["evaluation"]
                                                    .toString()),
                                              )),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      width: size.width * 0.95,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: whiteColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // color: redColor,
                                            width: size.width * 0.25,
                                            height: size.height * 0.15,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                height: size.height * 0.25,
                                                width: size.width,
                                                fit: BoxFit.cover,
                                                imageUrl: snapshot.data!
                                                    .docs[index]["childImage"]
                                                    .toString(),
                                                placeholder: (context, url) =>
                                                    Container(
                                                        height: 50,
                                                        width: 50,
                                                        child: Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                          color:
                                                              lightButtonGreyColor,
                                                        ))),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            //   color: redColor,
                                            //width: size.width*0.5,
                                            width: size.width * 0.6,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, top: 8),
                                                    child: Text(
                                                      "Booking Id : #" +
                                                          "${index + 1}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          height: 1.3),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,

                                                  //  color: Colors.green,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8,
                                                    ),
                                                    child: Text(
                                                      "Clinic : " +
                                                          snapshot
                                                              .data!
                                                              .docs[index]
                                                                  ["doctorName"]
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.3),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8,
                                                    ),
                                                    child: Text(
                                                      "Appointment Date : " +
                                                          snapshot
                                                              .data!
                                                              .docs[index][
                                                                  "appointmentTime"]
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 1.3),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),

                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  width: size.width * 0.55,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.lightBlue,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .docs[index][
                                                                  "bookingStatus"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 1.3),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),

                                                // Container(
                                                //
                                                //   // width: size.width*0.55,
                                                //   child: Row(
                                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                //     children: [
                                                //       GestureDetector(
                                                //         onTap: () {
                                                //           // Navigator.push(
                                                //           //   context,
                                                //           //   PageRouteBuilder(
                                                //           //     pageBuilder: (c, a1, a2) => FeedbackReportScreen(title: 'Feedback',
                                                //           //       doctorId: snapshot.data!.docs[index]["clinicUid"].toString(),
                                                //           //       doctorName: snapshot.data!.docs[index]["clinicName"].toString(),
                                                //           //     ),
                                                //           //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                //           //     transitionDuration: Duration(milliseconds: 100),
                                                //           //   ),
                                                //           // );
                                                //         },
                                                //         child: Padding(
                                                //           padding: const EdgeInsets.only(left: 8),
                                                //           child: Container(
                                                //             decoration: BoxDecoration(
                                                //               borderRadius: BorderRadius.circular(10),
                                                //               color: primaryColor,
                                                //             ),
                                                //             width: size.width*0.25,
                                                //             alignment: Alignment.center,
                                                //             child: Padding(
                                                //               padding: const EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 8),
                                                //               child: Text(
                                                //                 "Feedback"
                                                //
                                                //                 , style: TextStyle(
                                                //                   color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //       GestureDetector(
                                                //         onTap: () {
                                                //           // Navigator.push(
                                                //           //   context,
                                                //           //   PageRouteBuilder(
                                                //           //     pageBuilder: (c, a1, a2) => FeedbackReportScreen(title: 'Report',
                                                //           //       doctorId: snapshot.data!.docs[index]["clinicUid"].toString(),
                                                //           //       doctorName: snapshot.data!.docs[index]["clinicName"].toString(),
                                                //           //     ),
                                                //           //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                //           //     transitionDuration: Duration(milliseconds: 100),
                                                //           //   ),
                                                //           // );
                                                //         },
                                                //         child: Padding(
                                                //           padding: const EdgeInsets.only(left: 0),
                                                //           child: Container(
                                                //             decoration: BoxDecoration(
                                                //               borderRadius: BorderRadius.circular(10),
                                                //               color: buttonColor,
                                                //             ),
                                                //             width: size.width*0.24,
                                                //             alignment: Alignment.center,
                                                //             child: Padding(
                                                //               padding: const EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 8),
                                                //               child: Text(
                                                //                 "Report"
                                                //
                                                //                 , style: TextStyle(
                                                //                   color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //
                                                //
                                                //     ],),
                                                // ),
                                                //
                                                // SizedBox(
                                                //   height: size.height*0.02,
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  }
                },
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Bookings")
                    .where("parentId",
                        isEqualTo: _auth.currentUser!.uid.toString())
                    .where("bookingStatus", isEqualTo: "Confirmed")
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ParentBookingDetailScreen(
                                                childName: snapshot.data!
                                                    .docs[index]["childName"]
                                                    .toString(),
                                                childImage: snapshot.data!
                                                    .docs[index]["childImage"]
                                                    .toString(),
                                                age: snapshot
                                                    .data!.docs[index]["age"]
                                                    .toString(),
                                                childCase: snapshot
                                                    .data!.docs[index]["case"]
                                                    .toString(),
                                                advice: snapshot
                                                    .data!.docs[index]["advice"]
                                                    .toString(),
                                                parentName: snapshot.data!
                                                    .docs[index]["parentName"]
                                                    .toString(),
                                                parentEmail: snapshot.data!
                                                    .docs[index]["parentEmail"]
                                                    .toString(),
                                                parentUid: snapshot.data!
                                                    .docs[index]["parentId"]
                                                    .toString(),
                                                gender: snapshot
                                                    .data!.docs[index]["gender"]
                                                    .toString(),
                                                score: snapshot
                                                    .data!.docs[index]["score"],
                                                status: "view",
                                                payment: snapshot
                                                    .data!
                                                    .docs[index]
                                                        ["paymentMethod"]
                                                    .toString(),
                                                userIs: "Doctor",
                                                date: snapshot
                                                    .data!.docs[index]["date"]
                                                    .toString(),
                                                docId: snapshot
                                                    .data!.docs[index].id,
                                                evaluation: int.parse(snapshot
                                                    .data!
                                                    .docs[index]["evaluation"]
                                                    .toString()),
                                              )),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      width: size.width * 0.95,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: whiteColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // color: redColor,
                                            width: size.width * 0.25,
                                            height: size.height * 0.18,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  height: size.height * 0.25,
                                                  width: size.width,
                                                  fit: BoxFit.cover,
                                                  imageUrl: snapshot.data!
                                                      .docs[index]["childImage"]
                                                      .toString(),
                                                  placeholder: (context, url) =>
                                                      Container(
                                                          height: 50,
                                                          width: 50,
                                                          child: Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                            color:
                                                                lightButtonGreyColor,
                                                          ))),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            //   color: redColor,
                                            width: size.width * 0.6,

                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, top: 8),
                                                    child: Text(
                                                      "Booking Id : #" +
                                                          "${index + 1}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          height: 1.3),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,

                                                  //  color: Colors.green,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8,
                                                    ),
                                                    child: Text(
                                                      "Clinic : " +
                                                          snapshot
                                                              .data!
                                                              .docs[index]
                                                                  ["doctorName"]
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.3),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8,
                                                    ),
                                                    child: Text(
                                                      "Appointment Date : " +
                                                          snapshot
                                                              .data!
                                                              .docs[index][
                                                                  "appointmentTime"]
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 1.3),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),

                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.green,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .docs[index][
                                                                  "bookingStatus"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 1.3),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),

                                                // Container(
                                                //
                                                //
                                                //   child: Row(
                                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                //     children: [
                                                //       GestureDetector(
                                                //         onTap: () {
                                                //           // Navigator.push(
                                                //           //   context,
                                                //           //   PageRouteBuilder(
                                                //           //     pageBuilder: (c, a1, a2) => FeedbackReportScreen(title: 'Feedback',
                                                //           //       doctorId: snapshot.data!.docs[index]["clinicUid"].toString(),
                                                //           //       doctorName: snapshot.data!.docs[index]["clinicName"].toString(),
                                                //           //     ),
                                                //           //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                //           //     transitionDuration: Duration(milliseconds: 100),
                                                //           //   ),
                                                //           // );
                                                //         },
                                                //         child: Padding(
                                                //           padding: const EdgeInsets.only(left: 8),
                                                //           child: Container(
                                                //             decoration: BoxDecoration(
                                                //               borderRadius: BorderRadius.circular(10),
                                                //               color: primaryColor,
                                                //             ),
                                                //             width: size.width*0.24,
                                                //             alignment: Alignment.center,
                                                //             child: Padding(
                                                //               padding: const EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 8),
                                                //               child: Text(
                                                //                 "Feedback"
                                                //
                                                //                 , style: TextStyle(
                                                //                   color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //       GestureDetector(
                                                //         onTap: () {
                                                //           // Navigator.push(
                                                //           //   context,
                                                //           //   PageRouteBuilder(
                                                //           //     pageBuilder: (c, a1, a2) => FeedbackReportScreen(title: 'Report',
                                                //           //       doctorId: snapshot.data!.docs[index]["clinicUid"].toString(),
                                                //           //       doctorName: snapshot.data!.docs[index]["clinicName"].toString(),
                                                //           //     ),
                                                //           //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                //           //     transitionDuration: Duration(milliseconds: 100),
                                                //           //   ),
                                                //           // );
                                                //         },
                                                //         child: Padding(
                                                //           padding: const EdgeInsets.only(left: 0),
                                                //           child: Container(
                                                //             decoration: BoxDecoration(
                                                //               borderRadius: BorderRadius.circular(10),
                                                //               color: buttonColor,
                                                //             ),
                                                //             width: size.width*0.24,
                                                //             alignment: Alignment.center,
                                                //             child: Padding(
                                                //               padding: const EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 8),
                                                //               child: Text(
                                                //                 "Report"
                                                //
                                                //                 , style: TextStyle(
                                                //                   color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //
                                                //
                                                //     ],),
                                                // ),
                                                //
                                                // SizedBox(
                                                //   height: size.height*0.02,
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  }
                },
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Bookings")
                    .where("parentId",
                        isEqualTo: _auth.currentUser!.uid.toString())
                    .where("bookingStatus", isEqualTo: "Cancelled")
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ParentBookingDetailScreen(
                                                childName: snapshot.data!
                                                    .docs[index]["childName"]
                                                    .toString(),
                                                childImage: snapshot.data!
                                                    .docs[index]["childImage"]
                                                    .toString(),
                                                age: snapshot
                                                    .data!.docs[index]["age"]
                                                    .toString(),
                                                childCase: snapshot
                                                    .data!.docs[index]["case"]
                                                    .toString(),
                                                advice: snapshot
                                                    .data!.docs[index]["advice"]
                                                    .toString(),
                                                parentName: snapshot.data!
                                                    .docs[index]["parentName"]
                                                    .toString(),
                                                parentEmail: snapshot.data!
                                                    .docs[index]["parentEmail"]
                                                    .toString(),
                                                parentUid: snapshot.data!
                                                    .docs[index]["parentId"]
                                                    .toString(),
                                                gender: snapshot
                                                    .data!.docs[index]["gender"]
                                                    .toString(),
                                                score: snapshot
                                                    .data!.docs[index]["score"],
                                                status: "view",
                                                payment: snapshot
                                                    .data!
                                                    .docs[index]
                                                        ["paymentMethod"]
                                                    .toString(),
                                                userIs: "Doctor",
                                                date: snapshot
                                                    .data!.docs[index]["date"]
                                                    .toString(),
                                                docId: snapshot
                                                    .data!.docs[index].id,
                                                evaluation: int.parse(snapshot
                                                    .data!
                                                    .docs[index]["evaluation"]
                                                    .toString()),
                                              )),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      width: size.width * 0.95,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: whiteColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // color: redColor,
                                            width: size.width * 0.25,
                                            height: size.height * 0.15,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                height: size.height * 0.25,
                                                width: size.width,
                                                fit: BoxFit.cover,
                                                imageUrl: snapshot.data!
                                                    .docs[index]["childImage"]
                                                    .toString(),
                                                placeholder: (context, url) =>
                                                    Container(
                                                        height: 50,
                                                        width: 50,
                                                        child: Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                          color:
                                                              lightButtonGreyColor,
                                                        ))),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            //   color: redColor,
                                            width: size.width * 0.6,

                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, top: 8),
                                                    child: Text(
                                                      "Booking Id : #" +
                                                          "${index + 1}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          height: 1.3),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,

                                                  //  color: Colors.green,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8,
                                                    ),
                                                    child: Text(
                                                      "Clinic : " +
                                                          snapshot
                                                              .data!
                                                              .docs[index]
                                                                  ["doctorName"]
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.3),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8,
                                                    ),
                                                    child: Text(
                                                      "Appointment Date : " +
                                                          snapshot
                                                              .data!
                                                              .docs[index][
                                                                  "appointmentTime"]
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 1.3),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                // Container(
                                                //
                                                //   alignment: Alignment.centerLeft,
                                                //   child: Padding(
                                                //     padding: const EdgeInsets.only(left: 8,),
                                                //     child: Text(
                                                //       "Specialization : " + snapshot.data!.docs[index]["doctorSpec"].toString() + " "
                                                //       , style: TextStyle(
                                                //         color: Colors.green, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                //   ),
                                                // ),
                                                //
                                                // SizedBox(
                                                //   height: size.height*0.01,
                                                // ),

                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.red,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .docs[index][
                                                                  "bookingStatus"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 1.3),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),

                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          // Navigator.push(
                                                          //   context,
                                                          //   PageRouteBuilder(
                                                          //     pageBuilder: (c, a1, a2) => FeedbackReportScreen(title: 'Feedback',
                                                          //       doctorId: snapshot.data!.docs[index]["clinicUid"].toString(),
                                                          //       doctorName: snapshot.data!.docs[index]["clinicName"].toString(),
                                                          //     ),
                                                          //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                          //     transitionDuration: Duration(milliseconds: 100),
                                                          //   ),
                                                          // );
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  primaryColor,
                                                            ),
                                                            width: size.width *
                                                                0.24,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10,
                                                                      bottom:
                                                                          10,
                                                                      left: 8,
                                                                      right: 8),
                                                              child: Text(
                                                                "Feedback",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height:
                                                                        1.3),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          // Navigator.push(
                                                          //   context,
                                                          //   PageRouteBuilder(
                                                          //     pageBuilder: (c, a1, a2) => FeedbackReportScreen(title: 'Report',
                                                          //       doctorId: snapshot.data!.docs[index]["clinicUid"].toString(),
                                                          //       doctorName: snapshot.data!.docs[index]["clinicName"].toString(),
                                                          //     ),
                                                          //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                          //     transitionDuration: Duration(milliseconds: 100),
                                                          //   ),
                                                          // );
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 0),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  buttonColor,
                                                            ),
                                                            width: size.width *
                                                                0.24,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10,
                                                                      bottom:
                                                                          10,
                                                                      left: 8,
                                                                      right: 8),
                                                              child: Text(
                                                                "Report",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height:
                                                                        1.3),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: size.height * 0.02,
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
                            }),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
