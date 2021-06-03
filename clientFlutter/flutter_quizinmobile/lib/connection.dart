import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quizinmobile/model/userModel/userModel.dart';
import 'package:http/http.dart';


class Connection extends StatefulWidget {
  Connection({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ConnectionState createState() => ConnectionState();
}

class ConnectionState extends State<Connection> {

  final myControllerMail = TextEditingController();
  final myControllerMdp = TextEditingController();

  Future<String> _makePostRequest(String mail, String mdp) async {
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Utilisateurs/verifConnexion.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Response response = await post(
        url,
        headers: headers,
        body: {
          'mail': mail,
          'mdp': mdp
        }
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('This user is not present in the database.' + response.statusCode.toString());
    }
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
    double fontSizeT1 = screenSize.height*0.045;
    double fontSizeText = screenSize.height*0.03;
    double fontSizeInput = screenSize.height*0.035;
    double fontSizeLink = screenSize.height*0.015;
    double widthInput = screenSize.width*0.9;
    double marginLeftInput = screenSize.width*0.05;
    double marginSeCo = screenSize.height*0.02;
    double paddingInput = screenSize.height*0.02;
    double paddingButton = screenSize.height*0.02;
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
              child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0,marginLogo,0,marginLogo),
                      child: Image.asset(
                        'assets/images/logo_officiel.png',
                        width : widthLogo,
                        height: heightLogo,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0,marginSeCo,0,0),
                      child: Text(
                        'Se connecter',
                        style: TextStyle(fontSize: fontSizeT1, color: Colors.indigo),),
                    ),
                    Form(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(marginLeftInput,marginLogo,0,marginLogo/2),
                            child: Text('Identifiant :',style: TextStyle(fontSize: fontSizeText)),
                          ),
                          Container(
                            width: widthInput,
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: fontSizeInput,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(0,paddingInput,0,paddingInput),
                                hintText: 'Entrez votre email',
                              ),
                              controller: myControllerMail,
                            ),
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.fromLTRB(marginLeftInput,marginLogo*2,0,marginLogo/2),
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
                                contentPadding: EdgeInsets.fromLTRB(0,paddingInput,0,paddingInput),
                              ),
                              controller: myControllerMdp,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(0,marginLogo*1.45,0,marginLogo),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if(myControllerMail.text=='' || myControllerMdp.text==''){
                                    showAlertDialog(context, 'Veuillez compléter tous les champs.');
                                  }else{
                                    final String res = await _makePostRequest(myControllerMail.text, myControllerMdp.text);
                                    if(res=='Bon mot de passe'){
                                      Map<String, dynamic> user = {'MAILUTILISATEUR': myControllerMail.text};
                                      UserModel.saveUser(UserModel.fromJson(user));
                                      Navigator.of(context).pop();
                                      UserModel.getUser();
                                    }else{
                                      showAlertDialog(context, res);
                                    }
                                  }
                                },
                                child: Text('Valider', style: TextStyle(fontSize: fontSizeText),),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical : paddingButton/2, horizontal: paddingButton*1.5),
                                ),
                              )
                          ),
                          Container(
                            child: new InkWell(
                                child: new Text('Pas encore de compte ? Cliquez ici pour vous inscrire.', style: TextStyle(fontSize: fontSizeLink)),
                                onTap: () => Navigator.pushNamed(context, '/inscription')
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