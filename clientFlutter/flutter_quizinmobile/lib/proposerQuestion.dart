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

class Difficulte {
  final List<String> diff;

  Difficulte({this.diff});

  factory Difficulte.fromJson(LinkedHashMap<String, dynamic> json) {
    List<String> retour = new List<String>();
    for(int i = 0; i< json.length; i++) {
      retour.add(json["Difficulte" + (i+1).toString()]["LIBELLEDIFFICULTE"]);
    }
    return Difficulte(
        diff : retour
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

  Future<Difficulte> getDifficulte() async {
    mail = UserModel.getMail();
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Questions/getDifficultes.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    var response = await post(
        url,
        headers: headers,
        body: {

        }
    );
    if (response.statusCode == 200) {
      return Difficulte.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.' + response.statusCode.toString());
    }
  }

  Future<String> _makePostRequest(String intitule, String reponses, String categ, String diff, String nbvie) async {
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Traitement/addSuggestionQuestion.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Response response = await post(
        url,
        headers: headers,
        body: {
          'mail': UserModel.getMail(),
          'categ': categ,
          'intitule' : intitule,
          'difficulte' : diff,
          'reponses' : reponses,
          'nbRepMax' : nbvie
        }
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('This user is not present in the database.' + response.statusCode.toString());
    }
  }

  String _chosenValueCateg="Sélectionner une catégorie";
  String _chosenValueDiff="Sélectionner une difficulté";
  String _chosenValue="1";

  final myControllerIntitule = TextEditingController();
  final myControllerReponses = TextEditingController();

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
    double paddingButton = screenSize.height*0.02;
    double fontSizeText = screenSize.height*0.03;

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
                    hintText: 'Ajoutez la/les réponse(s)',
                  ),
                  controller: myControllerReponses,
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(marginLogo/2,0,0,0),
                      child: Text(
                        'Catégorie :',
                        style: TextStyle(fontSize: fontSizeT1),
                      ),
                    ),
                    Container(
                        width: widthButton/1.5,
                        margin: EdgeInsets.fromLTRB(marginLogo/2, 0, 0, 0),
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
                                        "Sélectionner une catégorie",
                                        style: TextStyle(
                                            color:Colors.black
                                        ),
                                      ),
                                      value : "Sélectionner une catégorie"
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
              Container(
                  child : Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(marginLogo/2,0,0,0),
                        child: Text(
                          'Difficulté : ',
                          style: TextStyle(fontSize: fontSizeT1),
                        ),
                      ),
                      Container(
                          width: widthButton/1.5,
                          margin: EdgeInsets.fromLTRB(marginLogo/2, 0, 0, 0),
                          child: FutureBuilder(
                            future : getDifficulte(),
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                List<DropdownMenuItem<String>> list2 = new List<DropdownMenuItem<String>>();
                                for(int i = 0; i < snapshot.data.diff.length; i++){
                                  list2.add(
                                      new DropdownMenuItem(
                                          child: Text(
                                            snapshot.data.diff.elementAt(i),
                                            style: TextStyle(
                                                color:Colors.black
                                            ),
                                          ),
                                          value : snapshot.data.diff.elementAt(i)
                                      )
                                  );
                                }
                                list2.add(
                                    new DropdownMenuItem(
                                        child: Text(
                                          "Sélectionner une difficulté",
                                          style: TextStyle(
                                              color:Colors.black
                                          ),
                                        ),
                                        value : "Sélectionner une difficulté"
                                    )
                                );
                                return DropdownButton<String>(
                                    value: _chosenValueDiff,
                                    style: TextStyle(color: Colors.white),
                                    iconEnabledColor:Colors.black,
                                    items: list2,
                                    onChanged: (String value) {
                                      setState(() {
                                        _chosenValueDiff = value;
                                      });
                                    }
                                );
                              }
                              return Text("");
                            },
                          )
                      ),
                    ],
                  )
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(marginLogo/2,0,0,0),
                      child: Text(
                        'Nb vie(s) : ',
                        style: TextStyle(fontSize: fontSizeT1),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(marginLogo/2,0,0,0),
                        width: widthButton/4,
                        child: DropdownButton<String>(
                            value: _chosenValue,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor:Colors.black,
                            items: <String>[
                              '1',
                              '2',
                              '3',
                              '4',
                              '5',
                            ].map<DropdownMenuItem<String>>((String value) {                              return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style:TextStyle(color:Colors.black),),
                            );
                            }).toList(),
                            hint:Text(
                              "Vie(s)",
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
                  ],
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () async {
                    if(myControllerIntitule.text==''){
                      showAlertDialog(context, "Veuillez préciser l'intitulé de la question.");
                    }else if(myControllerReponses.text==''){
                      showAlertDialog(context, "Veuillez préciser une ou plusieurs réponses.");
                    }else if(_chosenValueCateg=="Sélectionner une catégorie"){
                      showAlertDialog(context, "Veuillez entrer une catégorie valide.");
                    }else if(_chosenValueDiff=="Sélectionner une difficulté"){
                      showAlertDialog(context, "Veuillez entrer une difficulté valide.");
                    }else{
                      await _makePostRequest(myControllerIntitule.text, myControllerReponses.text, _chosenValueCateg, _chosenValueDiff, _chosenValue);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Valider', style: TextStyle(fontSize: fontSizeText),),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical : paddingButton/2, horizontal: paddingButton*1.5),
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


showAlertDialog(BuildContext context, String msg) {
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    elevation: 0,
    title: Text("Message"),
    content: Text(msg),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

