import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizPerso extends StatefulWidget{
  QuizPerso({Key key, this.title}) : super(key: key);

  final String title;

  QuizPersoState createState() => QuizPersoState();

}

class QuizPersoState extends State<QuizPerso> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SingleChildScrollView(
        child : Container(
          child : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/logo_png.png',
                        width : 500,
                        height: 100,
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}