import 'package:autism_perdiction_app/constants.dart';
import 'package:autism_perdiction_app/model/firebase_auth.dart';
import 'package:autism_perdiction_app/view/detail/bookingDetail/booking_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class DoctorBookingScreen extends StatefulWidget {
  const DoctorBookingScreen({Key? key}) : super(key: key);

  @override
  _DoctorBookingScreenState createState() => _DoctorBookingScreenState();
}

class _DoctorBookingScreenState extends State<DoctorBookingScreen> {
  String? renterEmail = '', renterName = '', renterUid = '';
  MethodsHandler _methodsHandler = MethodsHandler();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // backgroundColor: primaryColor,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: buttonColor,

            bottom: TabBar(
              indicatorColor: primaryColor,
              onTap: (index) {
                // Tab index when user select it, it start from zero
              },
              tabs: [
                Tab(text: 'New',),
                Tab(text: 'Confirmed',),
                Tab(text: 'Cancelled',),
              ],
            ),
            centerTitle: true,
            title: Text('Bookings'),
          ),
          body: TabBarView(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Bookings").where("doctorId", isEqualTo: _auth.currentUser!.uid.toString() ).where("bookingStatus", isEqualTo: "Pending" ).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: primaryColor,
                    ));
                  }
                  else if(snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    // got data from snapshot but it is empty

                    return Center(child: Text("No Data Found"));
                  }
                  else {
                    return Container(
                      width: size.width*0.95,

                      child:   ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount:snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return   Padding(
                              padding: const EdgeInsets.only(left: 8,right: 8,top: 0),
                              child: GestureDetector(
                                onTap: () {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => BookingDetailScreen(
                                      childName: snapshot.data!.docs[index]["childName"].toString(),
                                      childImage: snapshot.data!.docs[index]["childImage"].toString(),
                                      age: snapshot.data!.docs[index]["age"].toString(),
                                      childCase: snapshot.data!.docs[index]["case"].toString(),
                                      advice: snapshot.data!.docs[index]["advice"].toString(),
                                      parentName: snapshot.data!.docs[index]["parentName"].toString(),
                                      parentEmail: snapshot.data!.docs[index]["parentEmail"].toString(),
                                      parentUid: snapshot.data!.docs[index]["parentId"].toString(),
                                      gender: snapshot.data!.docs[index]["gender"].toString(),
                                      score: snapshot.data!.docs[index]["score"],
                                      status: "view",
                                      docId: snapshot.data!.docs[index].id,
                                      payment: snapshot.data!.docs[index]["paymentMethod"].toString() ,
                                      userIs: "Doctor", date: snapshot.data!.docs[index]["date"].toString(),
                                    )),
                                  );


                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    width: size.width*0.95,


                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: whiteColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Container(
                                          // color: redColor,
                                          width: size.width*0.25,
                                          height: size.height*0.15,
                                          child:  ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child:  CachedNetworkImage(
                                              height: size.height * 0.25,

                                              width: size.width ,
                                              fit: BoxFit.cover,
                                              imageUrl: snapshot.data!.docs[index]["doctorImage"].toString(),
                                              placeholder: (context, url) => Container(
                                                  height: 50, width: 50,
                                                  child: Center(child: CircularProgressIndicator(color: lightButtonGreyColor,))),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          //   color: redColor,
                                          width: size.width*0.6,

                                          child:  Column(
                                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [


                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8,top: 8),
                                                  child: Text(
                                                    "Booking Id : #" + "${index+1}"
                                                    , style: TextStyle(
                                                      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800, height: 1.3),),
                                                ),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,

                                                //  color: Colors.green,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(
                                                    "Child : " + snapshot.data!.docs[index]["childName"].toString()
                                                    , style: TextStyle(
                                                      color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                ),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),

                                              Container(
                                                alignment: Alignment.centerLeft,

                                                //  color: Colors.green,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(

                                                      snapshot.data!.docs[index]["evaluation"].toString() == "0" ?
                                                      "Evaluation : Not Evaluated" :
                                                    "Evaluation : " + snapshot.data!.docs[index]["evaluation"].toString()
                                                    , style: TextStyle(
                                                      color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                ),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),

                                              Container(
                                                alignment: Alignment.centerLeft,

                                                child:   Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(
                                                    "Appointment Date : " + snapshot.data!.docs[index]["appointmentTime"].toString()
                                                    , style: TextStyle(
                                                      color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600, height: 1.3),),
                                                ),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),

                                              Container(

                                                width: size.width*0.6,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap:() {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: const Text('Approve Booking'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      color: Colors.red,
                                                                    ),
                                                                    width: size.width*0.22,
                                                                    alignment: Alignment.center,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8),
                                                                      child: Text(
                                                                        'No'

                                                                        , style: TextStyle(
                                                                          color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () async {
                                                                    FirebaseFirestore.instance.collection("Bookings").
                                                                    doc(snapshot.data!.docs[index].id.toString()).update({
                                                                      "bookingStatus": "Confirmed"
                                                                    }).whenComplete((){
                                                                      Navigator.of(context).pop();
                                                                    });
                                                                  },
                                                                  child:Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      color: Colors.green,
                                                                    ),
                                                                    width: size.width*0.22,
                                                                    alignment: Alignment.center,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8),
                                                                      child: Text(
                                                                        'Yes'

                                                                        , style: TextStyle(
                                                                          color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                              content: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  const Text('Are you sure you want to approve this booking?'),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.green,
                                                        ),
                                                        width: size.width*0.22,
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8),
                                                          child: Text(
                                                            'Approve'

                                                            , style: TextStyle(
                                                              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: const Text('Cancel booking'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: const Text('No'),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () async {
                                                                    FirebaseFirestore.instance.collection("Bookings").
                                                                    doc(snapshot.data!.docs[index].id.toString()).update({
                                                                      "bookingStatus": "Cancelled"
                                                                    }).whenComplete((){
                                                                      Navigator.of(context).pop();
                                                                    });
                                                                  },
                                                                  child: const Text('Yes'),
                                                                ),
                                                              ],
                                                              content: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  const Text('Are you sure you want to cancel this bookings?'),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: redColor,
                                                        ),
                                                        width: size.width*0.22,
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8),
                                                          child: Text(
                                                            'Cancel'

                                                            , style: TextStyle(
                                                              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                        ),
                                                      ),
                                                    ),


                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.02,
                                              ),
                                            ],),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }


                },
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Bookings").where("doctorId", isEqualTo: _auth.currentUser!.uid.toString() ).where("bookingStatus", isEqualTo: "Confirmed" ).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: primaryColor,
                    ));
                  }
                  else if(snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    // got data from snapshot but it is empty

                    return Center(child: Text("No Data Found"));
                  }
                  else {
                    return Container(
                      width: size.width*0.95,

                      child:   ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount:snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return   Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => BookingDetailScreen(
                                      childName: snapshot.data!.docs[index]["childName"].toString(),
                                      childImage: snapshot.data!.docs[index]["childImage"].toString(),
                                      age: snapshot.data!.docs[index]["age"].toString(),
                                      docId: snapshot.data!.docs[index].id,
                                      childCase: snapshot.data!.docs[index]["case"].toString(),
                                      advice: snapshot.data!.docs[index]["advice"].toString(),
                                      parentName: snapshot.data!.docs[index]["parentName"].toString(),
                                      parentEmail: snapshot.data!.docs[index]["parentEmail"].toString(),
                                      parentUid: snapshot.data!.docs[index]["parentId"].toString(),
                                      gender: snapshot.data!.docs[index]["gender"].toString(),
                                      score: snapshot.data!.docs[index]["score"],
                                      status: "view",
                                      payment: snapshot.data!.docs[index]["paymentMethod"].toString() ,
                                      userIs: "Doctor", date: snapshot.data!.docs[index]["date"].toString(),
                                    )),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: size.width*0.95,


                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: whiteColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Container(
                                          // color: redColor,
                                          width: size.width*0.25,
                                          height: size.height*0.15,
                                          child:  ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child:  CachedNetworkImage(
                                              height: size.height * 0.25,

                                              width: size.width ,
                                              fit: BoxFit.cover,
                                              imageUrl: snapshot.data!.docs[index]["doctorImage"].toString(),
                                              placeholder: (context, url) => Container(
                                                  height: 50, width: 50,
                                                  child: Center(child: CircularProgressIndicator(color: lightButtonGreyColor,))),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          //   color: redColor,
                                          width: size.width*0.6,

                                          child:  Column(
                                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8,top: 8),
                                                  child: Text(
                                                    "Booking Id : #" + "${index+1}"
                                                    , style: TextStyle(
                                                      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800, height: 1.3),),
                                                ),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,

                                                //  color: Colors.green,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(
                                                    "Child : " + snapshot.data!.docs[index]["childName"].toString()
                                                    , style: TextStyle(
                                                      color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                ),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),


                                              Container(
                                                alignment: Alignment.centerLeft,

                                                //  color: Colors.green,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(

                                                    snapshot.data!.docs[index]["evaluation"].toString() == "0" ?
                                                    "Evaluation : Not Evaluated" :
                                                    "Evaluation : " + snapshot.data!.docs[index]["evaluation"].toString()
                                                    , style: TextStyle(
                                                      color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height*0.01,
                                              ),

                                              Container(
                                                alignment: Alignment.centerLeft,

                                                child:   Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(
                                                    "Appointment Date : " + snapshot.data!.docs[index]["appointmentTime"].toString()
                                                    , style: TextStyle(
                                                      color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600, height: 1.3),),
                                                ),
                                              ),


                                              // SizedBox(
                                              //   height: size.height*0.01,
                                              // ),
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

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),

                                              Container(

                                                width: size.width*0.6,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap:() {

                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color:
                                                          snapshot.data!.docs[index]["bookingStatus"].toString() == 'Confirmed' ?
                                                          Colors.green :

                                                          primaryColor,
                                                        ),
                                                        width: size.width*0.4,
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8),
                                                          child: Text(
                                                            snapshot.data!.docs[index]["bookingStatus"].toString()

                                                            , style: TextStyle(
                                                              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                        ),
                                                      ),
                                                    ),

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.02,
                                              ),
                                            ],),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }


                },
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Bookings").where("doctorId", isEqualTo: _auth.currentUser!.uid.toString() ).where("bookingStatus", isEqualTo: "Cancelled" ).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: primaryColor,
                    ));
                  }
                  else if(snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    // got data from snapshot but it is empty

                    return Center(child: Text("No Data Found"));
                  }
                  else {
                    return Container(
                      width: size.width*0.95,

                      child:   ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount:snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return   Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => BookingDetailScreen(
                                      childName: snapshot.data!.docs[index]["childName"].toString(),
                                      childImage: snapshot.data!.docs[index]["childImage"].toString(),
                                      age: snapshot.data!.docs[index]["age"].toString(),
                                      childCase: snapshot.data!.docs[index]["case"].toString(),
                                      advice: snapshot.data!.docs[index]["advice"].toString(),
                                      parentName: snapshot.data!.docs[index]["parentName"].toString(),
                                      parentEmail: snapshot.data!.docs[index]["parentEmail"].toString(),
                                      parentUid: snapshot.data!.docs[index]["parentId"].toString(),
                                      gender: snapshot.data!.docs[index]["gender"].toString(),
                                      score: snapshot.data!.docs[index]["score"],
                                      status: "view",
                                      payment: snapshot.data!.docs[index]["paymentMethod"].toString() ,
                                      userIs: "Doctor", date: snapshot.data!.docs[index]["date"].toString(),
                                      docId: snapshot.data!.docs[index].id,
                                    )),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: size.width*0.95,


                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: whiteColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Container(
                                          // color: redColor,
                                          width: size.width*0.25,
                                          height: size.height*0.15,
                                          child:  ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child:  CachedNetworkImage(
                                              height: size.height * 0.25,

                                              width: size.width ,
                                              fit: BoxFit.cover,
                                              imageUrl: snapshot.data!.docs[index]["doctorImage"].toString(),
                                              placeholder: (context, url) => Container(
                                                  height: 50, width: 50,
                                                  child: Center(child: CircularProgressIndicator(color: lightButtonGreyColor,))),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          //   color: redColor,
                                          width: size.width*0.6,

                                          child:  Column(
                                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8,top: 8),
                                                  child: Text(
                                                    "Appointment Id : #" + "${index+1}"
                                                    , style: TextStyle(
                                                      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800, height: 1.3),),
                                                ),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,

                                                //  color: Colors.green,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(
                                                    "Clinic : " + snapshot.data!.docs[index]["clinicName"].toString()
                                                    , style: TextStyle(
                                                      color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                ),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),

                                              Container(
                                                alignment: Alignment.centerLeft,

                                                //  color: Colors.green,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(

                                                    snapshot.data!.docs[index]["evaluation"].toString() == "0" ?
                                                    "Evaluation : Not Evaluated" :
                                                    "Evaluation : " + snapshot.data!.docs[index]["evaluation"].toString()
                                                    , style: TextStyle(
                                                      color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height*0.01,
                                              ),

                                              Container(
                                                alignment: Alignment.centerLeft,

                                                child:   Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(
                                                    "Appointment Date : " + snapshot.data!.docs[index]["appointmentTime"].toString()
                                                    , style: TextStyle(
                                                      color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600, height: 1.3),),
                                                ),
                                              ),


                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(
                                                    "Specialization : " + snapshot.data!.docs[index]["doctorSpec"].toString() + " "
                                                    , style: TextStyle(
                                                      color: Colors.green, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                ),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),

                                              Container(

                                                width: size.width*0.6,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap:() {

                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color:
                                                          snapshot.data!.docs[index]["bookingStatus"].toString() == 'Cancelled' ?
                                                          Colors.red :

                                                          primaryColor,
                                                        ),
                                                        width: size.width*0.4,
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8),
                                                          child: Text(
                                                            snapshot.data!.docs[index]["bookingStatus"].toString()

                                                            , style: TextStyle(
                                                              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                        ),
                                                      ),
                                                    ),

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.02,
                                              ),
                                            ],),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
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
