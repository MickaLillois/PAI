import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

class EditProfil extends StatelessWidget {
  final String pseudo, prenom, nom, mail;
  final myControllerPseudo = TextEditingController();
  final myControllerPrenom = TextEditingController();
  final myControllerNom = TextEditingController();

  EditProfil({Key key, @required this.pseudo, @required this.prenom, @required this.nom, @required this.mail}) : super(key: key);

  Future<String> _makePostRequest(String newPseudo, String newPrenom, String newNom) async {
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Utilisateurs/updateInfosUser.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Response response = await post(
        url,
        headers: headers,
        body: {
          'mail': mail,
          'prenom': newPrenom,
          'nom': newNom,
          'pseudo': newPseudo
        }
    );
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Failed to update user.' + response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    if(myControllerPseudo.text.isEmpty)
      {
        myControllerPseudo.text = pseudo;
      }
    if(myControllerNom.text.isEmpty)
      {
        myControllerNom.text = nom;
      }
    if(myControllerPrenom.text.isEmpty)
    {
      myControllerPrenom.text = prenom;
    }
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
                    margin: EdgeInsets.fromLTRB(0, marginText, 0, marginText/2),
                    child: Text(
                      'Modification du profil',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeT1
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginLeftInput, marginText*2, 0, marginText*3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text (
                            'Pseudo : ',
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
                              hintText: "Pseudo",
                            ),
                            controller: myControllerPseudo,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, marginText*2, 0, 0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text (
                                      'Prénom : ',
                                      style: TextStyle(
                                        fontSize: fontSizeText,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: widthInput2,
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontSize: fontSizeInput,
                                      ),
                                      decoration: new InputDecoration(
                                        hintText: "Prenom",
                                      ),
                                      controller: myControllerPrenom,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(marginLeftInput*2, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text (
                                        'Nom : ',
                                        style: TextStyle(
                                          fontSize: fontSizeText,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: widthInput2,
                                      child: TextFormField(
                                        style: TextStyle(
                                          fontSize: fontSizeInput,
                                        ),
                                        decoration: new InputDecoration(
                                          hintText: "Nom",
                                        ),
                                        controller: myControllerNom,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      alignment: Alignment.topCenter,
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  // Retrieve the text the that user has entered by using the
                                  // TextEditingController.
                                  content: Text(_makePostRequest(myControllerPseudo.text, myControllerPrenom.text, myControllerNom.text).toString()),
                                );
                              },
                            );
                          },
                          child: Text('Modifier', style: TextStyle(fontSize: fontSizeText),)
                      )
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