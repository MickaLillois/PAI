import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizinmobile/createPartie.dart';

class PartiePrivee extends StatefulWidget{
  PartiePrivee({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => PartiePriveeState();

}

class PartiePriveeState extends State<PartiePrivee>{

  @override
  Widget build(BuildContext context) {

    //Variables de responsivité
    Size screenSize = MediaQuery.of(context).size;

    double widthLogo = screenSize.width*0.8;
    double heightLogo = screenSize.height*0.12;
    double marginLogo = screenSize.height*0.05;
    double fontSizeT1 = screenSize.height*0.045;
    double fontSizeT2 = screenSize.height*0.02;
    double marginButton = screenSize.height*0.02;
    double widthButton = screenSize.width*0.85;
    double paddingButtonJeu = screenSize.height*0.03;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0,marginLogo,0,0),
                child: Image.asset('assets/images/logo_officiel.png',width: widthLogo, height: heightLogo),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(marginButton, marginLogo*2, marginButton, marginButton),
                width: widthButton,
                child: ElevatedButton(
                  child: Column(children: <Widget>[
                    Container(child: Text('Aléatoire', style: TextStyle(fontSize: fontSizeT1*1.8),),),
                    Container(child: Text('Utiliser un quiz aléatoire', style: TextStyle(fontSize: fontSizeT2*1.8),),),
                  ]),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background
                    onPrimary: Colors.white, // foreground
                    padding: EdgeInsets.all(paddingButtonJeu*2),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePartie(alea : true)));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(marginButton, marginLogo*2, marginButton, marginButton),
                width: widthButton,
                child: ElevatedButton(
                  child: Column(children: <Widget>[
                    Container(child: Text('Personnalisé', style: TextStyle(fontSize: fontSizeT1*1.5),),),
                    Container(child: Text('Utiliser un quiz personnalisé', style: TextStyle(fontSize: fontSizeT2*1.5),),),
                  ]),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background
                    onPrimary: Colors.white, // foreground
                    padding: EdgeInsets.all(paddingButtonJeu*2),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePartie(alea : false)));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}