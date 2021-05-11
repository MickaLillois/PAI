import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class PartieStandard extends StatefulWidget{
  PartieStandard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => PartieStandardState();

}

class PartieStandardState extends State<PartieStandard>{
  int cpt=1;
  HashMap<String, HashMap<String,String>> questions;

  Future<String> _makePostRequest(String nbQuestions) async {
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Questions/getQuestions.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Response response = await post(
        url,
        headers: headers,
        body: {
          'nbQuestions': nbQuestions
        }
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Erreur dans la récupération des questions' + response.statusCode.toString());
    }
  }

  Future<void> initQuestions() async {
    var questionsTmp = jsonDecode(await _makePostRequest('9'));
    questionsTmp.forEach((key, value) {
      print (key);
    });
    HashMap<String, HashMap<String,String>> attributs = new HashMap.from(questionsTmp.map(
            (key, value){
          HashMap<String,String> attrs = new HashMap.from(value.map(
                  (key2,value2){
                return MapEntry(key2.toString(), value2.toString());
              }
          ));
          return MapEntry(
              key.toString(),
              attrs
          );
        }
    ));
    questions = attributs;

    questions.forEach((key, value) {
      print (key);
    });

    print(questions);
    print('init good');
  }

  String getInfo(String key){
    String txt = questions["Question$cpt"][key];
    print(txt);
    //cpt++;
    return txt;
  }

  @override
  void initState() {
    initQuestions();
    super.initState();
  }

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


    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0,marginLogo,0,0),
                child: Image.asset('assets/images/logo_officiel.png',width: widthLogo, height: heightLogo),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                        child: Text('Question n°$cpt')
                    ),
                    Container(
                        child: Text(getInfo('INTITULE'))
                    )
                  ],
                ),
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Entrez votre réponse',
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text('Initialiser questions', style: TextStyle(fontSize: 25.0),),
                  onPressed: () {
                    initQuestions();
                  },
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text('Next question', style: TextStyle(fontSize: 25.0),),
                  onPressed: () {
                    if(cpt==9){
                      Navigator.pop(context);
                    }else{
                      setState(() {
                        cpt ++;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}