import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditMdp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthLogo = screenSize.width * 0.8;
    double heightLogo = screenSize.height * 0.12;
    double marginImageTop = screenSize.height * 0.05;
    double fontSizeT1 = screenSize.height*0.055;
    double fontSizeText = screenSize.height*0.027;
    double fontSizeInput = screenSize.height*0.03;
    double widthInput = screenSize.width*0.9;
    double widthInput2 = screenSize.width*0.4;
    double marginText = screenSize.width * 0.06;
    double marginLeftInput = screenSize.width*0.05;

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
                    margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
                    child: Text(
                      'Modification mot de passe',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeT1*0.9
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginLeftInput, marginText*2, 0, marginText*2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text (
                            'Ancien mot de passe : ',
                            style: TextStyle(
                              fontSize: fontSizeText,
                            ),
                          ),
                        ),
                        Container(
                          width: widthInput,
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: fontSizeInput,
                            ),
                            decoration: new InputDecoration(
                              hintText: "Ancien mot de passe",
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, marginText*2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, marginText*2, 0, 0),
                                child: Text (
                                  'Nouveau mot de passe : ',
                                  style: TextStyle(
                                    fontSize: fontSizeText,
                                  ),
                                ),
                              ),
                              Container(
                                width: widthInput,
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: fontSizeInput,
                                  ),
                                  decoration: new InputDecoration(
                                    hintText: "Nouveau mot de passe",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, marginText),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text (
                                  'Confirmation mot de passe : ',
                                  style: TextStyle(
                                    fontSize: fontSizeText,
                                  ),
                                ),
                              ),
                              Container(
                                width: widthInput,
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: fontSizeInput,
                                  ),
                                  decoration: new InputDecoration(
                                    hintText: "Confirmation mot de passe",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.topCenter,
                            child: ElevatedButton(
                                onPressed: () {
                                },
                                child: Text('Modifier', style: TextStyle(fontSize: fontSizeText),)
                            )
                        ),
                      ],
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