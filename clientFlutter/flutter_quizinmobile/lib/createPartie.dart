import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizinmobile/editMdp.dart';
import 'package:flutter_quizinmobile/model/userModel/userModel.dart';
import 'package:flutter_quizinmobile/partieStandard.dart';
import 'package:http/http.dart';

class Categorie {
  final List<String> categ;

  Categorie({this.categ});

  factory Categorie.fromJson(LinkedHashMap<String, dynamic> json) {
    List<String> retour = new List<String>();
    for(int i = 0; i< json.length; i++) {
      retour.add(json["Categorie" + (i+1).toString()]["LIBELLECATEGORIE"]);
    }
    return Categorie(
        categ : retour
    );
  }
}

class Difficulte {
  final List<String> diff;

  Difficulte({this.diff});

  factory Difficulte.fromJson(LinkedHashMap<String, dynamic> json) {
    List<String> retour = new List<String>();
    for(int i = 0; i< json.length; i++) {
      retour.add(json["Difficulte" + (i+1).toString()]["LIBELLEDIFFICULTE"]);
    }
    return Difficulte(
        diff : retour
    );
  }
}

class QuizPerso {
  final List<String> quiz, nbQuestions;

  QuizPerso({this.quiz, this.nbQuestions});

  factory QuizPerso.fromJson(LinkedHashMap<String, dynamic> json) {
    List<String> retour = new List<String>();
    for(int i = 0; i< json.length; i++) {
      retour.add(json["Quiz" + (i+1).toString()]["NOMQUIZ"]);
    }
    List<String> retour2 = new List<String>();
    for(int i = 0; i< json.length; i++) {
      retour2.add(json["Quiz" + (i+1).toString()]["NBQUESTIONSQUIZ"]);
    }
    return QuizPerso(
        quiz : retour,
        nbQuestions: retour2
    );
  }
}

class CreatePartie extends StatefulWidget{
  CreatePartie({Key key, @required this.alea}) : super(key: key);

  final bool alea;

  @override
  State<StatefulWidget> createState() => CreatePartieState(alea: alea);

}

class CreatePartieState extends State<CreatePartie>{

  CreatePartieState({@required this.alea});

  final bool alea;
  final controllerNom = TextEditingController();
  String _chosenValue = "10", _chosenValueCateg = "Toutes", _chosenValueDiff = "Toutes", _chosenValueQuiz, _chosenNbQuestions;

  int getIndexQuiz(List<String> list, String nom){
    int i = 0;
    while(list.elementAt(i) != nom && i < list.length -1){
      i++;
    }
    return i;
  }

  Future<Categorie> getCategorie() async {
    mail = UserModel.getMail();
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Questions/getCategories.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    var response = await post(
        url,
        headers: headers,
        body: {

        }
    );
    if (response.statusCode == 200) {
      return Categorie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.' + response.statusCode.toString());
    }
  }

  Future<Difficulte> getDifficulte() async {
    mail = UserModel.getMail();
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Questions/getDifficultes.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    var response = await post(
        url,
        headers: headers,
        body: {

        }
    );
    if (response.statusCode == 200) {
      return Difficulte.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.' + response.statusCode.toString());
    }
  }

