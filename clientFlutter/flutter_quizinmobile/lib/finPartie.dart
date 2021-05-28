import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinPartieStandard extends StatefulWidget{
  int score;
  int scoreMax;
  HashMap<String, HashMap<String,String>> questions;
  FinPartieStandard({Key key,@required this.score, @required this.scoreMax, @required this.questions}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FinPartieStandardState(score: score, scoreMax: scoreMax, questions: questions);

}

class FinPartieStandardState extends State<FinPartieStandard> {
  int score;
  int scoreMax;
  HashMap<String, HashMap<String,String>> questions;

  FinPartieStandardState({@required this.score, @required this.scoreMax, @required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Score : $score / $scoreMax"),
    );
  }

}