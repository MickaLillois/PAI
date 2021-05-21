import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizinmobile/detailsQuiz.dart';
import 'package:flutter_quizinmobile/model/userModel/userModel.dart';
import 'package:http/http.dart';

String mail ;

class UpdateQuestionPerso extends StatefulWidget{
  UpdateQuestionPerso({Key key, @required this.ancienIntitule, @required this.ancienReponses, @required this.ancienNbVies, @required this.ancienTpsRep, @required this.nomQuiz}) : super(key: key);

  final String ancienIntitule, ancienReponses, ancienNbVies, ancienTpsRep, nomQuiz;

  UpdateQuestionPersoState createState() => UpdateQuestionPersoState(ancienIntitule: ancienIntitule, ancienReponses: ancienReponses, ancienNbVies: ancienNbVies, ancienTpsRep: ancienTpsRep, nomQuiz: nomQuiz);

}

class UpdateQuestionPersoState extends State<UpdateQuestionPerso> {
  UpdateQuestionPersoState({@required this.ancienIntitule, @required this.ancienReponses, @required this.ancienNbVies, @required this.ancienTpsRep, @required this.nomQuiz});

  final String ancienIntitule, ancienReponses, ancienNbVies, ancienTpsRep, nomQuiz;

  Future<String> updateQuestion(String ancienIntitule, String intitule, String reponses, String nbRep, String tpsRep) async {
    mail = UserModel.getMail();
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Utilisateurs/updateQuestionPerso.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Response response = await post(
        url,
        headers: headers,
        body: {
          'intitule': intitule,
          'ancienIntitule': ancienIntitule,
          'reponses': reponses,
          'nbReponsesMax': nbRep,
          'tempsReponse': tpsRep,
          'mail': mail
        }
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to create new quiz.' + response.statusCode.toString());
    }
  }

  final myControllerIntitule= TextEditingController();
  final myControllerReponses = TextEditingController();

  String _chosenValue, _chosenValueTps;

  @override
  void initState() {
    _chosenValue = ancienNbVies;
    _chosenValueTps = ancienTpsRep;
    myControllerReponses.text = ancienReponses;
    myControllerIntitule.text = ancienIntitule;
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
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
                    child: Center(
                      child: Text(
                        'Modifier une question personnalisée',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: standard
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
                    child: Text(
                      'Intitulé de la question : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: standard2
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
                    width: widthInput,
                    child: TextFormField(
                      controller: myControllerIntitule,
                      style: TextStyle(
                        fontSize: fontSizeInput,
                      ),
                      decoration: new InputDecoration(
                        hintText: "Intitule",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
                    child: Text(
                      'Réponse(s) de la question : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: standard2
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
                    width: widthInput,
                    child: TextFormField(
                      controller: myControllerReponses,
                      style: TextStyle(
                        fontSize: fontSizeInput,
                      ),
                      decoration: new InputDecoration(
                        hintText: "Réponses",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
                    width: widthButton,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Nb vie(s) max : '
                            ),
                            Container(
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
                        Container(
                          child : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Temps réponse : '
                              ),
                              Container(
                                  width: widthButton/4,
                                  child: DropdownButton<String>(
                                      value: _chosenValueTps,
                                      underline: SizedBox(),
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
                                        '18'
                                      ].map<DropdownMenuItem<String>>((String value) {                              return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,style:TextStyle(color:Colors.black),),
                                      );
                                      }).toList(),
                                      hint:Text(
                                        "Temps",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,),
                                      ),
                                      onChanged: (String value) {
                                        setState(() {
                                          _chosenValueTps = value;
                                        });
                                      }
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
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
                    if(myControllerIntitule.text.isEmpty || myControllerReponses.text.isEmpty) {
                      showError(context, "/!\\ Veuillez ne rien laisser vide svp /!\\");
                    }
                    else{
                      updateQuestion(ancienIntitule, myControllerIntitule.text, myControllerReponses.text, _chosenValue, _chosenValueTps);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsQuiz(nomQuiz : nomQuiz)));
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