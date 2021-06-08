import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'editMdp.dart';
import 'model/userModel/userModel.dart';

class Categorie {
  final List<String> categ;

  Categorie({this.categ});

  factory Categorie.fromJson(LinkedHashMap<String, dynamic> json) {
    List<String> retour = new List<String>();
    for(int i = 0; i< json.length; i++) {
      retour.add(json["Categorie" + (i+1).toString()]["LIBELLECATEGORIE"]);
    }
    return Categorie(
        categ : retour
    );
  }
}

class ProposerQuestion extends StatefulWidget{
  ProposerQuestion({Key key, this.title}) : super(key: key);

  String title;

  ProposerQuestionState createState() => ProposerQuestionState();
}

class ProposerQuestionState extends State<ProposerQuestion> {

  Future<Categorie> getCategorie() async {
    mail = UserModel.getMail();
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Questions/getCategories.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    var response = await post(
        url,
        headers: headers,
        body: {

        }
    );
    print(response.body);
    if (response.statusCode == 200) {
      return Categorie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.' + response.statusCode.toString());
    }
  }

  String _chosenValueCateg="Toutes";

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
    double widthButton = screenSize.width*0.85;

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
                margin: EdgeInsets.fromLTRB(marginLogo/2,0,0,0),
                child: Text(
                  'Réponses :\n',
                  style: TextStyle(fontSize: fontSizeT1),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(marginLogo/2,0,0,marginLogo/2),
                child: Text(
                  '(Dans le format suivant : une réponse/une autre réponse/...)',
                  style: TextStyle(fontSize: fontSizeT1*0.6),
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
                    hintText: 'Ajouter la/les réponse(s)',
                  ),
                  controller: myControllerIntitule,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(marginLogo/2,0,0,0),
                child: Text(
                  'Catégorie :\n',
                  style: TextStyle(fontSize: fontSizeT1),
                ),
              ),
              Container(
                  width: widthButton/2,
                  margin: EdgeInsets.fromLTRB(marginLogo, 0, 0, 0),
                  child: FutureBuilder(
                    future : getCategorie(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        List<DropdownMenuItem<String>> list = new List<DropdownMenuItem<String>>();
                        for(int i = 0; i < snapshot.data.categ.length; i++){
                          list.add(
                              new DropdownMenuItem(
                                  child: Text(
                                    snapshot.data.categ.elementAt(i),
                                    style: TextStyle(
                                        color:Colors.black
                                    ),
                                  ),
                                  value : snapshot.data.categ.elementAt(i)
                              )
                          );
                        }
                        list.add(
                            new DropdownMenuItem(
                                child: Text(
                                  "Toutes",
                                  style: TextStyle(
                                      color:Colors.black
                                  ),
                                ),
                                value : "Toutes"
                            )
                        );
                        list.forEach((element) {print(element.value);});
                        //print(list.first.value);
                        return DropdownButton<String>(
                            value: _chosenValueCateg,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor:Colors.black,
                            items: list,
                            onChanged: (String value) {
                              setState(() {
                                _chosenValueCateg = value;
                              });
                            }
                        );
                      }
                      return Text("");
                    },
                  )
              ),
            ],
          ),
        ),
      ),

    );
  }
}

