import 'package:autism_perdiction_app/constants.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(

        iconTheme: IconThemeData(color: whiteColor, size: 25),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();

        }, icon: Icon(Icons.arrow_back_ios, size: 18,color: whiteColor,)),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: appBarColor,
        title: Text(
          'About Us',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600,color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Column(children: [

        SizedBox(
          height: 10,
        ),

        Center(
          child: Container(
            width: size.width*0.95,
            child: Text(
              'About Us\n\n'
                  'In this app we are creating awareness for autism predection\n\n'
                  'Autism spectrum disorder (ASD) is a developmental disability caused by differences in the brain. People with ASD often have problems with social communication and interaction, and restricted or repetitive behaviors or interests. '
                  '\n\nPeople with ASD may also have different ways of learning, moving, or paying attention.',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400,color: Colors.black),
            ),
          ),
        ),

      ],),


    );
  }
}
