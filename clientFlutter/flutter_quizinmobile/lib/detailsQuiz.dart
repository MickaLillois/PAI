import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizinmobile/model/userModel/userModel.dart';
import 'package:flutter_quizinmobile/profilPage.dart';
import 'package:http/http.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Quiz {
  final LinkedHashMap<String, dynamic> quiz;

  Quiz({this.quiz});

  factory Quiz.fromJson(LinkedHashMap<String, dynamic> json) {
    return Quiz(
      quiz: json,
    );
  }
}

class DetailsQuiz extends StatefulWidget{
  DetailsQuiz({Key key, @required this.nomQuiz}) : super(key: key);

  final String nomQuiz;

  DetailsQuizState createState() => DetailsQuizState(nomQuiz: nomQuiz);

}

class DetailsQuizState extends State<DetailsQuiz> {
  String nomQuiz;

  DetailsQuizState({@required this.nomQuiz});

  Future<Quiz> _makePostRequest() async {
    mail = UserModel.getMail();
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Utilisateurs/getQuestionsByQuizPerso.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Response response = await post(
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

  Future<String> _deleteQuiz(String nomQuiz) async {
    mail = UserModel.getMail();
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Utilisateurs/deleteQuizPerso.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Response response = await post(
        url,
        headers: headers,
        body: {
          'mail': mail,
          'nomQuiz': nomQuiz
        }
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete quiz.' + response.statusCode.toString());
    }
  }

  Future<String> _deleteQuestion(String nomQuiz, String intitule, String qPerso) async {
    mail = UserModel.getMail();
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Utilisateurs/deleteQuestionQuizPerso.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Response response = await post(
        url,
        headers: headers,
        body: {
          'mail': mail,
          'nomQuiz': nomQuiz,
          'intitule': intitule,
          'qPerso': qPerso
        }
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete quiz.' + response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double sizeAvatar = screenSize.width * 0.3;
    double widthLogo = screenSize.width * 0.8;
    double heightLogo = screenSize.height * 0.12;
    double standard = screenSize.width * 0.06;
    double standard2 = screenSize.width * 0.045;
    double standard3 = screenSize.width * 0.038;
    double widthButton = screenSize.width*0.85;
    double marginText = screenSize.width * 0.06;
    double marginImageTop = screenSize.height * 0.05;
    double heightButton = screenSize.height * 0.045;

    Widget _createStarsDifficulty(String difficulte){
      Widget wid = Text('oui');
      switch(difficulte){
        case "Facile":
          wid = Container(
            child: Icon(
                Icons.star
            ),
          );
          break;
        case "Moyen":
          wid = Row(
            children: [
              Container(
                child: Icon(
                    Icons.star
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(marginText/3, 0, 0, 0),
                child: Icon(
                    Icons.star
                ),
              ),
            ],
          );
          break;
        case "Difficile":
          wid = Row(
            children: [
              Container(
                child: Icon(
                    Icons.star
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(marginText/3, 0, 0, 0),
                child: Icon(
                    Icons.star
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(marginText/3, 0, 0, 0),
                child: Icon(
                    Icons.star
                ),
              ),
            ],
          );
          break;
        case "Expert":
          wid = Row(
            children: [
              Container(
                child: Icon(
                    Icons.star
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(marginText/3, 0, 0, 0),
                child: Icon(
                    Icons.star
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(marginText/3, 0, 0, 0),
                child: Icon(
                    Icons.star
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(marginText/3, 0, 0, 0),
                child: Icon(
                    Icons.star
                ),
              ),
            ],
          );
          break;
        default:
          wid = Row(
            children: [
              Container(
                child: Icon(
                    Icons.star_border
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(marginText/3, 0, 0, 0),
                child: Text(
                  'Perso',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: standard2
                  ),
                ),
              ),
            ],
          );
          break;
      }
      return wid;
    }

    Widget _createContainerQuestion(String intitule, String difficulte, String categorie, String reponses, String nbReponses, String tempsReponse){
      return Container(
        padding: EdgeInsets.all(16),
        width: screenSize.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text : TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text : 'Question : ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: standard2
                        ),
                      ),
                      TextSpan(
                        text : '$intitule',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: standard3
                        ),
                      ),
                    ]
                )
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
              child: RichText(
                  text : TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text : 'Réponse(s) : ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: standard2
                          ),
                        ),
                        TextSpan(
                          text : '$reponses',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: standard3
                          ),
                        ),
                      ]
                  )
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
                child : Row(
                    children: [
                      Icon(
                          Icons.favorite
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(marginText/3, 0, 0, 0),
                        child: Text(
                            nbReponses,
                            style : TextStyle(
                                fontWeight : FontWeight.bold
                            )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(marginText*2, 0, 0, 0),
                        child: Icon(
                            Icons.access_time_outlined
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(marginText/3, 0, 0, 0),
                        child: Text(
                            tempsReponse != null ? tempsReponse : "15",
                            style : TextStyle(
                                fontWeight : FontWeight.bold
                            )
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(marginText*2, 0, 0, 0),
                          child: _createStarsDifficulty(difficulte)
                      ),
                    ]
                )
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Détail du quiz : $nomQuiz',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: standard
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            onPressed: () {
                              showDialogDelete(context, this.nomQuiz);
                            },
                            icon : Icon(
                                Icons.delete
                            ),
                          ),
                        )
                      ],

                    ),
                  ),
                  FutureBuilder(
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
                                  return StickyHeader(
                                      header: Container(
                                        decoration: BoxDecoration(
                                            border: index != 0 ? Border(
                                              left: BorderSide( //                   <--- left side
                                                color: Colors.black,
                                                width: 3.0,
                                              ),
                                              right: BorderSide( //                   <--- left side
                                                color: Colors.black,
                                                width: 3.0,
                                              ),
                                            ) : Border(
                                              left: BorderSide( //                   <--- left side
                                                color: Colors.black,
                                                width: 3.0,
                                              ),
                                              top: BorderSide( //                    <--- top side
                                                color: Colors.black,
                                                width: 3.0,
                                              ),
                                              right: BorderSide( //                   <--- left side
                                                color: Colors.black,
                                                width: 3.0,
                                              ),
                                            )
                                        ),
                                        height: 50.0,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(
                                                'Question n°' +
                                                    (index + 1).toString(),
                                                style: TextStyle(
                                                    fontSize: standard2
                                                )
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    child: snapshot.data
                                                        .quiz["Question" +
                                                        (index + 1)
                                                            .toString()]["LIBELLEDIFFICULTE"] ==
                                                        "Perso" ? IconButton(
                                                      onPressed: () {
                                                      },
                                                      icon : Icon(
                                                          Icons.edit
                                                      ),
                                                    ) : Text("")
                                                ),
                                                Container(
                                                    child: IconButton(
                                                      onPressed: () {
                                                        showDeleteQuestion(context, nomQuiz, snapshot.data.quiz["Question" + (index + 1).toString()]["INTITULE"], snapshot.data.quiz["Question" + (index + 1).toString()]["LIBELLEDIFFICULTE"] == "Perso" ? "true" : "false");
                                                      },
                                                      icon: Icon(
                                                          Icons.delete
                                                      ),
                                                    )
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      content: _createContainerQuestion(
                                          snapshot.data.quiz["Question" +
                                              (index + 1)
                                                  .toString()]["INTITULE"],
                                          snapshot.data.quiz["Question" +
                                              (index + 1)
                                                  .toString()]["LIBELLEDIFFICULTE"],
                                          snapshot.data.quiz["Question" +
                                              (index + 1)
                                                  .toString()]["LIBELLECATEGORIE"],
                                          snapshot.data.quiz["Question" +
                                              (index + 1)
                                                  .toString()]["REPONSES"],
                                          snapshot.data.quiz["Question" +
                                              (index + 1)
                                                  .toString()]["NBREPONSESMAX"],
                                          snapshot.data.quiz["Question" +
                                              (index + 1)
                                                  .toString()]["TEMPSREPONSE"])
                                  );
                                });
                          }
                        }else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return Text("");
                      }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton : FloatingActionButton(
        onPressed: () => {
          Navigator.pushNamed(context, '/newQuestion'),
        },
        tooltip: 'Nouvelle question',
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  showDialogDelete(BuildContext context, String nomQuiz) {

    // set up the button
    Widget yesButton = FlatButton(
      child: Text("Oui"),
      onPressed: () {
        _deleteQuiz(nomQuiz);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.pushNamed(context, '/quizPerso');
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
      title: Text("Information"),
      content: Text("Voulez-vous vraiment supprimer ce quiz personnalisé ?"),
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

  showDeleteQuestion(BuildContext context, String nomQuiz, String intitule, String qPerso) {

    // set up the button
    Widget yesButton = FlatButton(
      child: Text("Oui"),
      onPressed: () {
        _deleteQuestion(nomQuiz, intitule, qPerso);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.pushNamed(context, '/profilPage');
        Navigator.pushNamed(context, '/quizPerso');
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsQuiz(nomQuiz : nomQuiz)));
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
      title: Text("Information"),
      content: Text("Voulez-vous vraiment supprimer cette question ?"),
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