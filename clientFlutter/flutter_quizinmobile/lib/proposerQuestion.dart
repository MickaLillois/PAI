import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProposerQuestion extends StatefulWidget{
  ProposerQuestion({Key key, this.title}) : super(key: key);

  String title;

  ProposerQuestionState createState() => ProposerQuestionState();
}

class ProposerQuestionState extends State<ProposerQuestion> {

  final myControllerIntitule = TextEditingController();
  List<String> reps = List<String>();

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
    double widthInput = screenSize.width*0.9;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0,marginLogo,0,marginLogo),
                child: Image.asset(
                  'assets/images/logo_officiel.png',
                  width : widthLogo,
                  height: heightLogo,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0,0,0,marginLogo/2),
                child: Text(
                  'Proposer une question',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: fontSizeT1*2, color: Colors.indigo),),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(marginLogo/2,0,0,marginLogo/2),
                child: Text(
                  'Intitulé :',
                  style: TextStyle(fontSize: fontSizeT1),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0,0,0,marginLogo/2),
                width: widthInput,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: fontSizeInput,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(0,0,0,paddingInput/2),
                    hintText: 'Entrez l\'intitulé',
                  ),
                  controller: myControllerIntitule,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(marginLogo/2,0,0,marginLogo/2),
                child: Text(
                  'Réponses :',
                  style: TextStyle(fontSize: fontSizeT1),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(marginLogo/2,0,0,marginLogo/2),
                    width: screenSize.width*0.7,
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: fontSizeInput,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(0,0,0,paddingInput/2),
                        hintText: 'Ajouter une réponse',
                      ),
                      controller: myControllerIntitule,
                    ),
                  ),
                  /*Container(
                      child: ListView.builder(
                        primary: false,
                        itemCount: 3,
                        shrinkWrap: true,
                        itemBuilder: (context, int index){
                          return Container(
                              margin : EdgeInsets.fromLTRB(0,marginLogo/8,0,marginLogo/8),
                              child: Text('test'),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                ),
                              )
                          );
                        },
                      )
                  ),*/
                  Container(
                    child: IconButton(
                      icon: const Icon(Icons.add_circle),
                      color: Colors.black,
                      iconSize: screenSize.width*0.12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }



}