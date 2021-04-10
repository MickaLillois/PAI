import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Inscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Size screenSize = MediaQuery.of(context).size;
    double widthLogo = screenSize.width*0.8;
    double heightLogo = screenSize.height*0.1;
    double marginLogo = screenSize.height*0.05;
    double marginTopTxt = screenSize.height*0.02;
    double fontSizeT1 = screenSize.height*0.045;
    double fontSizeText = screenSize.height*0.02;
    double fontSizeInput = screenSize.height*0.025;
    double widthInput = screenSize.width*0.9;
    double widthInput2 = screenSize.width*0.4;
    double marginLeftInput = screenSize.width*0.05;
    return Scaffold(
      body: Center(
          child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0,marginLogo,0,marginLogo/2),
                  child: Image.asset(
                    'assets/images/logo_png.png',
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
                        margin: EdgeInsets.fromLTRB(marginLeftInput,marginTopTxt,0,0),
                        child: Text('Email :',style: TextStyle(fontSize: fontSizeText)),
                      ),
                      Container(
                        width: widthInput,
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: fontSizeInput,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Entrez votre email',
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
                          decoration: const InputDecoration(
                            hintText: 'Entrez votre mot de passe',
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
                          decoration: const InputDecoration(
                            hintText: 'Confirmez votre mot de passe',
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
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                style: TextStyle(
                                  fontSize: fontSizeInput,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Prénom',
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
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                style: TextStyle(
                                  fontSize: fontSizeInput,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Nom',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0,marginLogo,0,marginLogo),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text('Valider', style: TextStyle(fontSize: fontSizeText),))
                      ),
                      Container(
                        child: new InkWell(
                            child: new Text('Open Browser'),
                            onTap: () => Navigator.pushNamed(context, '/connection')
                        ),
                      ),
                    ],
                  ),
                ),
              ]
          )
      ),
    );
  }
}