import 'package:autismx/screens/surveys/enums/questionairetypeupdate1.dart';
import 'package:autismx/screens/surveys/models/questionnaire.dart';
import 'package:autismx/screens/surveys/services/adult/qustionaireserviceupdate1.dart';
import 'package:autismx/screens/surveys/surveyes_screens/adult/questionnaire_screen.dart';
import 'package:autismx/shared/local/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AdultAttentionSwith extends StatefulWidget {
  final int score1;
  final String name;
  final String age;
  final String gender;
  const AdultAttentionSwith(
      {Key key,
      @required this.name,
      @required this.age,
      @required this.gender,
      this.score1})
      : super(key: key);

  @override
  _AdultAttentionSwithState createState() => _AdultAttentionSwithState();
}

class _AdultAttentionSwithState extends State<AdultAttentionSwith> {
  List<Questionnaire> questionnaires;
  int index;
  Future<bool> loadAllQuestionnairesFuture;
  Questionnaire questionnaire;
  @override
  void initState() {
    super.initState();

    loadAllQuestionnairesFuture = loadAllQuestionnaires();
  }

  Future<bool> loadAllQuestionnaires() async {
    final questionnaireService = QuestionnaireService();
    questionnaires = [];
    for (QuestionnaireType questionnaireType in QuestionnaireType.values) {
      final questionnaire =
          await questionnaireService.getQuestionnaire(questionnaireType);

      // if something went wrong, stop loading questionnaires
      if (questionnaire == null) {
        return false;
      }

      questionnaires.add(questionnaire);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text(
      //     'Questionnaires',
      //   ),
      // ),
      body: FutureBuilder(
        future: loadAllQuestionnairesFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return Center(
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 20,
                          color: const Color.fromRGBO(236, 240, 243, 1),
                        ),
                        Positioned(
                            child: SvgPicture.asset("assets/images/Path1.svg")),
                        Positioned(
                          top: 0,
                          left: MediaQuery.of(context).size.width * 0.32,
                          child: SizedBox(
                              width: 140,
                              height: 100,
                              child: Image.asset("assets/images/header.png")),
                        ),],),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: [
                        for (Questionnaire questionnaire in questionnaires)
                          InkWell(
                              onTap: () {
                                questionnaire.isActive
                                    ? Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Questionnaire1(
                                            score1: widget.score1,
                                             name: widget.name,
                                    age: widget.age,
                                    gender: widget.gender,
                                            questionnaire: questionnaire,
                                          ),
                                        ),
                                      )
                                    : _showDialog(context);
                              },
                              child: Container(
                              margin: const EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 1),
                                    blurRadius: 5,
                                    color: Colors.black.withOpacity(0.3),
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                questionnaire.image))),
                                  ),
                                  Text(
                                    questionnaire.name,
                                    style: const TextStyle(fontSize: 17,color: ColorManager.greyFont),
                                  )
                                ],
                              ),
                              // Center(
                              //     child: Text(
                              //   questionnaire.name,
                              //   style: const TextStyle(fontSize: 22),
                              // )),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError ||
              (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data == false)) {
            return AlertDialog(
              title: const Text('Ooops something went wrong!'),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Try Again'),
                  onPressed: () => setState(() {
                    loadAllQuestionnairesFuture = loadAllQuestionnaires();
                  }),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        //title: new Text("Alert!"),
        content: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Please Perform Previous Section",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