  Future<QuizPerso> getQuizPerso() async {
    mail = UserModel.getMail();
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Utilisateurs/getQuizPersoByUser.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    var response = await post(
        url,
        headers: headers,
        body: {
          'mail': mail
        }
    );
    if (response.statusCode == 200) {
      return QuizPerso.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.' + response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    //Variables de responsivité
    Size screenSize = MediaQuery.of(context).size;

    double widthLogo = screenSize.width*0.8;
    double heightLogo = screenSize.height*0.12;
    double marginLogo = screenSize.height*0.05;
    double widthInput = screenSize.width*0.7;
    double fontSizeInput = screenSize.height*0.035;
    double fontSizeT2 = screenSize.height*0.02;
    double widthButton = screenSize.width*0.85;
    double marginText = screenSize.width * 0.06;
    double marginLeftInput = screenSize.width*0.05;

    getCategorie();

    Widget createAlea(){
      return Container(
        margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
        child : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Nb questions : '
            ),
            Container(
                width: widthButton/6,
                child: DropdownButton<String>(
                    value: _chosenValue,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor:Colors.black,
                    items: <String>[
                      '10',
                      '11',
                      '12',
                      '13',
                      '14',
                      '15',
                      '16',
                      '17',
                      '18',
                      '19',
                      '20'
                    ].map<DropdownMenuItem<String>>((String value) {                              return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style:TextStyle(color:Colors.black),),
                    );
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        _chosenValue = value;
                      });
                    }
                )
            ),
            Container(
                child : Row(
                  children: [
                    Text(
                        'Catégorie : '
                    ),
                    Container(
                        width: widthButton/2,
                        margin: EdgeInsets.fromLTRB(marginText, 0, 0, 0),
                        child: FutureBuilder(
                          future : getCategorie(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              List<DropdownMenuItem<String>> list = new List<DropdownMenuItem<String>>();
                              for(int i = 0; i < snapshot.data.categ.length; i++){
                                list.add(
                                    new DropdownMenuItem(
                                        child: Text(
                                          snapshot.data.categ.elementAt(i),
                                          style: TextStyle(
                                              color:Colors.black
                                          ),
                                        ),
                                        value : snapshot.data.categ.elementAt(i)
                                    )
                                );
                              }
                              list.add(
                                  new DropdownMenuItem(
                                      child: Text(
                                        "Toutes",
                                        style: TextStyle(
                                            color:Colors.black
                                        ),
                                      ),
                                      value : "Toutes"
                                  )
                              );
                              return DropdownButton<String>(
                                  value: _chosenValueCateg,
                                  style: TextStyle(color: Colors.white),
                                  iconEnabledColor:Colors.black,
                                  items: list,
                                  onChanged: (String value) {
                                    setState(() {
                                      _chosenValueCateg = value;
                                    });
                                  }
                              );
                            }
                            return Text("");
                          },
                        )
                    ),
                  ],
                )
            ),
            Container(
                child : Row(
                  children: [
                    Text(
                        'Difficulte : '
                    ),
                    Container(
                        width: widthButton/2,
                        margin: EdgeInsets.fromLTRB(marginText, 0, 0, 0),
                        child: FutureBuilder(
                          future : getDifficulte(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              List<DropdownMenuItem<String>> list2 = new List<DropdownMenuItem<String>>();
                              for(int i = 0; i < snapshot.data.diff.length; i++){
                                list2.add(
                                    new DropdownMenuItem(
                                        child: Text(
                                          snapshot.data.diff.elementAt(i),
                                          style: TextStyle(
                                              color:Colors.black
                                          ),
                                        ),
                                        value : snapshot.data.diff.elementAt(i)
                                    )
                                );
                              }
                              list2.add(
                                  new DropdownMenuItem(
                                      child: Text(
                                        "Toutes",
                                        style: TextStyle(
                                            color:Colors.black
                                        ),
                                      ),
                                      value : "Toutes"
                                  )
                              );
                              return DropdownButton<String>(
                                  value: _chosenValueDiff,
                                  style: TextStyle(color: Colors.white),
                                  iconEnabledColor:Colors.black,
                                  items: list2,
                                  onChanged: (String value) {
                                    setState(() {
                                      _chosenValueDiff = value;
                                    });
                                  }
                              );
                            }
                            return Text("");
                          },
                        )
                    ),
                  ],
                )
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  if(controllerNom.text != ""){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PartieStandard(nomPartie : controllerNom.text, nbQuestions : _chosenValue, difficulte : _chosenValueDiff, categorie : _chosenValueCateg)));
                  }
                  else{
                    showError(context, "Veuillez remplir tous les champs pour créer la partie privée !");
                  }
                },
                child: Text(
                  'Lancer la partie',
                  style: TextStyle
                    (
                      fontSize: fontSizeInput
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget createPerso(){
      return Container(
          width: widthButton,
          margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future : getQuizPerso(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    List<DropdownMenuItem<String>> list = new List<DropdownMenuItem<String>>();
                    for(int i = 0; i < snapshot.data.quiz.length; i++){
                      list.add(
                          new DropdownMenuItem(
                              child: Text(
                                snapshot.data.quiz.elementAt(i),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSizeInput,
                                    color: Colors.black
                                ),
                              ),
                              value : snapshot.data.quiz.elementAt(i)
                          )
                      );
                    }
                    return DropdownButton<String>(
                        value: _chosenValueQuiz,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor:Colors.black,
                        hint: Text(
                          "Choisir un quiz",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontSizeInput,
                              color: Colors.black
                          ),
                        ),
                        items: list,
                        onChanged: (String value) {
                          setState(() {
                            _chosenValueQuiz = value;
                            _chosenNbQuestions = snapshot.data.nbQuestions.elementAt(getIndexQuiz(snapshot.data.quiz,value));
                            log(_chosenNbQuestions);
                          });
                        }
                    );
                  }
                  return Text("");
                },
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if(controllerNom.text != "" && _chosenValueQuiz != null){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PartieStandard(nomPartie : controllerNom.text, nbQuestions : _chosenNbQuestions, difficulte : _chosenValueQuiz, categorie : "")));
                    }
                    else{
                      showError(context, "Veuillez remplir tous les champs pour créer la partie privée !");
                    }
                  },
                  child: Text(
                    'Lancer la partie',
                    style: TextStyle
                      (
                        fontSize: fontSizeInput
                    ),
                  ),
                ),
              )
            ],
          )
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0,marginLogo,0,0),
                child: Image.asset('assets/images/logo_officiel.png',width: widthLogo, height: heightLogo),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(marginLeftInput, marginText*2, 0, marginText*3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text (
                        'Nom de la partie : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeInput/1.3,
                        ),
                      ),
                    ),
                    Container(
                      width: widthInput,
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: fontSizeInput,
                        ),
                        decoration: new InputDecoration(
                          hintText: "Nom partie",
                        ),
                        controller: controllerNom,
                      ),
                    ),
                    alea ? createAlea() : createPerso()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showError(BuildContext context, String err) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      elevation: 0,
      title: Text("Attention"),
      content: Text(err),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}