import 'package:autism_perdiction_app/view/parents/gamification/auth.dart';
import 'package:autism_perdiction_app/view/parents/gamification/components/custom_container.dart';
import 'package:autism_perdiction_app/view/parents/gamification/storylines/daily_challenge.dart';
import 'package:autism_perdiction_app/view/parents/gamification/storylines/first_storyline.dart';
import 'package:autism_perdiction_app/view/parents/gamification/storylines/second_storyline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    return customContainer(
      Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width / 12,
                      bottom: MediaQuery.of(context).size.width / 6),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Welcome!",
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.black87,
                                fontFamily: 'LuckiestGuy',
                              )),
                        ]),
                    const SizedBox(height: 30),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        FirstStoryLine(user: user)));
                              },
                              child: Column(children: const [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage("lib/images/story.png"),
                                  radius: 50,
                                  foregroundColor: Colors.transparent,
                                ),
                                SizedBox(height: 10),
                                Text("Henry: The Autistic",
                                    style: TextStyle(
                                      fontFamily: 'Hind',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    )),
                                Text("Parrot",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Hind',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    )),
                              ])),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        SecondStoryLine(user: user)));
                              },
                              child: Column(children: const [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage("lib/images/story.png"),
                                  radius: 50,
                                  foregroundColor: Colors.transparent,
                                ),
                                SizedBox(height: 10),
                                Text("Claudio: The Dyslexic",
                                    style: TextStyle(
                                      fontFamily: 'Hind',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    )),
                                Text("Turtle",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Hind',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    )),
                              ])),
                        ]),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DailyChallenge(user: user)));
                            },
                            child: Column(children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("lib/images/story.png"),
                                radius: 50,
                              ),
                              SizedBox(height: 10),
                              Text("Daily Challenge",
                                  style: TextStyle(
                                    fontFamily: 'Hind',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  )),
                            ])),
                      ],
                    )
                  ])),
              const SizedBox(height: 20),
              Container(
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Column(children: [
                    const Text("Reminder",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    const Divider(),
                    const SizedBox(height: 40),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('name', isEqualTo: user?.email)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (2 - snapshot.data?.docs.first.get('completed') <
                                0) {
                              return const Text(
                                  "You have 0 modules left for the day!!",
                                  style: TextStyle(
                                      color: Colors.black45, fontSize: 20));
                            }
                            return Text(
                                "You have ${2 - snapshot.data?.docs.first.get('completed')} modules left for the day!!",
                                style: const TextStyle(
                                    color: Colors.black45, fontSize: 20));
                          }
                          return const Text("Loading...");
                        })
                  ]))
            ]),
          )),
    );
  }
}
