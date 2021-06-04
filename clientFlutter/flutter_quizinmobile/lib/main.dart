import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quizinmobile/Classement.dart';
import 'package:flutter_quizinmobile/detailsQuiz.dart';
import 'package:flutter_quizinmobile/editProfil.dart';
import 'package:flutter_quizinmobile/model/userModel/userModel.dart';
import 'package:flutter_quizinmobile/newQuestion.dart';
import 'package:flutter_quizinmobile/newQuiz.dart';
import 'package:flutter_quizinmobile/partiePrivee.dart';
import 'package:flutter_quizinmobile/partieStandard.dart';
import 'package:flutter_quizinmobile/profilPage.dart';
import 'package:flutter_quizinmobile/connection.dart';
import 'package:flutter_quizinmobile/inscription.dart';
import 'package:flutter_quizinmobile/editMdp.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:flutter_quizinmobile/quizPerso.dart';
import 'package:flutter_quizinmobile/statsUser.dart';
import 'package:flutter_quizinmobile/updateQuestionPerso.dart';

import 'finPartie.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: MyHomePage(title: 'App'),
        routes: {
          //'/': (context) => MyHomePage(title: "Connexion"),
          '/profilPage': (context) => ProfilPage(),
          '/connection': (context) => Connection(),
          '/inscription': (context) => Inscription(),
          '/editMdp': (context) => EditMdp(),
          '/editProfil': (context) => EditProfil(),
          '/statsUser': (context) => StatsUser(),
          '/quizPerso': (context) => QuizPerso(),
          '/newQuiz': (context) => NewQuiz(),
          '/detailsQuiz': (context) => DetailsQuiz(),
          '/newQuestion': (context) => NewQuestion(),
          '/partieStandard': (context) => PartieStandard(),
          '/updateQuestionPerso': (context) => UpdateQuestionPerso(),
          '/partiePrivee': (context) => PartiePrivee(),
          '/finPartieStandard': (context) => FinPartieStandard(),
          '/classement': (context) => Classement(),
        },
        initialRoute: '/'
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool login=false;
  isLogin(){
    setState(() {
      login=!login;
    });
  }
  @override
  Widget build(BuildContext context) {
    UserModel.getUser();
    Size screenSize = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double marginButton = screenSize.height*0.02;
    double widthButton = screenSize.width*0.85;
    double paddingButtonJeu = screenSize.height*0.03;
    double paddingButtonQuest = screenSize.height*0.02;
    double iconSize = screenSize.width*0.2;
    double fontSizeT1 = screenSize.height*0.045;
    double fontSizeT2 = screenSize.height*0.02;
    double fontSizeT3 = screenSize.height*0.03;
    double widthLogo = screenSize.width*0.8;
    double heightLogo = screenSize.height*0.12;
    double marginLogo = screenSize.height*0.05;
    double marginIcon = screenSize.height*0.02;
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0,marginLogo,0,0),
                    child: Image.asset('assets/images/logo_officiel.png',width: widthLogo, height: heightLogo),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0,marginIcon,0,0),
                    child: IconButton(
                      icon: const Icon(Icons.account_circle),
                      color: Colors.black,
                      iconSize: iconSize,
                      onPressed: () {
                        UserModel.getUser();
                        if(UserModel.sessionUser == null){
                          Navigator.pushNamed(context, '/connection');
                        }else{
                          Navigator.pushNamed(context, '/profilPage');
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(marginButton),
                    width: widthButton,
                    child: ElevatedButton(
                      child: Column(children: <Widget>[
                        Container(child: Text('Mode Standard', style: TextStyle(fontSize: fontSizeT1),),),
                        Container(child: Text('Rejoindre une partie rapide', style: TextStyle(fontSize: fontSizeT2),),),
                      ]),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // background
                        onPrimary: Colors.white, // foreground
                        padding: EdgeInsets.all(paddingButtonJeu),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PartieStandard(nomPartie : "", nbQuestions : "10", difficulte : "Toutes", categorie : "Toutes")));
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(marginButton),
                    width: widthButton,
                    child: ElevatedButton(
                      child: Column(children: <Widget>[
                        Container(child: Text('Partie privée', style: TextStyle(fontSize: fontSizeT1),),),
                        Container(child: Text('Rejoindre le menu de partie privée', style: TextStyle(fontSize: fontSizeT2),),),
                      ]),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // background
                        onPrimary: Colors.white, // foreground
                        padding: EdgeInsets.all(paddingButtonJeu),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/partiePrivee');
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(marginButton),
                    width: widthButton,
                    child: ElevatedButton(
                      child: Column(children: <Widget>[
                        Container(child: Text('Statistiques', style: TextStyle(fontSize: fontSizeT1),),),
                        Container(child: Text('Classement des meilleurs joueurs', style: TextStyle(fontSize: fontSizeT2),),),
                      ]),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // background
                        onPrimary: Colors.white, // foreground
                        padding: EdgeInsets.all(paddingButtonJeu),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/classement');
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(marginButton),
                    width: widthButton,
                    child: ElevatedButton(
                      child: Text('Proposer une question', style: TextStyle(fontSize: fontSizeT3),),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // background
                        onPrimary: Colors.white, // foreground
                        padding: EdgeInsets.all(paddingButtonQuest),
                      ),
                      onPressed: () {
                        print(login.toString());
                      },
                    ),
                  ),
                ]
            ),
          ),
        ));
  }
}
