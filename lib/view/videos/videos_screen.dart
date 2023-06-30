import 'package:autism_perdiction_app/constants.dart';
import 'package:flutter/material.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {

  List<Map<String, String>> images = [
    {
      "image": "assets/images/1.jpeg",
      "title": "Video",
    },
    {
      "image": "assets/images/2.jpeg",
      "title": "video",
    },


  ];

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
          'Videos',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600,color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Container(
        width: size.width,
        child: ListView.builder(
          itemCount: images.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(

                width: MediaQuery.of(context).size.width * 0.9,
                clipBehavior: Clip.antiAliasWithSaveLayer,
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
                  color:
                  Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:   Container(
                  width:
                  MediaQuery.of(context).size.width * 0.6,
                  // height:
                  // MediaQuery.of(context).size.height * 0.5,
                  color:
                  Colors.white
                  ,
                  child:   Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(images[index]["image"].toString(),),
                      Container(
                        child: Icon(Icons.play_circle_outline_rounded, color: Colors.black,size: 70,),
                      ),





                    ],
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
}
