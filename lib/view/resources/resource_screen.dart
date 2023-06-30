import 'package:autism_perdiction_app/constants.dart';
import 'package:autism_perdiction_app/view/videos/videos_screen.dart';
import 'package:flutter/material.dart';

class ResourceScreen extends StatefulWidget {
  const ResourceScreen({super.key});

  @override
  State<ResourceScreen> createState() => _ResourceScreenState();
}

class _ResourceScreenState extends State<ResourceScreen> {

  List<Map<String, String>> images = [
    {
      "image": "assets/images/multimedia.png",
      "title": "Video",
    },
    {
      "image": "assets/images/pdf.png",
      "title": "Pdf",
    },
    {
      "image": "assets/images/other.png",
      "title": "Other",
    },

  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: whiteColor, size: 25),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: appBarColor,
        title: Text(
          'Resources',
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
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
            return GestureDetector(
              onTap: () async {

                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) =>
                    VideosScreen(),
                    transitionsBuilder: (c, anim, a2, child) =>
                        FadeTransition(opacity: anim, child: child),
                    transitionDuration: Duration(milliseconds: 0),
                  ),
                );

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
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
                    index == 0 ? lightGreenColor :
                    index == 1 ? lightPeachColor :
                    index == 2 ? secondaryColor :
                    Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:   Container(
                    width:
                    MediaQuery.of(context).size.width * 0.6,
                    // height:
                    // MediaQuery.of(context).size.height * 0.5,
                    color:
                    index == 0 ? lightGreenColor :
                    index == 1 ? lightPeachColor :
                    index == 2 ? secondaryColor :
                    Colors.white
                    ,
                    child:   Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 5),
                            child: Image.asset(images[index]["image"].toString(),height: 100,width: 100,)
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Text(
                          images[index]
                          ["title"]
                              .toString(),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style:  TextStyle(
                              fontSize: 16,
                              fontWeight:
                              FontWeight.bold,
                              color: Colors.black),
                        ),

                        SizedBox(
                          height: 10,
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
}
