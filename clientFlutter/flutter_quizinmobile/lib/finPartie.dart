import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quizinmobile/signalerQuestion.dart';

class FinPartieStandard extends StatefulWidget{
  int score;
  int scoreMax;
  HashMap<String, HashMap<String,String>> questions;
  FinPartieStandard({Key key,@required this.score, @required this.scoreMax, @required this.questions,}) : super(key: key);

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
    double fontSizeInput = screenSize.height*0.035;
    double fontSizeT1 = screenSize.height*0.025;


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
                            height: screenSize.height*0.35,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text('Question n°${index + 1}',style: TextStyle(fontSize: fontSizeT1, fontWeight: FontWeight.bold),),
                                Text('${questions["Question${index + 1}"]['INTITULE']}\n',style: TextStyle(fontSize: fontSizeT1),),
                                Text('Réponses : ${questions["Question${index + 1}"]['REPONSES']}',style: TextStyle(fontSize: fontSizeT1),),
                                questions["Question${index + 1}"]['DIFFICULTE'] == "Perso" ? Text(
                                    ""
                                ) :
                                Container(
                                  margin : EdgeInsets.fromLTRB(0,marginLogo/3,0,0),
                                  child: ElevatedButton(
                                    child: Text(
                                      'Signaler la question',
                                      style: TextStyle(
                                          fontSize: fontSizeInput
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignalerQuestion(intitule : questions["Question${index + 1}"]['INTITULE'])));
                                    },
                                  ),
                                ),
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

showAlertDialog(BuildContext context, int nbVie, int scoreManche, String reponses, String result) {
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    elevation: 0,
    title: Text(result, style: TextStyle(fontSize: 25.0)),
    content: Text("Les bonnes réponses étaient :\n$reponses \nVous avez gagné $nbVie points sur $scoreManche possible.", style: TextStyle(fontSize: 20.0)),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}