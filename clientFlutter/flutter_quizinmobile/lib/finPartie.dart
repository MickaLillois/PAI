import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

    //Variables de responsivité
    Size screenSize = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    double widthLogo = screenSize.width*0.8;
    double heightLogo = screenSize.height*0.12;
    double marginLogo = screenSize.height*0.05;
    double paddingInput = screenSize.height*0.02;
    double widthInput = screenSize.width*0.7;
    double widthInput2 = screenSize.width*0.9;
    double widthInputIcon = screenSize.width*0.2;
    double iconSize = screenSize.width*0.2;
    double fontSizeInput = screenSize.height*0.035;
    double fontSizeT1 = screenSize.height*0.025;
    double marginNumQ =screenSize.height*0.02;

    return Scaffold(
      body:SingleChildScrollView(
        child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0,marginLogo,0,marginLogo),
                  child: Image.asset(
                    'assets/images/logo_officiel.png',
                    width : widthLogo,
                    height: heightLogo,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(0,0,0,paddingInput/2),
                  width: screenSize.width*0.98,
                  height: screenSize.height*0.07,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                  child: Text("Score : $score / $scoreMax",style: TextStyle(
                    fontSize: fontSizeInput,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ), ),
                ),
                Container(
                  child: ElevatedButton(
                    child: Text('Quitter', style: TextStyle(fontSize: 25.0),),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  ),
                ),
                Container(
                    width: screenSize.width*0.98,
                    child: ListView.builder(
                      primary: false,
                      itemCount: questions.length,
                      shrinkWrap: true,
                      itemBuilder: (context, int index){
                        return Container(
                            margin : EdgeInsets.fromLTRB(0,marginLogo/8,0,marginLogo/8),
                            height: screenSize.height*0.3,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text('Question n°${index + 1}',style: TextStyle(fontSize: fontSizeT1, fontWeight: FontWeight.bold),),
                                Text('${questions["Question${index + 1}"]['INTITULE']}\n',style: TextStyle(fontSize: fontSizeT1),),
                                Text('Réponses : ${questions["Question${index + 1}"]['REPONSES']}',style: TextStyle(fontSize: fontSizeT1),),
                              ],
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 3,
                              ),
                            )
                        );
                      },
                    )

                ),
              ],
            )
        ),
      ),
    );
  }

}