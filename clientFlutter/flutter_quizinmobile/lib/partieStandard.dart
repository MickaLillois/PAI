import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quizinmobile/finPartie.dart';
import 'package:flutter_quizinmobile/model/userModel/userModel.dart';
import 'package:http/http.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class PartieStandard extends StatefulWidget{
  PartieStandard({Key key, this.nbQuestions, this.difficulte, this.categorie, this.nomPartie}) : super(key: key);

  final String nbQuestions, difficulte, categorie, nomPartie;

  @override
  State<StatefulWidget> createState() => PartieStandardState(nbQuestions: this.nbQuestions, difficulte: this.difficulte, categorie: this.categorie, nomPartie: this.nomPartie);

}

class PartieStandardState extends State<PartieStandard>{
  String nbQuestions, difficulte, categorie, nomPartie;

  PartieStandardState({Key key, this.nbQuestions, this.difficulte, this.categorie, this.nomPartie});

  int cpt=1;
  HashMap<String, HashMap<String,String>> questions;
  final myControllerRep = TextEditingController();
  bool initG=false;
  int nbVie;
  int score=0;
  int scoreMax=0;

  Future<String> _makePostRequest(String nbQuestions, String difficulte, String categorie) async {
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Questions/getQuestions.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Response response = await post(
        url,
        headers: headers,
        body: {
          'nbQuestions': nbQuestions,
          'difficulte': difficulte,
          'categorie': categorie,
          'mail': UserModel.getMail()
        }
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Erreur dans la récupération des questions' + response.statusCode.toString());
    }
  }

  Future<String> _makePostRequest2( String scorePartie, String txBR, String scoreMax) async {
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Stats/updateStatsStandard.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Response response = await post(
        url,
        headers: headers,
        body: {
          'user': UserModel.getMail(),
          'scPart': scorePartie,
          'TmpRepMoy': '0',
          'txBonRep': txBR,
          'nbQue': scoreMax,
          'ptsUs' : (int.parse(scorePartie)*2).toString(),
          'clmt' : '0'
        }
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Erreur dans la récupération des questions' + response.statusCode.toString());
    }
  }

  String getInfo(String key){
    String txt = questions["Question$cpt"][key];
    print(txt);
    //cpt++;
    return txt;
  }

  Future<void> initQuestions() async {
    if(!initG) {
      var questionsTmp = jsonDecode(await _makePostRequest(nbQuestions, difficulte, categorie));
      questionsTmp.forEach((key, value) {
        print(key);
      });
      HashMap<String, HashMap<String, String>> attributs = new HashMap.from(
          questionsTmp.map(
                  (key, value) {
                HashMap<String, String> attrs = new HashMap.from(value.map(
                        (key2, value2) {
                      return MapEntry(key2.toString(), value2.toString());
                    }
                ));
                return MapEntry(
                    key.toString(),
                    attrs
                );
              }
          ));
      questions = attributs;
      nbVie=int.parse(getInfo('NBREPONSESMAX'));

      /*questions.forEach((key, value) {
      print (key);
    });*/

      print(questions);
      print('init good');
      initG=true;
    }
  }

  /*@override
  void initState() {
    initQuestions();
    //nbVie=int.parse(getInfo('NBREPONSESMAX'));
    Future.delayed(const Duration(seconds: 2), (){});
    super.initState();
  }*/



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
    double fontSizeT1 = screenSize.height*0.045;
    double marginNumQ =screenSize.height*0.02;

    //autres variables
    //int nbVie=3;


    return Scaffold(
      body: FutureBuilder(
        future: initQuestions(),
        builder: (context, snapshot) {
          if (questions==null) {
            return Center(child:Text("Chargement...",style: TextStyle(fontSize: fontSizeT1/1.1),));
          }
          else {return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [

                  Container(
                    margin: nomPartie == "" ? EdgeInsets.fromLTRB(0,marginLogo,0,marginLogo) : EdgeInsets.fromLTRB(0,marginLogo,0,0),
                    child: Image.asset('assets/images/logo_officiel.png',width: widthLogo, height: heightLogo),
                  ),
                  nomPartie != "" ? Container(
                      margin : EdgeInsets.fromLTRB(0,marginLogo/4,0,marginLogo/4),
                      child : Text(
                        nomPartie,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: fontSizeInput,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ) : Text(""),
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
                    width: screenSize.width*0.98,
                    height: screenSize.height*0.55,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(0,marginNumQ,0,marginNumQ),
                            child: Text('Question n°$cpt',style: TextStyle(fontSize: fontSizeT1),)
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(0,marginNumQ,0,marginNumQ),
                            child: Text(getInfo('INTITULE'),style: TextStyle(fontSize: fontSizeT1),)
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              Text(nbVie.toString(),style: TextStyle(fontSize: fontSizeT1/1.1),),
                              Icon(CupertinoIcons.heart_fill,
                                size: iconSize/2,),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: widthInput2,
                    child: Row(
                      children: [
                        Container(
                          width: widthInput,
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: fontSizeInput,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Entrez votre réponse',
                              contentPadding: EdgeInsets.fromLTRB(0,paddingInput,0,paddingInput),
                            ),
                            controller: myControllerRep,
                          ),
                        ),
                        Container(
                          width: widthInputIcon,
                          child: IconButton(
                              icon: const Icon(Icons.check_box),
                              color: Colors.black,
                              iconSize: iconSize,
                              onPressed: () async{
                                List<String> reps=getInfo('REPONSES').toUpperCase().split('/');
                                if(myControllerRep.text==""){
                                  //il se passe rien woulah
                                }else if(reps.contains(myControllerRep.text.toUpperCase())){
                                  print('cest bieng');
                                  if(cpt.toString()==nbQuestions){
                                    scoreMax=scoreMax+1;
                                    score=score+1;
                                    await _makePostRequest2(score.toString(),(score/scoreMax).toString(), scoreMax.toString());
                                    Navigator.of(context).pop();
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => FinPartieStandard(score: score, scoreMax: scoreMax, questions: questions)));
                                  }else{
                                    setState(() {
                                      showAlertDialog(context,1,1,getInfo('REPONSES'),"Gagné !");
                                      scoreMax=scoreMax+1;
                                      cpt ++;
                                      score=score+1;
                                      nbVie=int.parse(getInfo('NBREPONSESMAX'));
                                    });
                                  }
                                  myControllerRep.clear();
                                }else{
                                  if(nbVie==1){
                                    if(cpt.toString()==nbQuestions){
                                      scoreMax = scoreMax +1;
                                      Navigator.of(context).pop();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => FinPartieStandard(score: score, scoreMax: scoreMax, questions: questions)));
                                    }else {
                                      setState(() {
                                        showAlertDialog(context, 0,
                                            1,
                                            getInfo('REPONSES'), "Perdu !");
                                        scoreMax = scoreMax +
                                            1;
                                        cpt ++;
                                        nbVie =
                                            int.parse(getInfo('NBREPONSESMAX'));
                                      });
                                    }
                                  }else{
                                    setState(() {
                                      nbVie --;
                                    });
                                  }
                                  myControllerRep.clear();
                                  print('cest pas bieng');
                                }

                              }
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );}

        },),
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