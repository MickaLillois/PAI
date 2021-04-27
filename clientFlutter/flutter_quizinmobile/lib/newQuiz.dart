import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewQuiz extends StatefulWidget{
  NewQuiz({Key key, this.title}) : super(key: key);

  final String title;

  NewQuizState createState() => NewQuizState();

}

class NewQuizState extends State<NewQuiz> {
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
    double fontSizeInput = screenSize.height*0.03;
    double widthInput = screenSize.width*0.9;

    return Scaffold(
      body : SingleChildScrollView(
        child : Container(
          child : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText, 0, marginText),
                    child: Text(
                      'Nouveau quiz personnalisé',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: standard
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
                    child: Text(
                      'Nom du quiz : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: standard2
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
                    width: widthInput/2,
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: fontSizeInput,
                      ),
                      decoration: new InputDecoration(
                        hintText: "Nom",
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: Text(
                    'Valider'
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}