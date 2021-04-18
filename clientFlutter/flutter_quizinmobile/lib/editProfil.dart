import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class EditProfil extends StatefulWidget {
  final String pseudo, prenom, nom, mail;
  EditProfil({Key key, @required this.pseudo, @required this.prenom, @required this.nom, @required this.mail}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  EditProfilPage createState() => EditProfilPage(pseudo: pseudo, prenom: prenom, mail: mail, nom:nom);
}

class EditProfilPage extends State<EditProfil> {
  final String pseudo, prenom, nom, mail;
  final myControllerPseudo = TextEditingController();
  final myControllerPrenom = TextEditingController();
  final myControllerNom = TextEditingController();

  EditProfilPage({@required this.pseudo, @required this.prenom, @required this.nom, @required this.mail});

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
                            String ret = _makePostRequest(myControllerPseudo.text, myControllerPrenom.text, myControllerNom.text).toString();
                            print(ret);
                            if(ret == "0") {
                                showAlertDialog2(context);
                              }
                            else{
                              showAlertDialog(context);
                            }
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

showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    elevation: 0,
    title: Text("Message"),
    content: Text("Vos informations ont été mises à jour !"),
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

showAlertDialog2(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    elevation: 0,
    title: Text("Attention"),
    content: Text("Erreur, vos informations n'ont pas pu être mises à jour, veuillez rééssayer plus tard !"),
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
