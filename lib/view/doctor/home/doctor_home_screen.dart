import 'package:autism_perdiction_app/constants.dart';
import 'package:autism_perdiction_app/view/auth/userType/usertype_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {

  List<Map<String, String>> images = [
    {
      "image": "assets/images/n1.png",
      "title": "Hyperactive",
    },
    {
      "image": "assets/images/n2.png",
      "title": "Depression",
    },
    {
      "image": "assets/images/n3.png",
      "title": "Rejecting Cuddles.",
    },
    {
      "image": "assets/images/n4.png",
      "title": "Not Responding.",
    },
    {
      "image": "assets/images/n5.png",
      "title": "Epilepsy.",
    },
    {"image": "assets/images/n6.png", "title": "Prefer to Play Alone."},
    {"image": "assets/images/n7.png", "title": "Connection Problems."},
    {"image": "assets/images/n8.png", "title": "Learning Disability."},
  ];
  int _currentindex = 0;
  String name = '' , email = '',uid = '',userType = '';
  String text = '';
  int current = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      //userType = prefs.getString('userType')!;
      email = prefs.getString('userEmail')!;
      uid = prefs.getString('userId')!;
    });

    FirebaseFirestore.instance.collection('Parents').where('uid',isEqualTo: _auth.currentUser!.uid.toString()).get().then((value) {
      setState(() {
        name = value.docs[0]['name'];
        email = value.docs[0]['email'];
      });
    });
  }


  Widget _buildCont(int index) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: 20,
      height: 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          shape: BoxShape.rectangle,
          color: _currentindex == index
              ? secondary3Color
              : secondaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('assets/autism.png', fit: BoxFit.scaleDown,
                height: 80,
                width: 80,),
            ),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          backgroundColor: lightButtonGreyColor, //Colors.white,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [

              DrawerHeader(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), bottomLeft: Radius.circular(50)),
                  // gradient: LinearGradient(begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   stops: [
                  //     0.1,
                  //     0.9
                  //   ], colors: [
                  //     darkRedColor,
                  //     lightRedColor,
                  //   ],
                  // ),
                ),
                margin: EdgeInsets.zero,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset( 'assets/autism.png',height: 90,width: 100,fit: BoxFit.scaleDown,),
                      SizedBox(
                        height: 0,
                      ),
                      Text(name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(email,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Padding(
                padding:
                const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    //<-- SEE HERE
                    side: BorderSide(width: 1, color: whiteColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: whiteColor,
                  leading: Container(

                    width: 30,
                    height: 30,
                    //devSize.height*0.05,
                    child: Image.asset('assets/images/shutdown.png', fit: BoxFit.scaleDown,
                      width: 30,
                      height: 30,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  ),
                  title: Text('Logout',),
                  onTap: () async {

                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    try {
                      return await _auth.signOut().whenComplete(() {
                        prefs.remove('userEmail');
                        prefs.remove('userType');
                        prefs.remove('userPassword');
                        prefs.remove('userId');
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> UserType()));
                      });
                    } catch (e) {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: size.height*0.15,
              ),

            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Common Symptoms',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              CarouselSlider.builder(
                options: CarouselOptions(
                    onPageChanged: (index, _) {
                      setState(() {
                        _currentindex = index;
                      });
                    },
                    initialPage: 0,
                    autoPlay: true,
                    height: MediaQuery.of(context).size.height * 0.35),
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
                    Container(
                      margin:  EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          boxShadow:  [
                            BoxShadow(
                                offset: Offset(1, 0),
                                // The alignment of the effect(x,y)
                                spreadRadius: 0,
                                //Spread radius means how much it will spread
                                blurRadius: 4,
                                //How big the blus will be
                                color: Colors.grey //color of the effect.
                            )
                          ],
                          color:
                          index == 0 ? lightGreenColor :
                          index == 1 ? darkGreenColor :
                          index == 2 ? lightPeachColor :
                          index == 3 ? lightblueColor :
                          index == 4 ? secondaryColor :
                          index == 5 ? bgColor :
                          index == 6 ? oneColor1 :


                          Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width - 50,
                        child: Column(
                          children: [
                            const Spacer(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: Image.asset(
                                images[index]["image"].toString(),
                                fit: BoxFit.fill,
                              ),
                            ),
                            const Spacer(),
                            FittedBox(
                              child: Text(
                                images[index]["title"].toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 21, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCont(0),
                  _buildCont(1),
                  _buildCont(2),
                  _buildCont(3),
                  _buildCont(4),
                  _buildCont(5),
                  _buildCont(6),
                  _buildCont(7),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                child: const Text(
                  'New Bookings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                // height: 120,
                child:  StreamBuilder(
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

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => DoctorDetailScreen(
                                    //     image: snapshot.data!.docs[index]["doctorImage"].toString(),
                                    //     name: snapshot.data!.docs[index]["doctorName"].toString(),
                                    //     userEmail: snapshot.data!.docs[index]["userEmail"].toString(),
                                    //     userName: snapshot.data!.docs[index]["userName"].toString(),
                                    //     specialization: snapshot.data!.docs[index]["doctorSpec"].toString(),
                                    //     category: snapshot.data!.docs[index]["doctorCategory"].toString(),
                                    //     doctorId: snapshot.data!.docs[index]["doctorId"].toString(),
                                    //     phone: snapshot.data!.docs[index]["doctorPhone"].toString(),
                                    //     email: snapshot.data!.docs[index]["appointmentTime"].toString(),
                                    //     status: "view",
                                    //     payment: snapshot.data!.docs[index]["paymentMethod"].toString() ,
                                    //     userIs: "Doctor",
                                    //   )),
                                    // );


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
              ),
              const SizedBox(
                height: 25,
              ),
            ],),
        ),

      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await
    showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit the App?'),
        actions:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: primaryColor,
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No'),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            //return true when click on "Yes"
            style: ElevatedButton.styleFrom(
                primary: redColor,
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            child:Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }

}
