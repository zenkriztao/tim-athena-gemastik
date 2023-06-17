import 'dart:math';
import 'package:autismx/screens/BNB/screens/screens.dart';
import 'package:autismx/screens/centers/center_view.dart';
import 'package:autismx/screens/surveys/configs/colors.dart';
import 'package:autismx/screens/surveys/services/sqldb.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class ResultScreen extends StatelessWidget {
  final String questionnaireName;

  final int score1;
  final int score2;
  final int score3;
  final int score4;
  final int score5;
  final String name;
  final String age;
  final String gender;
  ResultScreen({
    @required this.questionnaireName,
    this.score1,
    this.score2,
    this.score3,
    this.score4,
    this.score5,
    @required this.name,
    @required this.age,
    @required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    SqlDb sqldb = SqlDb();
    List scores = [score1, score2, score3, score4, score5];
    int total = score1 + score2 + score3 + score4 + score5;
    String _getinterpretation() {
      if (total >= 26 && total <= 32) {
        return "You Might be Autistic Your Score indicate some Autistic traits (Asperger's Syndrome) High Chance You're Autistic";
      } else if (total >= 33) {
        return "Your Score indicates significant Autistic traits (Autism) You Should Contact a specialist to make an examination";
      } else if (total <= 25) {
        return "Your Score indicates significant Autistic traits (Autism)";
      }
    }

    String _getMax() {
      int indexOfMaximum =
          scores.indexOf([score1, score2, score3, score4, score5].reduce(max));
      switch (indexOfMaximum) {
        case 0:
          return "You have a problem with your social skills, you can work on improving it from the social skills section in the activities of the application";
          break;
        case 1:
          return "You have a problem with Attention switching, you can work on improving it from the Attention switching section in the activities of the application";
          break;
        case 2:
          return "You have a problem with Attention To Details, you can work on improving it from the Attention To Details section in the activities of the application";
          break;
        case 3:
          return "You have a problem with Communication Skills, you can work on improving it from the Communication section in the activities of the application";
          break;
        case 4:
          return "You have a problem with Imagination Skills, you can work on improving it from the Imagination skills section in the activities of the application";
          break;
        default:
      }
    }


    var now =  DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Report"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                color: ColorManager.blueFont,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Share.share(
                                      'Name: $name\nDate: $formattedDate\nAge: $age\nGender: ${gender == 1 ? "Female" : "Male"}\nScore: $total \nCase: ${_getinterpretation()} \nAdvice: ${_getMax()}',
                                      subject: "AutismX Report",
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.share_outlined,
                                    color: ColorManager.blue,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    int response = await sqldb.insertData('''
                                     INSERT INTO "report" ("name","date", "age", "gender", "score", "case", "advice") 
                                     VALUES ("$name" ,"$formattedDate" ,"$age","$gender","$total","${_getinterpretation()}","${_getMax()}")

                                       ''').then((response) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Report Saved successfully")));
                                    }).catchError((error) {});
                                  },
                                  icon: const Icon(
                                    Icons.save_outlined,
                                    color: ColorManager.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Text(
                            "Date:     ",
                            style: TextStyle(
                                color: ColorManager.blueFont,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(5),
                                  border: Border.all(color: Colors.blueAccent)),
                              child: Text(formattedDate,
                                  style: const TextStyle(
                                    fontSize: 17,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Text(
                            "Age:      ",
                            style: TextStyle(
                                color: ColorManager.blueFont,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(5),
                                  border: Border.all(color: Colors.blueAccent)),
                              child: Text("$age years old",
                                  style: const TextStyle(
                                    fontSize: 17,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Text(
                            "Gender:",
                            style: TextStyle(
                                color: ColorManager.blueFont,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(5),
                                  border: Border.all(color: Colors.blueAccent)),
                              child: Text(gender,
                                  style: const TextStyle(
                                    fontSize: 17,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Text(
                            "Score:   ",
                            style: TextStyle(
                                color: ColorManager.blueFont,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(5),
                                  border: Border.all(color: Colors.blueAccent)),
                              child: Text("$total",
                                  style: const TextStyle(
                                    fontSize: 17,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Text(
                            "Case:    ",
                            style: TextStyle(
                                color: ColorManager.blueFont,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(5),
                                  border: Border.all(color: Colors.blueAccent)),
                              child: Text(_getinterpretation(),
                                  style: const TextStyle(
                                    fontSize: 17,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Text(
                            "Advice: ",
                            style: TextStyle(
                                color: ColorManager.blueFont,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(5),
                                  border: Border.all(color: Colors.blueAccent)),
                              child: Text(_getMax(),
                                  style: const TextStyle(
                                    fontSize: 17,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                  //
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: 60.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorManager.blue,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CenterLayout()));
                },
                child: const Text('Specialists Recommendations',
                    style: TextStyle(fontSize: 20.0)),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: 60.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorManager.blue,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Screens()));
                },
                child: const Text('Go Home', style: TextStyle(fontSize: 20.0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
