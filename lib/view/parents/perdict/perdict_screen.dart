import 'package:autism_perdiction_app/constants.dart';
import 'package:autism_perdiction_app/model/questionare_model.dart';
import 'package:autism_perdiction_app/view/parents/questionare/questionare_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PerdictScreen extends StatefulWidget {
  const PerdictScreen({super.key});

  @override
  State<PerdictScreen> createState() => _PerdictScreenState();
}

class _PerdictScreenState extends State<PerdictScreen> {


  List<Map<String,dynamic>> perdict = [
    {
      'name': 'Modified Checklist for Autism',
      'image': 'https://i.ytimg.com/vi/C345eCdyJU8/maxresdefault.jpg',

    },
    {
      'name': 'Social Communication Questionnaire',
      'image': 'https://consumer.healthday.com/media-library/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpbWFnZSI6Imh0dHBzOi8vYXNzZXRzLnJibC5tcy8zMjY0NzgwMi9vcmlnaW4uanBnIiwiZXhwaXJlc19hdCI6MTcxNzYxMTA3Mn0.0PEKXGxXtNRuQpauvofEJJjrw7hWeyMpeiBrtvCmT3g/image.jpg?width=1245&height=700&quality=85&coordinates=0%2C898%2C0%2C898',

    },
    {
      'name': 'Machine Learning',
      'image': 'https://www.microsoft.com/en-us/research/uploads/prod/2020/07/newsletter-option-8-neural-network-3-1-640x360.png',
    },

  ];



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightButtonGreyColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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

      body: Center(
        child: Container(
          width: size.width * 0.95,
          child: ListView.builder(
            itemCount: perdict.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {

                  if(index == 0) {

                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => QuestionareScreen(number: 1,type: 'MChat'),
                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 100),
                      ),
                    ).then((value) {

                    });

                  }
                  else if(index == 1) {

                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => QuestionareScreen(number: 1,type: 'SCQ'),
                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 100),
                      ),
                    ).then((value) {

                    });


                  }

                },
                child: Container(
                  margin:  EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      // boxShadow:  [
                      //   BoxShadow(
                      //       offset: Offset(1, 0),
                      //       // The alignment of the effect(x,y)
                      //       spreadRadius: 0,
                      //       //Spread radius means how much it will spread
                      //       blurRadius: 4,
                      //       //How big the blus will be
                      //       color: Colors.grey //color of the effect.
                      //   )
                      // ],
                      // color:
                      // index == 0 ? lightGreenColor :
                      // index == 1 ? darkGreenColor :
                      // index == 2 ? lightPeachColor :
                      // index == 3 ? lightblueColor :
                      // index == 4 ? secondaryColor :
                      // index == 5 ? bgColor :
                      // index == 6 ? oneColor1 :
                      //
                      //
                      // Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,

                    child: Card(
                      child: Column(
                        children: [
                          const Spacer(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:  CachedNetworkImage(
                                height: size.height * 0.25,

                                width: size.width ,
                                fit: BoxFit.cover,
                                imageUrl: perdict[index]["image"].toString(),
                                placeholder: (context, url) => Container(
                                    height: 50, width: 50,
                                    child: Center(child: CircularProgressIndicator(color: lightButtonGreyColor,))),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                          ),
                          ),
                          const Spacer(),
                          FittedBox(
                            child: Text(
                              perdict[index]["name"].toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Spacer(),
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
      ),


    );
  }
}
