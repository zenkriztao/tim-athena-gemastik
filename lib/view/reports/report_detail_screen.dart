import 'package:autism_perdiction_app/constants.dart';
import 'package:autism_perdiction_app/view/parents/bottomNavBar/app_bottom_nav_bar_screen.dart';
import 'package:autism_perdiction_app/view/specialists/doctor_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ReportDetailScreen extends StatefulWidget {
  final String childName;
  final String childAge;
  final String childGender;
  final String date;
  final String childCase;
  final String childAdvice;
  final int total;

  const ReportDetailScreen({super.key,
  required this.childName,
  required this.childAge,
  required this.childGender,
  required this.childCase,
  required this.childAdvice,
  required this.date,
  required this.total,
  });

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
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
          'Report',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600,color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [

          SizedBox(
            height: size.height*0.02,
          ),



          SizedBox(
            height: size.height*0.01,
          ),

          Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              // borderRadius: BorderRadius.circular(5)

            ),
            width: size.width*0.9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text('Autism Prediction', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 15),)),
            ),
          ),

          SizedBox(
            height: size.height*0.01,
          ),

          new CircularPercentIndicator(
            radius: 45.0,
            lineWidth: 10.0,
            percent: widget.total/10,
            center: new Text('${(widget.total/10)*100}'+ '\%'),
            progressColor:
            widget.total <= 4 ? Colors.green :
            widget.total > 4 && widget.total <= 6 ?Colors.yellow :
            widget.total > 6 ? Colors.red :
            Colors.blue,
          ),
          SizedBox(
            height: size.height*0.02,
          ),



          Center(
            child: Container(
              width: size.width*0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)

                    ),
                    width: size.width*0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Date', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 13),),
                    ),
                  ),

                  Container(
                    width: size.width*0.58,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(DateFormat('dd-MM-yyyy').format(DateTime.now()), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600,fontSize: 14),),
                    ),
                  ),


                ],),
            ),
          ),
          SizedBox(
            height: size.height*0.01,
          ),

          Container(
            width: size.width*0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)

                  ),
                  width: size.width*0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Child Name', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 13),),
                  ),
                ),

                Container(
                  width: size.width*0.58,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.childName, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 14),),
                  ),
                ),


              ],),
          ),

          SizedBox(
            height: size.height*0.01,
          ),

          Container(
            width: size.width*0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)

                  ),
                  width: size.width*0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Age', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 13),),
                  ),
                ),

                Container(
                  width: size.width*0.58,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    //border: Border.all(color: Colors.blue,width: 0.5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.childAge.toString() + ' years old', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 14),),
                  ),
                ),


              ],),
          ),

          SizedBox(
            height: size.height*0.01,
          ),

          Container(
            width: size.width*0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)

                  ),
                  width: size.width*0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Gender', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 13),),
                  ),
                ),

                Container(
                  width: size.width*0.58,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.childGender, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 14),),
                  ),
                ),


              ],),
          ),

          SizedBox(
            height: size.height*0.01,
          ),

          Container(
            width: size.width*0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)

                  ),
                  width: size.width*0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Score', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 13),),
                  ),
                ),

                Container(
                  width: size.width*0.58,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.total.toString() + ' / 10', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 14),),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: size.height*0.01,
          ),

          Container(
            width: size.width*0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)

                  ),
                  width: size.width*0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Case', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 13),),
                  ),
                ),

                Container(
                  width: size.width*0.58,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.total <= 4 ? 'This score indicates Low risk of autism' :
                      widget.total > 4 && widget.total <= 6 ?  'This score indicates Medium risk of autism' :
                      widget.total > 6 ? 'This score indicates High risk of autism'  : 'Calculation Autism'
                      , style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 14),),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: size.height*0.01,
          ),

          Container(
            width: size.width*0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)

                  ),
                  width: size.width*0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Advice', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 13),),
                  ),
                ),

                Container(
                  width: size.width*0.58,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.total <= 4 ? 'Low risk don\'t need to take your child to doctor' :
                      widget.total > 4 && widget.total <= 9 ? 'You should take your child to his/her doctor to follow up screening.You can also seek early intervention services for your child.' :
                      widget.total == 10 ? 'You must have to take your child to his/her doctor to follow up screening.You can also seek early intervention services for your child.'  :
                      'Calculation Autism'

                      , style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 14),),
                  ),
                ),


              ],),
          ),

          SizedBox(
            height: size.height*0.05,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16),
            child: Container(

              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    fourColor,
                    fourColor,

                  ],
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(size.width, 50)),
                    backgroundColor:
                    MaterialStateProperty.all(Colors.transparent),
                    // elevation: MaterialStateProperty.all(3),
                    shadowColor:
                    MaterialStateProperty.all(Colors.transparent),
                  ),

                  onPressed: () async {



                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => SpecialistScreen(),
                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 100),
                      ),
                    );


                  }, child: Text('Consult a Specialists', style: buttonStyle)),
            ),
          ),

          SizedBox(
            height: size.height*0.025,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16),
            child: Container(

              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    fourColor,
                    fourColor,

                  ],
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(size.width, 50)),
                    backgroundColor:
                    MaterialStateProperty.all(Colors.transparent),
                    // elevation: MaterialStateProperty.all(3),
                    shadowColor:
                    MaterialStateProperty.all(Colors.transparent),
                  ),

                  onPressed: () async {


                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) =>
                            AppBottomNavBarScreen(index: 0, title: '', subTitle: '',),
                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 100),
                      ),
                    );



                  }, child: Text('Go Home', style: buttonStyle)),
            ),
          ),

          SizedBox(
            height: size.height*0.1,
          ),


        ],),
      ),

    );
  }
}
