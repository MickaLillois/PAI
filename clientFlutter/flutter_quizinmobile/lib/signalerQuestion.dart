import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quizinmobile/editMdp.dart';
import 'package:flutter_quizinmobile/model/userModel/userModel.dart';
import 'package:http/http.dart';

class CategorieSig {
  final List<String> categ;

  CategorieSig({this.categ});

  factory CategorieSig.fromJson(LinkedHashMap<String, dynamic> json) {
    List<String> retour = new List<String>();
    for(int i = 0; i< json.length; i++) {
      retour.add(json["categ" + (i+1).toString()]["LIBELLECATEGORIE_SIGNALEMENT"]);
    }
    return CategorieSig(
        categ : retour
    );
  }
}

class SignalerQuestion extends StatefulWidget{
  String intitule;
  SignalerQuestion({Key key,@required this.intitule}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SignalerQuestionState(intitule: intitule);

}

class SignalerQuestionState extends State<SignalerQuestion> {
  String intitule, _chosenValueCateg;
  SignalerQuestionState({@required this.intitule});
  final myControllerCommentaires = TextEditingController();

  @override
  Widget build(BuildContext context) {

    //Variables de responsivité
    Size screenSize = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    double widthLogo = screenSize.width * 0.8;
    double heightLogo = screenSize.height * 0.12;
    double standard = screenSize.width * 0.06;
    double widthButton = screenSize.width*0.85;
    double widthIntitule = screenSize.width*0.45;
    double widthReponse = screenSize.width*0.25;
    double widthVie = screenSize.width*0.125;
    double widthTps = screenSize.width*0.125;
    double marginText = screenSize.width * 0.06;
    double marginImageTop = screenSize.height * 0.05;
    double paddingWidget = screenSize.width * 0.01;
    double fontSizeInput = screenSize.height*0.03;
    double fontSizeText = screenSize.height*0.027;

    Future<CategorieSig> getCategorie() async {
      Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Traitement/getCategorieSignalement.php');
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
        return CategorieSig.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create user.' + response.statusCode.toString());
      }
    }

    Future<String> _makePostRequest(String intitule, String commentaires, String categ) async {
      Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Traitement/addSignalementQuestion.php');
      Map<String, String> headers = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      };
      Response response = await post(
          url,
          headers: headers,
          body: {
            'mail': UserModel.getMail(),
            'categSign': categ,
            'intitule' : intitule,
            'commentaires' : commentaires
          }
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('This user is not present in the database.' + response.statusCode.toString());
      }
    }

    return Scaffold(
      body:SingleChildScrollView(
        child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0,marginImageTop,0,marginImageTop),
                  child: Image.asset(
                    'assets/images/logo_officiel.png',
                    width : widthLogo,
                    height: heightLogo,
                  ),
                ),
                Container(
                  child: Text(
                      "Signaler la question suivante",
                      style : TextStyle(
                          fontSize: fontSizeInput,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(marginText/2,marginText,0,0),
                    child : Text(
                        intitule
                    )
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(marginText/2,marginText/2,0,0),
                    child : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            child : Text(
                                "Catégorie : ",
                                style : TextStyle(
                                    fontSize: fontSizeText
                                )
                            )
                        ),
                        Container(
                            width: widthButton/1.45,
                            margin: EdgeInsets.fromLTRB(marginText, 0, 0, 0),
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
                                  return DropdownButton<String>(
                                      value: _chosenValueCateg,
                                      style: TextStyle(color: Colors.white),
                                      iconEnabledColor:Colors.black,
                                      items: list,
                                      hint: Text(
                                          "Catégorie..."
                                      ),
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
                        )
                      ],
                    )
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(marginText/2,marginText,0,0),
                    child : Text(
                        "Commentaires : "
                    )
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(marginText/2,marginText,0,0),
                    child : Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            controller: myControllerCommentaires,
                            maxLines: 8,
                            decoration: InputDecoration.collapsed(hintText: "Mettre vos commentaires ici..."),
                          ),
                        )
                    )
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0,marginText,0,0),
                    child : ElevatedButton(
                      child: Text(
                          "Envoyer"
                      ),
                      onPressed: (){
                        if(_chosenValueCateg == null){
                          showError(context, "Catégorie de signalement obligatoire");
                        }
                        else{
                          _makePostRequest(intitule, myControllerCommentaires.text, _chosenValueCateg);
                          Navigator.pushReplacementNamed(context, '/');
                        }
                      },
                    )
                )
              ],
            )
        ),
      ),
    );
  }

  showError(BuildContext context, String err) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      elevation: 0,
      title: Text("Attention"),
      content: Text(err),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}