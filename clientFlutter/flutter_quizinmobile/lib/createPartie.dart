import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class CreatePartie extends StatefulWidget{
  CreatePartie({Key key, @required this.alea}) : super(key: key);

  final bool alea;

  @override
  State<StatefulWidget> createState() => CreatePartieState(alea: alea);

}

class CreatePartieState extends State<CreatePartie>{

  CreatePartieState({@required this.alea});

  final bool alea;
  final controllerNom = TextEditingController();
  String _chosenValue, _chosenValueCateg;

  @override
  Widget build(BuildContext context) {

    //Variables de responsivité
    Size screenSize = MediaQuery.of(context).size;

    double widthLogo = screenSize.width*0.8;
    double heightLogo = screenSize.height*0.12;
    double marginLogo = screenSize.height*0.05;
    double paddingInput = screenSize.height*0.02;
    double widthInput = screenSize.width*0.7;
    double widthInput2 = screenSize.width*0.9;
    double widthInputIcon = screenSize.width*0.2;
    double iconSize = screenSize.width*0.2;
    double fontSizeInput = screenSize.height*0.035;
    double fontSizeT1 = screenSize.height*0.045;
    double fontSizeT2 = screenSize.height*0.02;
    double fontSizeT3 = screenSize.height*0.03;
    double marginNumQ =screenSize.height*0.02;
    double marginButton = screenSize.height*0.02;
    double widthButton = screenSize.width*0.85;
    double paddingButtonJeu = screenSize.height*0.03;
    double marginText = screenSize.width * 0.06;
    double marginLeftInput = screenSize.width*0.05;

    Widget createAlea(){
      return Container(
          margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
        child : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Nb questions : '
            ),
            Container(
                width: widthButton/6,
                child: DropdownButton<String>(
                    value: _chosenValue,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor:Colors.black,
                    items: <String>[
                      '10',
                      '11',
                      '12',
                      '13',
                      '14',
                      '15',
                      '16',
                      '17',
                      '18',
                      '19',
                      '20'
                    ].map<DropdownMenuItem<String>>((String value) {                              return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style:TextStyle(color:Colors.black),),
                    );
                    }).toList(),
                    hint:Text(
                      "Nb",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _chosenValue = value;
                      });
                    }
                )
            ),
            Container(
              child : Row(
                children: [
                  Text(
                      'Catégorie : '
                  ),
                  Container(
                      width: widthButton/2,
                      margin: EdgeInsets.fromLTRB(marginText, 0, 0, 0),
                      child: DropdownButton<String>(
                          value: _chosenValueCateg,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor:Colors.black,
                          items: <String>[
                            'Geographie',
                            'Histoire'
                          ].map<DropdownMenuItem<String>>((String value) {                              return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style:TextStyle(color:Colors.black),),
                          );
                          }).toList(),
                          hint:Text(
                            "Catégorie",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _chosenValueCateg = value;
                            });
                          }
                      )
                  ),
                ],
              )
            )
          ],
        ),
      );
    }

    Widget createPerso(){
      return Container(
          child : Text("non")
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0,marginLogo,0,0),
                child: Image.asset('assets/images/logo_officiel.png',width: widthLogo, height: heightLogo),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(marginLeftInput, marginText*2, 0, marginText*3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text (
                        'Nom de la partie : ',
                        style: TextStyle(
                          fontSize: fontSizeT2,
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
                          hintText: "Nom partie",
                        ),
                        controller: controllerNom,
                      ),
                    ),
                    alea ? createAlea() : createPerso()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}