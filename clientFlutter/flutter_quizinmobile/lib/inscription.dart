import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'model/userModel/userModel.dart';

///classes permettant à un utilisateur de s'inscrire

class Inscription extends StatefulWidget {
  Inscription({Key key, this.title}) : super(key: key);

  final String title;

  @override
  InscriptionState createState() => InscriptionState();
}


class InscriptionState extends State<Inscription> {
  DateTime selectedDate = DateTime.now();
  final myControllerMail = TextEditingController();
  final myControllerMdp = TextEditingController();
  final myControllerCmdp = TextEditingController();
  final myControllerPrenom = TextEditingController();
  final myControllerNom = TextEditingController();
  final myControllerPseudo = TextEditingController();

  ///méthode permettant la modification de la date dans l'input "date de naissance"
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1930, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  ///méthode permettant de créer le compte de l'utilisateur en insérant ses informations dans la base
  Future<String> _makePostRequest(String mail, String mdp, String prenom, String nom, String pseudo, String dateNaissance) async {
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Utilisateurs/addNewUtilisateur.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Response response = await post(
        url,
        headers: headers,
        body: {
          'mail': mail,
          'prenom': prenom,
          'nom': nom,
          'pseudo': pseudo,
          'mdp': mdp,
          'dateNaissance': dateNaissance
        }
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to insert user.' + response.statusCode.toString());
    }
  }


  @override
  Widget build(BuildContext context) {

    //variables de responsivité
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

                    //logo
                    Container(
                      margin: EdgeInsets.fromLTRB(0,marginLogo,0,marginLogo/2),
                      child: Image.asset(
                        'assets/images/logo_officiel.png',
                        width : widthLogo,
                        height: heightLogo,
                      ),
                    ),

                    //texte "s'inscrire"
                    Text(
                      'S\'inscrire',
                      style: TextStyle(fontSize: fontSizeT1, color: Colors.indigo),),
                    Form(
                      child: Column(
                        children: [

                          //texte "email"
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(marginLeftInput,0,0,0),
                            child: Text('Email :',style: TextStyle(fontSize: fontSizeText)),
                          ),

                          //text input de l'email
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
                              controller: myControllerMail,
                            ),
                          ),

                          //texte "mot de passe"
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.fromLTRB(marginLeftInput,marginTopTxt,0,0),
                              child: Text('Mot de passe :',style: TextStyle(fontSize: fontSizeText))
                          ),

                          //text input du mot de passe
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
                              controller: myControllerMdp,
                            ),
                          ),

                          //texte 'Confirmation du passe :'
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.fromLTRB(marginLeftInput,marginTopTxt,0,0),
                              child: Text('Confirmation du passe :',style: TextStyle(fontSize: fontSizeText))
                          ),

                          //text input de la confirmation de mot de passe
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
                              controller: myControllerCmdp,
                            ),
                          ),
                          Row(children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                //texte "prénom"
                                Container(
                                    margin: EdgeInsets.fromLTRB(marginLeftInput,marginTopTxt,0,0),
                                    child: Text('Prénom :',style: TextStyle(fontSize: fontSizeText))
                                ),

                                //text input du prénom
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
                                    controller: myControllerPrenom,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                //texte "nom"
                                Container(
                                    margin: EdgeInsets.fromLTRB(marginLeftInput*2,marginTopTxt,0,0),
                                    child: Text('Nom :',style: TextStyle(fontSize: fontSizeText))
                                ),

                                //text input du nom
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
                                    controller: myControllerNom,
                                  ),
                                ),
                              ],
                            ),
                          ]
                          ),

                          //texte "pseudo"
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.fromLTRB(marginLeftInput,marginTopTxt,0,0),
                              child: Text('Pseudo :',style: TextStyle(fontSize: fontSizeText))
                          ),

                          //text input du pseudo
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
                              controller: myControllerPseudo,
                            ),
                          ),

                          //texte "date de naissance"
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.fromLTRB(marginLeftInput,marginTopTxt,0,0),
                              child: Text('Date de naissance :',style: TextStyle(fontSize: fontSizeText))
                          ),

                          //DatePicker de la date de naissance
                          Container(
                              width: widthInput,
                              child: Row(children: <Widget>[
                                Text(selectedDate == null ? 'Aucune date choisie' : selectedDate.toString().substring(0,11),style: TextStyle(fontSize: fontSizeText)),
                                ElevatedButton(
                                  child: Text('Choisir une date',style: TextStyle(fontSize: fontSizeText)),
                                  onPressed: () => _selectDate(context),
                                )
                              ],
                              )
                          ),

                          //bouton de validation d'inscription vérifiant la conformité des informations
                          Container(
                              margin: EdgeInsets.fromLTRB(0,marginLogo/4,0,marginLogo/4),
                              child: ElevatedButton(
                                onPressed: () async {
                                  String dateNaissance = selectedDate.toString().substring(0,11);
                                  if(myControllerMdp.text=='' || myControllerCmdp.text=='' || myControllerMail.text=='' || myControllerPrenom.text=='' || myControllerNom.text=='' || myControllerPseudo.text==''){
                                    showAlertDialog(context, 'Veuillez compléter tous les champs.');
                                  }else{
                                    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(myControllerMail.text)){
                                      if(myControllerMdp.text==myControllerCmdp.text){
                                        final String res = await _makePostRequest(myControllerMail.text, myControllerMdp.text, myControllerPrenom.text, myControllerNom.text, myControllerPseudo.text, dateNaissance);
                                        if(res=='utilisateur cree'){
                                          Map<String, dynamic> user = {'MAILUTILISATEUR': myControllerMail.text};
                                          UserModel.saveUser(UserModel.fromJson(user));
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        }else{
                                          showAlertDialog(context, res);
                                        }
                                      }else{
                                        showAlertDialog(context, 'La confirmation de mot de passe n\'est pas identique au mot de passe.');
                                      }
                                    }else{
                                      showAlertDialog(context, 'Format de l\'adresse mail invalide.');
                                    }

                                  }

                                },
                                child: Text('Valider', style: TextStyle(fontSize: fontSizeText),),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical : paddingButton/2, horizontal: paddingButton*1.5),
                                ),
                              )
                          ),

                          //hyperlien menant au menu de connexion
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

//méthode permettant de générer les popup
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


  