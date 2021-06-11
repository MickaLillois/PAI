import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizinmobile/model/userModel/userModel.dart';
import 'package:http/http.dart';

String mail ;

class NewQuiz extends StatefulWidget{
  NewQuiz({Key key, this.title}) : super(key: key);

  final String title;

  NewQuizState createState() => NewQuizState();

}

class NewQuizState extends State<NewQuiz> {

  Future<String> createQuiz(String nomQuiz) async {
    mail = UserModel.getMail();
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Utilisateurs/addNewQuizPerso.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Response response = await post(
        url,
        headers: headers,
        body: {
          'nomQuiz': nomQuiz,
          'mail': mail
        }
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to create new quiz.' + response.statusCode.toString());
    }
  }

  final myControllerNom= TextEditingController();
  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double sizeAvatar = screenSize.width * 0.3;
    double widthLogo = screenSize.width * 0.8;
    double heightLogo = screenSize.height * 0.12;
    double standard = screenSize.width * 0.06;
    double standard2 = screenSize.width * 0.045;
    double standard3 = screenSize.width * 0.038;
    double fontSizeText = screenSize.height*0.027;
    double widthButton = screenSize.width*0.85;
    double marginText = screenSize.width * 0.06;
    double marginImageTop = screenSize.height * 0.05;
    double heightButton = screenSize.height * 0.045;
    double fontSizeInput = screenSize.height*0.03;
    double widthInput = screenSize.width*0.9;

    return Scaffold(
      body : SingleChildScrollView(
        child : Container(
          child : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText*2, 0, marginText),
                    child: Text(
                      'Nouveau quiz personnalisé',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: standard
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText*3, 0, 0),
                    child: Text(
                      'Nom du quiz : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: standard2
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
                    width: widthInput/2,
                    child: TextFormField(
                      controller: myControllerNom,
                      style: TextStyle(
                        fontSize: fontSizeInput,
                      ),
                      decoration: new InputDecoration(
                        hintText: "Nom",
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(marginText, marginText*2, 0, 0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: Text(
                    'Valider',
                    style: TextStyle
                      (
                        fontSize: fontSizeText
                    ),
                  ),
                  onPressed: () {
                    if(myControllerNom.text.isEmpty) {
                        showError(context, "/!\\ Veuillez donner un nom à votre quiz /!\\");
                      }
                    else{
                      createQuiz(myControllerNom.text);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, '/quizPerso');
                    }
                  },
                ),
              )
            ],
          ),
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