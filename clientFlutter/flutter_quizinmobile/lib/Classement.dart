import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizinmobile/createPartie.dart';
import 'package:flutter_quizinmobile/model/userModel/userModel.dart';
import 'package:http/http.dart';

import 'editMdp.dart';

class Classement extends StatefulWidget{
  Classement({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => ClassementState();

}

Future<Stats> _makePostRequest() async {
  mail = UserModel.getMail();
  Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Stats/getAllStats.php');
  Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
  };
  Response response = await post(
      url,
      headers: headers,
      body: {}
  );
  if (response.statusCode == 200) {
    log(response.body);
    return Stats.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to extract stats.' + response.statusCode.toString());
  }
}

class Stats {
  final LinkedHashMap<String, dynamic> stats;

  Stats({this.stats});

  factory Stats.fromJson(LinkedHashMap<String, dynamic> json) {
    return Stats(
        stats: json
    );
  }
}

class ClassementState extends State<Classement>{

  @override
  Widget build(BuildContext context) {

    //Variables de responsivité
    Size screenSize = MediaQuery.of(context).size;

    double widthLogo = screenSize.width*0.8;
    double heightLogo = screenSize.height*0.12;
    double marginLogo = screenSize.height*0.05;
    double fontSizeT1 = screenSize.height*0.035;
    double fontSizeT2 = screenSize.height*0.03;
    double marginText = screenSize.width * 0.06;
    double marginButton = screenSize.height*0.02;
    double widthButton = screenSize.width*0.85;
    double paddingButtonJeu = screenSize.height*0.03;

    bool estPasse = false;

    _makePostRequest();

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
                width: widthButton,
                child: FutureBuilder(
                  future: _makePostRequest(),
                  builder: (context, snapshot){
                    if(snapshot.hasData)
                    {
                      return ListView.builder(
                        primary: false,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
                            child: (estPasse == false && index == 5) ? Row(
                              children: [
                                Text(
                                    snapshot.data.stats["stats" + (index+1).toString()]["RANG"] + " - ",
                                    style : UserModel.getMail() == snapshot.data.stats["stats" + (index+1).toString()]["MAILUTILISATEUR"] ? TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeT1
                                    ) : TextStyle(
                                        fontSize: fontSizeT2
                                    )
                                ),
                                Text(
                                    snapshot.data.stats["stats" + (index+1).toString()]["PSEUDOUTILISATEUR"] + " : ",
                                    style : UserModel.getMail() == snapshot.data.stats["stats" + (index+1).toString()]["MAILUTILISATEUR"] ? TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeT1
                                    ) : TextStyle(
                                        fontSize: fontSizeT2
                                    )
                                ),
                                Text(
                                    snapshot.data.stats["stats" + (index+1).toString()]["POINTSUTILISATEUR"] + " points",
                                    style : UserModel.getMail() == snapshot.data.stats["stats" + (index+1).toString()]["MAILUTILISATEUR"] ? TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeT1
                                    ) : TextStyle(
                                        fontSize: fontSizeT2
                                    )
                                ),
                              ],
                            ) : index < 5 ? Row(
                              children: [
                                Text(
                                    (index + 1).toString() + " - ",
                                    style : UserModel.getMail() == snapshot.data.stats["stats" + (index+1).toString()]["MAILUTILISATEUR"] ? TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeT1
                                    ) : TextStyle(
                                        fontSize: fontSizeT2
                                    )
                                ),
                                Text(
                                    snapshot.data.stats["stats" + (index+1).toString()]["PSEUDOUTILISATEUR"] + " : ",
                                    style : UserModel.getMail() == snapshot.data.stats["stats" + (index+1).toString()]["MAILUTILISATEUR"] ? TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeT1
                                    ) : TextStyle(
                                        fontSize: fontSizeT2
                                    )
                                ),
                                Text(
                                    snapshot.data.stats["stats" + (index+1).toString()]["POINTSUTILISATEUR"] + " points",
                                    style : UserModel.getMail() == snapshot.data.stats["stats" + (index+1).toString()]["MAILUTILISATEUR"] ? TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeT1
                                    ) : TextStyle(
                                        fontSize: fontSizeT2
                                    )
                                ),
                              ],
                            ) : Text(""),
                          );
                        },
                        itemCount: 6,
                      );
                    }else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
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