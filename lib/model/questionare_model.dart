// To parse this JSON data, do
//
//     final questionareModel = questionareModelFromJson(jsonString);

import 'dart:convert';

QuestionareModel questionareModelFromJson(String str) => QuestionareModel.fromJson(json.decode(str));

String questionareModelToJson(QuestionareModel data) => json.encode(data.toJson());

class QuestionareModel {
  String? question;
  String? answer;
  List<String>? options;
  String? id;

  QuestionareModel({
    this.question,
    this.answer,
    this.options,
    this.id,
  });

  factory QuestionareModel.fromJson(Map<String, dynamic> json) => QuestionareModel(
    question: json["question"],
    answer: json["answer"],
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "id": id,
  };
}
