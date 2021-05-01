import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quizinmobile/util/question.dart';
import 'package:http/http.dart';

class PartieStandard extends StatefulWidget{
  PartieStandard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => PartieStandardState();

}

class PartieStandardState extends State<PartieStandard>{

  dynamic questions;

  Future<String> _makePostRequest(String nbQuestions) async {
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Questions/getQuestions.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Response response = await post(
        url,
        headers: headers,
        body: {
          'nbQuestions': nbQuestions
        }
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Erreur dans la récupération des questions' + response.statusCode.toString());
    }
  }

  Future<void> initQuestions() async {
    questions = jsonDecode(await _makePostRequest('10'));
    /*questions.forEach((key, value) {
      print(value['INTITULE']);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: ElevatedButton(
              child: Text('Demander questions', style: TextStyle(fontSize: 25.0),),
              onPressed: () {
                initQuestions();
              },
            ),
          ),
        ),
      ),
    );
  }

}