import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizinmobile/detailsQuiz.dart';
import 'package:flutter_quizinmobile/model/userModel/userModel.dart';
import 'package:flutter_quizinmobile/profilPage.dart';
import 'package:http/http.dart';

class Quiz {
  final LinkedHashMap<String, dynamic> quiz;

  Quiz({this.quiz});

  factory Quiz.fromJson(LinkedHashMap<String, dynamic> json) {
    return Quiz(
      quiz: json,
    );
  }
}

class NewQuestion extends StatefulWidget{
  NewQuestion({Key key, @required this.nomQuiz}) : super(key: key);

  final String nomQuiz;

  NewQuestionState createState() => NewQuestionState(nomQuiz: nomQuiz);

}

class NewQuestionState extends State<NewQuestion> {

  String nomQuiz;

  NewQuestionState({@required this.nomQuiz});

  Color colorNew = Colors.white;
  Color colorRow = Colors.grey;
  Color colorP = Colors.white;
  Color colorE = Colors.white;

  Future<Quiz> _makePostRequest() async {
    mail = UserModel.getMail();
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Questions/getQuestionPersoByUser.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    var response = await post(
        url,
        headers: headers,
        body: {
          'mail': mail,
          'nomQuiz': this.nomQuiz
        }
    );
    if (response.statusCode == 200) {
      return Quiz.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.' + response.statusCode.toString());
    }
  }

  Future<Quiz> getQuestions() async {
    mail = UserModel.getMail();
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Questions/getQuestionNotQuizPerso.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    var response = await post(
        url,
        headers: headers,
        body: {
          'nomQuiz': this.nomQuiz
        }
    );
    if (response.statusCode == 200) {
      return Quiz.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.' + response.statusCode.toString());
    }
  }

  Future<String> addNewQuestionPerso(String intitule, String reponses, String nbVie, String tpsRep) async {
    mail = UserModel.getMail();
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Utilisateurs/addNewQuestionsQuizPerso.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    var response = await post(
        url,
        headers: headers,
        body: {
          'mail': mail,
          'nbReponsesMax': nbVie,
          'tempsReponse': tpsRep,
          'intitule': intitule,
          'reponses':reponses,
          'nomQuiz': this.nomQuiz
        }
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create user.' + response.statusCode.toString());
    }
  }

  Future<String> addQuestion(String intitule, String qPerso) async {
    mail = UserModel.getMail();
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Utilisateurs/addQuestionsQuizPerso.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    var response = await post(
        url,
        headers: headers,
        body: {
          'mail': mail,
          'intitule': intitule,
          'qPerso': qPerso,
          'nomQuiz': this.nomQuiz
        }
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create user.' + response.statusCode.toString());
    }
  }

  Widget wid = Text("");
  String _chosenValue, _chosenValueTps;

  final myControllerIntitule= TextEditingController();
  final myControllerReponses= TextEditingController();

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double widthLogo = screenSize.width * 0.8;
    double heightLogo = screenSize.height * 0.12;
    double standard = screenSize.width * 0.06;
    double widthButton = screenSize.width*0.85;
    double widthIntitule = screenSize.width*0.45;
    double widthReponse = screenSize.width*0.25;
    double widthVie = screenSize.width*0.125;
    double widthTps = screenSize.width*0.125;
    double marginText = screenSize.width * 0.06;
    double marginImageTop = screenSize.height * 0.05;
    double paddingWidget = screenSize.width * 0.01;
    double fontSizeInput = screenSize.height*0.03;
    double fontSizeText = screenSize.height*0.027;

