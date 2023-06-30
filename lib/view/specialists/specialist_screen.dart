import 'package:autism_perdiction_app/constants.dart';
import 'package:autism_perdiction_app/view/detail/specialistDetail/specialist_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SpecialistScreen extends StatefulWidget {
  const SpecialistScreen({super.key});

  @override
  State<SpecialistScreen> createState() => _SpecialistScreenState();
}

class _SpecialistScreenState extends State<SpecialistScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightButtonGreyColor,

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        title:  Text('Specialist', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Doctors").snapshots(),
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
            return Container(
              width: size.width,
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SpecialistDetailScreen(
                          image: snapshot.data!.docs[index]["image"].toString(),
                          name: snapshot.data!.docs[index]["clinicName"].toString(),
                          userEmail: snapshot.data!.docs[index]["email"].toString(),
                          userName: snapshot.data!.docs[index]["clinicName"].toString(),
                          specialization: "Autism",
                          category:"Autism",
                          doctorId: snapshot.data!.docs[index]["uid"].toString(),
                          phone: snapshot.data!.docs[index]["phone"].toString(),
                          email: snapshot.data!.docs[index]["email"].toString(),
                          status: "add",
                          userIs: "Doctor",
                          payment: "add" ,
                        )),
                      );

                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // height: 120,
                          // margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width * 0.95,
                        alignment: Alignment.center,
                        //  clipBehavior: Clip.antiAliasWithSaveLayer,
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
                            index == 1 ? darkGreenColor :
                            index == 2 ? lightPeachColor :
                            index == 3 ? lightblueColor :
                            index == 4 ? secondaryColor :
                            index == 5 ? bgColor :
                            index == 6 ? oneColor1 :


                            Colors.white,

                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:       Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 10,left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              snapshot
                                                  .data!
                                                  .docs[index]
                                              ["address"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.call_outlined,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                          Text(
                                            snapshot
                                                .data!
                                                .docs[index]
                                            ["phone"]
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, bottom: 5),
                                        child: CircleAvatar(
                                          radius: 40,
                                          foregroundImage: NetworkImage(
                                            snapshot.data!.docs[index]["image"].toString(),
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          snapshot
                                              .data!
                                              .docs[index]
                                          ["clinicName"]
                                              .toString(),
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                //Container(child: Text('AdminHome'),),
              ),
            );
          }
        },
      ),

    );
  }
}
