import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quizinmobile/editProfil.dart';
import 'package:flutter_quizinmobile/jouer.dart';
import 'package:flutter_quizinmobile/profilPage.dart';
import 'package:flutter_quizinmobile/connection.dart';
import 'package:flutter_quizinmobile/inscription.dart';
import 'package:flutter_quizinmobile/editMdp.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:flutter_quizinmobile/statsUser.dart';


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
        home: MyHomePage(title: 'Rudy trop beau'),
        routes: {
          //'/': (context) => MyHomePage(title: "Connexion"),
          '/profilPage': (context) => ProfilPage(),
          '/connection': (context) => Connection(),
          '/inscription': (context) => Inscription(),
          '/editMdp': (context) => EditMdp(),
          '/editProfil': (context) => EditProfil(),
          '/statsUser': (context) => StatsUser(),
          '/jouer': (context) => Jouer(),
        },
        initialRoute: '/'
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
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
                        Navigator.pushNamed(context, '/profilPage');
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
                        Navigator.pushNamed(context, '/connection');
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(marginButton),
                    width: widthButton,
                    child: ElevatedButton(
                      child: Column(children: <Widget>[
                        Container(child: Text('Mode Battle Royal', style: TextStyle(fontSize: fontSizeT1),),),
                        Container(child: Text('Rejoindre une partie rapide', style: TextStyle(fontSize: fontSizeT2),),),
                      ]),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // background
                        onPrimary: Colors.white, // foreground
                        padding: EdgeInsets.all(paddingButtonJeu),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/jouer');
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
                      onPressed: () {},
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
                      onPressed: () {},
                    ),
                  ),
                ]
            ),
          ),
        ));
  }
}
