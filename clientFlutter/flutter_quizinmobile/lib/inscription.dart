import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Inscription extends StatefulWidget {
  Inscription({Key key, this.title}) : super(key: key);

  final String title;

  @override
  InscriptionState createState() => InscriptionState();
}


class InscriptionState extends State<Inscription> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Size screenSize = MediaQuery.of(context).size;
    double widthLogo = screenSize.width*0.8;
    double heightLogo = screenSize.height*0.12;
    double marginLogo = screenSize.height*0.05;
    double marginTopTxt = screenSize.height*0.02;
    double fontSizeT1 = screenSize.height*0.045;
    double fontSizeText = screenSize.height*0.018;
    double fontSizeInput = screenSize.height*0.025;
    double widthInput = screenSize.width*0.9;
    double widthInput2 = screenSize.width*0.4;
    double marginLeftInput = screenSize.width*0.05;
    double paddingInput = screenSize.height*0.018;
    double paddingButton = screenSize.height*0.02;
    double fontSizeInkwell = screenSize.height*0.013;
    return Scaffold(
        body:  SingleChildScrollView(
          child: Center(
              child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0,marginLogo,0,marginLogo/2),
                      child: Image.asset(
                        'assets/images/logo_officiel.png',
                        width : widthLogo,
                        height: heightLogo,
                      ),
                    ),
                    Text(
                      'S\'inscrire',
                      style: TextStyle(fontSize: fontSizeT1, color: Colors.indigo),),
                    Form(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(marginLeftInput,0,0,0),
                            child: Text('Email :',style: TextStyle(fontSize: fontSizeText)),
                          ),
                          Container(
                            width: widthInput,
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: fontSizeInput,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Entrez votre email',
                                contentPadding: EdgeInsets.fromLTRB(0, paddingInput, 0, paddingInput),
                              ),
                            ),
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.fromLTRB(marginLeftInput,marginTopTxt,0,0),
                              child: Text('Mot de passe :',style: TextStyle(fontSize: fontSizeText))
                          ),
                          Container(
                            width: widthInput,
                            child: TextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              style: TextStyle(
                                fontSize: fontSizeInput,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Entrez votre mot de passe',
                                contentPadding: EdgeInsets.fromLTRB(0, paddingInput, 0, paddingInput),
                              ),
                            ),
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.fromLTRB(marginLeftInput,marginTopTxt,0,0),
                              child: Text('Confirmation du passe :',style: TextStyle(fontSize: fontSizeText))
                          ),
                          Container(
                            width: widthInput,
                            child: TextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              style: TextStyle(
                                fontSize: fontSizeInput,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Confirmez votre mot de passe',
                                contentPadding: EdgeInsets.fromLTRB(0, paddingInput, 0, paddingInput),
                              ),
                            ),
                          ),
                          Row(children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(marginLeftInput,marginTopTxt,0,0),
                                    child: Text('Prénom :',style: TextStyle(fontSize: fontSizeText))
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(marginLeftInput,0,0,0),
                                  width: widthInput2,
                                  child: TextFormField(
                                    style: TextStyle(
                                      fontSize: fontSizeInput,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Prénom',
                                      contentPadding: EdgeInsets.fromLTRB(0, paddingInput, 0, paddingInput),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(marginLeftInput*2,marginTopTxt,0,0),
                                    child: Text('Nom :',style: TextStyle(fontSize: fontSizeText))
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(marginLeftInput*2,0,0,0),
                                  width: widthInput2,
                                  child: TextFormField(
                                    style: TextStyle(
                                      fontSize: fontSizeInput,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Nom',
                                      contentPadding: EdgeInsets.fromLTRB(0, paddingInput, 0, paddingInput),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.fromLTRB(marginLeftInput,marginTopTxt,0,0),
                              child: Text('Pseudo :',style: TextStyle(fontSize: fontSizeText))
                          ),
                          Container(
                            width: widthInput,
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: fontSizeInput,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Entrez votre pseudo',
                                contentPadding: EdgeInsets.fromLTRB(0, paddingInput, 0, paddingInput),
                              ),
                            ),
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.fromLTRB(marginLeftInput,marginTopTxt,0,0),
                              child: Text('Date de naissance :',style: TextStyle(fontSize: fontSizeText))
                          ),
                          Container(
                              width: widthInput,
                              child: Row(children: <Widget>[
                                Text(selectedDate == null ? 'Nothing has been picked yet' : selectedDate.toString().substring(0,11)),
                                ElevatedButton(
                                  child: Text('Choisir une date'),
                                  onPressed: () => _selectDate(context),
                                )
                              ],
                              )
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(0,marginLogo/4,0,marginLogo/4),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Valider', style: TextStyle(fontSize: fontSizeText),),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical : paddingButton/2, horizontal: paddingButton*1.5),
                                ),
                              )
                          ),
                          Container(
                            child: new InkWell(
                                child: new Text('Déjà un compte? Connectez vous.', style: TextStyle(fontSize: fontSizeInkwell),),
                                onTap: () => Navigator.pop(context)
                            ),
                          ),
                        ],
                      ),
                    ),

                  ]
              )
          ),
        ));
  }
}

  