

import 'package:autism_perdiction_app/view/gamification/storylines/txt/dailychallenge_txt.dart';

String questionFromIndex(int index) {
  String question = "";
  switch (index) {
    case 1:
      question = dailychallenge_question1;
      break;
    case 2:
      question = dailychallenge_question2;
      break;
    case 3:
      question = dailychallenge_question3;
      break;
    case 4:
      question = dailychallenge_question4;
      break;
    default:
      question = dailychallenge_question1;
  }
  return question;
}

List<String> optionsFromIndex(int index) {
  List<String> options = [];
  switch (index) {
    case 1:
      options = dailychallenge_options1;
      break;
    case 2:
      options = dailychallenge_options2;
      break;
    case 3:
      options = dailychallenge_options3;
      break;
    case 4:
      options = dailychallenge_options4;
      break;
    default:
      options = dailychallenge_options1;
  }
  return options;
}