    Widget _createWidgetNew(){
      return Container(
        margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Question : '
            ),
            Container(
              width: widthButton,
              child: TextFormField(
                controller: myControllerIntitule,
                style: TextStyle(
                  fontSize: fontSizeInput,
                ),
                decoration: new InputDecoration(
                  hintText: "Nouvelle question",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, marginText*2, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Réponse(s) : '
                  ),
                  Container(
                    width: widthButton,
                    child: TextFormField(
                      controller: myControllerReponses,
                      style: TextStyle(
                        fontSize: fontSizeInput,
                      ),
                      decoration: new InputDecoration(
                        hintText: "Réponse(s)",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, marginText*2, 0, 0),
              width: widthButton,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Nb vie(s) max : '
                      ),
                      Container(
                          width: widthButton/4,
                          child: DropdownButton<String>(
                              value: _chosenValue,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor:Colors.black,
                              items: <String>[
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                              ].map<DropdownMenuItem<String>>((String value) {                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style:TextStyle(color:Colors.black),),
                              );
                              }).toList(),
                              hint:Text(
                                "Vie(s)",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _chosenValue = value;
                                  wid = _createWidgetNew();
                                });
                              }
                          )
                      ),
                    ],
                  ),
                  Container(
                    child : Column(
                      children: [
                        Text(
                            'Temps réponse : '
                        ),
                        Container(
                            width: widthButton/4,
                            child: DropdownButton<String>(
                                value: _chosenValueTps,
                                underline: SizedBox(),
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
                                  '18'
                                ].map<DropdownMenuItem<String>>((String value) {                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style:TextStyle(color:Colors.black),),
                                );
                                }).toList(),
                                hint:Text(
                                  "Temps",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,),
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    _chosenValueTps = value;
                                    wid = _createWidgetNew();
                                  });
                                }
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  if(myControllerIntitule.text != "" && myControllerReponses.text != "" && _chosenValue != null && _chosenValueTps != null){
                    addNewQuestionPerso(myControllerIntitule.text, myControllerReponses.text, _chosenValue, _chosenValueTps);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/profilPage');
                    Navigator.pushNamed(context, '/quizPerso');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsQuiz(nomQuiz : this.nomQuiz)));
                  }
                  else{
                    showError(context, "Veuillez remplir tous les champs pour ajouter une nouvelle question personnalisée !");
                  }
                },
                child: Text(
                  'Ajouter',
                  style: TextStyle
                    (
                      fontSize: fontSizeText
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget _createQuestionPerso(String intitule, String reponses, String nbVies, String tpsReponse, int index, int taille){
      return Container(
        child: GestureDetector(
          onTap: (){
            showChoice(context, intitule, "true");
          },
          child: Container(
              decoration: index == (taille-2) ? BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3.0,
                ),
                color: colorNew,
              ) : BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                  left: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                  top: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                ),
                color: colorNew,
              ),
              child : Row(
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(0, paddingWidget*4, 0, paddingWidget*4),
                      width: widthIntitule,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.black,
                            width: 3.0,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      child : GestureDetector(
                        onTap: () {
                          showQuestion(context, intitule);
                        },
                        child: Text(
                          intitule,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      )
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, paddingWidget*4, 0, paddingWidget*4),
                    width: widthReponse,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                      color: colorNew,
                    ),
                    child : GestureDetector(
                        onTap: () {
                          showReponses(context, reponses);
                        },
                        child : Text(
                          reponses,
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                    ),
                  ),
                  Container(
                      width: widthVie,
                      padding: EdgeInsets.fromLTRB(0, paddingWidget*4, 0, paddingWidget*4),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.black,
                            width: 3.0,
                          ),
                        ),
                        color: colorNew,
                      ),
                      child : Center(child: Text(nbVies))
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, paddingWidget*4, 0, paddingWidget*4),
                      width: widthTps,
                      child : Center(child: Text(tpsReponse))
                  ),
                ],
              )
          ),
        ),
      );
    }

    Widget _createWidgetPerso(){
      return Container(
        margin: EdgeInsets.fromLTRB(0, marginText*2, 0, 0),
        child: Column(
          children: [
            Text(
                "Vos différentes questions personnalisées : "
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                color: colorNew,
              ),
              child: Row(
                children: [
                  Container(
                      width: widthIntitule,
                      padding: EdgeInsets.fromLTRB(0, paddingWidget, 0, paddingWidget),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.black,
                            width: 3.0,
                          ),
                        ),
                        color: colorNew,
                      ),
                      child : Text(
                        "Intitule",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, paddingWidget, 0, paddingWidget),
                      width: widthReponse,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.black,
                            width: 3.0,
                          ),
                        ),
                        color: colorNew,
                      ),
                      child : Text(
                        "Réponse(s)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                  Container(
                    width: widthVie,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                      color: colorNew,
                    ),
                    child : Icon(
                        Icons.favorite
                    ),
                  ),
                  Container(
                    width: widthTps,
                    child : Icon(
                        Icons.access_time_outlined
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: FutureBuilder(
                  future: _makePostRequest(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.quiz["Question0"]["RIEN"] == "rien" && snapshot.data.quiz.length == 1) {

                      }
                      else {
                        return ListView.builder(
                            primary: false,
                            itemCount: snapshot.data.quiz.length - 1,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return _createQuestionPerso(
                                  snapshot.data.quiz["Question" +
                                      (index + 1)
                                          .toString()]["INTITULE"],
                                  snapshot.data.quiz["Question" +
                                      (index + 1)
                                          .toString()]["REPONSES"],
                                  snapshot.data.quiz["Question" +
                                      (index + 1)
                                          .toString()]["NBREPONSESMAX"],
                                  snapshot.data.quiz["Question" +
                                      (index + 1)
                                          .toString()]["TEMPSREPONSE"],
                                  index,
                                  snapshot.data.quiz.length);
                            });
                      }
                    }else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Text("");
                  }
              ),
            ),
          ],
        ),
      );
    }

    Widget _createQuestion(String intitule, String reponses, String nbVies, int index, int taille){
      return Container(
        child: GestureDetector(
          onTap: (){
            showChoice(context, intitule, "false");
          },
          child: Container(
              decoration: index == (taille-2) ? BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3.0,
                ),
                color: colorNew,
              ) : BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                  left: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                  top: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                ),
                color: colorNew,
              ),
              child : Row(
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(0, paddingWidget*4, 0, paddingWidget*4),
                      width: widthIntitule,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.black,
                            width: 3.0,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      child : GestureDetector(
                        onTap: () {
                          showQuestion(context, intitule);
                        },
                        child: Text(
                          intitule,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      )
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, paddingWidget*4, 0, paddingWidget*4),
                    width: widthReponse,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                      color: colorNew,
                    ),
                    child : GestureDetector(
                        onTap: () {
                          showReponses(context, reponses);
                        },
                        child : Text(
                          reponses,
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                    ),
                  ),
                  Container(
                      width: widthVie,
                      padding: EdgeInsets.fromLTRB(0, paddingWidget*4, 0, paddingWidget*4),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.black,
                            width: 3.0,
                          ),
                        ),
                        color: colorNew,
                      ),
                      child : Center(child: Text(nbVies))
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, paddingWidget*4, 0, paddingWidget*4),
                      width: widthTps,
                      child : Center(child: Text('15'))
                  ),
                ],
              )
          ),
        ),
      );
    }

    Widget _createWidgetExistante(){
      return Container(
        margin: EdgeInsets.fromLTRB(0, marginText*2, 0, 0),
        child: Column(
          children: [
            Text(
                "Vos différentes questions personnalisées : "
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                color: colorNew,
              ),
              child: Row(
                children: [
                  Container(
                      width: widthIntitule,
                      padding: EdgeInsets.fromLTRB(0, paddingWidget, 0, paddingWidget),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.black,
                            width: 3.0,
                          ),
                        ),
                        color: colorNew,
                      ),
                      child : Text(
                        "Intitule",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, paddingWidget, 0, paddingWidget),
                      width: widthReponse,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.black,
                            width: 3.0,
                          ),
                        ),
                        color: colorNew,
                      ),
                      child : Text(
                        "Réponse(s)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                  Container(
                    width: widthVie,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                      color: colorNew,
                    ),
                    child : Icon(
                        Icons.favorite
                    ),
                  ),
                  Container(
                    width: widthTps,
                    child : Icon(
                        Icons.access_time_outlined
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: FutureBuilder(
                  future: getQuestions(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.quiz["Question0"]["RIEN"] == "rien" && snapshot.data.quiz.length == 1) {

                      }
                      else {
                        return ListView.builder(
                            primary: false,
                            itemCount: snapshot.data.quiz.length - 1,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return _createQuestion(
                                  snapshot.data.quiz["Question" +
                                      (index + 1)
                                          .toString()]["INTITULE"],
                                  snapshot.data.quiz["Question" +
                                      (index + 1)
                                          .toString()]["REPONSES"],
                                  snapshot.data.quiz["Question" +
                                      (index + 1)
                                          .toString()]["NBREPONSESMAX"],
                                  index,
                                  snapshot.data.quiz.length);
                            });
                      }
                    }else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Text("");
                  }
              ),
            ),
          ],
        ),
      );
    }


    return Scaffold(
      body : SingleChildScrollView(
        child : Container(
          child : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, marginImageTop, 0, 0),
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/logo_officiel.png',
                        width : widthLogo,
                        height: heightLogo,

                      )
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, marginText, 0, marginText/2),
                    child: Text(
                      'Nouvelle question : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: standard
                      ),
                    ),
                  ),
                  Container(
                    width: screenSize.width,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              colorNew = Colors.grey;
                              colorP = Colors.white;
                              colorE = Colors.white;
                              wid = _createWidgetNew();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(paddingWidget),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 3,
                              ),
                              color: colorNew,
                            ),
                            child: Text(
                                'Nouvelle question'
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              colorP = Colors.grey;
                              colorNew = Colors.white;
                              colorE = Colors.white;
                              wid = _createWidgetPerso();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(paddingWidget),
                            decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.black,
                                    width: 3.0,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 3.0,
                                  ),
                                ),
                                color: colorP
                            ),
                            child: Text(
                                'Question perso'
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              colorE = Colors.grey;
                              colorNew = Colors.white;
                              colorP = Colors.white;
                              wid = _createWidgetExistante();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(paddingWidget),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                ),
                                color: colorE
                            ),
                            child: Text(
                                'Question existante'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  wid
                ],
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

  showQuestion(BuildContext context, String intitule) {

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
      title: Text("Question : "),
      content: Text(intitule),
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

  showReponses(BuildContext context, String reponses) {

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
      title: Text("Question : "),
      content: Text(reponses),
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

  showChoice(BuildContext context, String intitule, String qPerso) {

    // set up the button
    Widget yesButton = FlatButton(
      child: Text("Oui"),
      onPressed: () {
        addQuestion(intitule, qPerso);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.pushNamed(context, '/profilPage');
        Navigator.pushNamed(context, '/quizPerso');
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsQuiz(nomQuiz : this.nomQuiz)));
      },
    );

    Widget noButton = FlatButton(
      child: Text("Non"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      elevation: 0,
      title: Text("Êtes-vous sûr de vouloir ajoute la question suivante dans votre quiz : "),
      content: Text(intitule),
      actions: [
        yesButton,
        noButton
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