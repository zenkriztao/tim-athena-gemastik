import 'package:aksonhealth/constants.dart';
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

  List hastag = [
    "Neuron",
    "Other Thinking",
    "High-order brain",
    "Dyslexia ",
    "Special Autism",
    "Secret Brain",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: whiteColor, size: 25),
        automaticallyImplyLeading: false,
        backgroundColor: appBarColor,
        elevation: 0,
        title: Text(
          'Sumber Daya',
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hastag.length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 8,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        color: Colors.blue.withOpacity(0.15),
                      ),
                      child: Center(
                        child: Text(
                          "#${hastag[index]}",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.blue,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 36),
            Text(
              "My Feed",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 243,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: SizedBox(
                      width: 380,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/feed_test.png",
                            width: 380,
                            height: 380 / (16 / 9),
                          ),
                          Text(
                            "English language teaching for Autism Spectrum Disorders Disorders ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              //ini atur ketinggian listviewnya
              height: 210,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: SizedBox(
                      width: 210,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            //ini atur ukuran gambar
                            "assets/images/Funny.png",
                            width: 190,
                            height: 320 / (16 / 9),
                          ),
                          Text("What about Neuron?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Text(
            //   "English language teaching for Autism Spectrum Disorders",
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 16,
            //   ),
            // ),

            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Container(
            //       width: 360,
            //       height: 360 / (16 / 9),
            //       decoration: BoxDecoration(
            //         color: Colors.grey,
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(4),
            //         ),
            //       ),
            //       child: Image.asset("assets/images/feed_test.png"),
            //     ),
            //     SizedBox(
            //       height: 12,
            //     ),
            //     Text(
            //       "English language teaching for Autism Spectrum Disorders",
            //       style: TextStyle(
            //           fontWeight: FontWeight.bold, fontSize: 16),
            //     )
            //   ],
            // ),
            // );
          ],
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     iconTheme: IconThemeData(color: whiteColor, size: 25),
    //     automaticallyImplyLeading: false,
    //     elevation: 0,
    //     backgroundColor: appBarColor,
    //     title: Text(
    //       'Resources',
    //       style: TextStyle(
    //           fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
    //     ),
    //     centerTitle: true,
    //   ),

    //   body: Container(
    //     width: size.width,
    //     child: ListView.builder(
    //       itemCount: images.length,
    //       shrinkWrap: true,
    //       scrollDirection: Axis.vertical,
    //       itemBuilder: (context, index) {
    //         return GestureDetector(
    //           onTap: () async {

    //             Navigator.push(
    //               context,
    //               PageRouteBuilder(
    //                 pageBuilder: (c, a1, a2) =>
    //                 VideosScreen(),
    //                 transitionsBuilder: (c, anim, a2, child) =>
    //                     FadeTransition(opacity: anim, child: child),
    //                 transitionDuration: Duration(milliseconds: 0),
    //               ),
    //             );

    //           },
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Container(
    //               margin: const EdgeInsets.symmetric(horizontal: 10),
    //               width: MediaQuery.of(context).size.width * 0.9,
    //               clipBehavior: Clip.antiAliasWithSaveLayer,
    //               decoration: BoxDecoration(
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.grey.withOpacity(0.4),
    //                     offset: const Offset(6, 6),
    //                     blurRadius: 8,
    //                   ),
    //                   BoxShadow(
    //                     color: Colors.grey.withOpacity(0.3),
    //                     offset: const Offset(4, 4),
    //                     blurRadius: 5,
    //                   ),
    //                 ],
    //                 color:
    //                 index == 0 ? lightGreenColor :
    //                 index == 1 ? lightPeachColor :
    //                 index == 2 ? secondaryColor :
    //                 Colors.white,
    //                 borderRadius: BorderRadius.circular(10),
    //               ),
    //               child:   Container(
    //                 width:
    //                 MediaQuery.of(context).size.width * 0.6,
    //                 // height:
    //                 // MediaQuery.of(context).size.height * 0.5,
    //                 color:
    //                 index == 0 ? lightGreenColor :
    //                 index == 1 ? lightPeachColor :
    //                 index == 2 ? secondaryColor :
    //                 Colors.white
    //                 ,
    //                 child:   Column(
    //                   children: [
    //                     SizedBox(
    //                       height: 10,
    //                     ),
    //                     Padding(
    //                         padding: const EdgeInsets.only(
    //                             top: 10.0, bottom: 5),
    //                         child: Image.asset(images[index]["image"].toString(),height: 100,width: 100,)
    //                     ),

    //                     SizedBox(
    //                       height: 10,
    //                     ),

    //                     Text(
    //                       images[index]
    //                       ["title"]
    //                           .toString(),
    //                       overflow: TextOverflow.fade,
    //                       maxLines: 1,
    //                       style:  TextStyle(
    //                           fontSize: 16,
    //                           fontWeight:
    //                           FontWeight.bold,
    //                           color: Colors.black),
    //                     ),

    //                     SizedBox(
    //                       height: 10,
    //                     ),

    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //       //Container(child: Text('AdminHome'),),
    //     ),
    //   ),

    // );
  }
}
