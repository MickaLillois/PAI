import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

String mail = 'ruru4.matt@gmail.com';

Future<Quiz> _makePostRequest() async {
  Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Utilisateurs/getQuizPersoByUser.php');
  Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
  };
  Response response = await post(
      url,
      headers: headers,
      body: {'mail': mail}
  );
  if (response.statusCode == 200) {
    return Quiz.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create user.' + response.statusCode.toString());
  }
}

class Quiz {
  final LinkedHashMap<String, dynamic> quiz;

  Quiz({this.quiz});

  factory Quiz.fromJson(LinkedHashMap<String, dynamic> json) {
    return Quiz(
      quiz: json,
    );
  }
}

class QuizPerso extends StatefulWidget{
  QuizPerso({Key key, this.title}) : super(key: key);

  final String title;

  QuizPersoState createState() => QuizPersoState();

}

class QuizPersoState extends State<QuizPerso> {
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
    double heightButton = screenSize.height * 0.15;
    double paddingWidget = screenSize.width * 0.05;

    Widget _createQuiz(BuildContext context, String nomQuiz, String nbQuestions)
    {
      return GestureDetector(
        onTap:(){
          Navigator.pushNamed(context, '/detailsQuiz');
        },
        child : Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                nomQuiz,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: standard
                ),
              ),
              Text(
                nbQuestions == "1" ? nbQuestions + " question" : nbQuestions + " questions",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: standard2
                ),
              ),
            ],
          ),
          padding: EdgeInsets.all(paddingWidget),
          margin: EdgeInsets.fromLTRB(0, marginText*2, 0, 0),
          width: widthButton,
          height: heightButton,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
            borderRadius: BorderRadius.all(
                Radius.circular(10.0)
            ),
          ),
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
                      'Mes quiz personnalisés',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: standard
                      ),
                    ),
                  ),
                  Container(
                    width: widthButton,
                    child: FutureBuilder(
                      future: _makePostRequest(),
                      builder: (context, snapshot){
                        if(snapshot.hasData)
                        {
                          return ListView.builder(
                            primary: false,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return _createQuiz(context, snapshot.data.quiz["Quiz" + (index+1).toString()]["NOMQUIZ"], snapshot.data.quiz["Quiz" + (index+1).toString()]["NBQUESTIONSQUIZ"]);
                            },
                            itemCount: snapshot.data.quiz.length,
                          );
                        }else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton : FloatingActionButton(
        onPressed: () => {
          Navigator.pushNamed(context, '/newQuiz'),
        },
        tooltip: 'Nouveau quiz',
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

}