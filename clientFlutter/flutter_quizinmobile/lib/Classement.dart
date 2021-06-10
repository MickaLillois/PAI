import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizinmobile/createPartie.dart';
import 'package:flutter_quizinmobile/model/userModel/userModel.dart';
import 'package:http/http.dart';

import 'editMdp.dart';

///Classes permettant la récupération et l'affichage des différents classement (score global, score moyen,...)

class Classement extends StatefulWidget{
  Classement({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => ClassementState();

}


Future<Stats> _makePostRequestScore() async {
  mail = UserModel.getMail();
  Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Stats/getAllStatsScore.php');
  Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
  };
  Response response = await post(
      url,
      headers: headers,
      body: {}
  );
  if (response.statusCode == 200) {
    return Stats.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to extract stats.' + response.statusCode.toString());
  }
}

Future<Stats> _makePostRequestTaux() async {
  mail = UserModel.getMail();
  Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Stats/getAllStatsTaux.php');
  Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
  };
  Response response = await post(
      url,
      headers: headers,
      body: {}
  );
  if (response.statusCode == 200) {
    return Stats.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to extract stats.' + response.statusCode.toString());
  }
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

LinkedHashMap<String, dynamic> getListStats(LinkedHashMap<String, dynamic> list){
  int i = 1;
  while(list["stats$i"]["MAILUTILISATEUR"] != UserModel.getMail() && i < list.length){
    i++;
  }
  return list["stats$i"];
}

class ClassementState extends State<Classement>{


  Color colorNew = Colors.white;
  Color colorP = Colors.white;
  Color colorE = Colors.white;

  Widget wid = Text("");

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
    double widthButton = screenSize.width*0.85;
    double paddingWidget = screenSize.width * 0.01;

    Widget createWidgetTaux(){
      return Container(
        width: widthButton,
        child: FutureBuilder(
          future: _makePostRequestTaux(),
          builder: (context, snapshot){
            if(snapshot.hasData)
            {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      primary: false,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
                          child: index < 5 ? Row(
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
                                  (double.parse(snapshot.data.stats["stats" + (index+1).toString()]["TAUXBONNEREPONSE"])*100).toString() + "%",
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
                      itemCount: 5,
                    ),
                    int.parse(getListStats(snapshot.data.stats)["RANG"]) < 6 ? Text("") : Container(
                      margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
                      child: Row(
                        children: [
                          Text(
                              getListStats(snapshot.data.stats)["RANG"] + " - ",
                              style : TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeT1
                              )
                          ),
                          Text(
                              getListStats(snapshot.data.stats)["PSEUDOUTILISATEUR"] + " : ",
                              style : TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeT1
                              )
                          ),
                          Text(
                              (double.parse(getListStats(snapshot.data.stats)["TAUXBONNEREPONSE"])*100).toString() + "%",
                              style : TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeT1
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      );
    }

    Widget createWidgetPoints(){
      return Container(
        width: widthButton,
        child: FutureBuilder(
          future: _makePostRequest(),
          builder: (context, snapshot){
            if(snapshot.hasData)
            {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      primary: false,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
                          child: index < 5 ? Row(
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
                      itemCount: 5,
                    ),
                    int.parse(getListStats(snapshot.data.stats)["RANG"]) < 6 ? Text("") : Container(
                      margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
                      child: Row(
                        children: [
                          Text(
                              getListStats(snapshot.data.stats)["RANG"] + " - ",
                              style : TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeT1
                              )
                          ),
                          Text(
                              getListStats(snapshot.data.stats)["PSEUDOUTILISATEUR"] + " : ",
                              style : TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeT1
                              )
                          ),
                          Text(
                              getListStats(snapshot.data.stats)["POINTSUTILISATEUR"] + " points",
                              style : TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeT1
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      );
    }

    Widget createWidgetScore(){
      return Container(
        width: widthButton,
        child: FutureBuilder(
          future: _makePostRequestScore(),
          builder: (context, snapshot){
            if(snapshot.hasData)
            {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      primary: false,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
                          child: index < 5 ? Row(
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
                                  snapshot.data.stats["stats" + (index+1).toString()]["SCOREMOYENSTANDARD"] + " points",
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
                      itemCount: 5,
                    ),
                    int.parse(getListStats(snapshot.data.stats)["RANG"]) < 6 ? Text("") : Container(
                      margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
                      child: Row(
                        children: [
                          Text(
                              getListStats(snapshot.data.stats)["RANG"] + " - ",
                              style : TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeT1
                              )
                          ),
                          Text(
                              getListStats(snapshot.data.stats)["PSEUDOUTILISATEUR"] + " : ",
                              style : TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeT1
                              )
                          ),
                          Text(
                              getListStats(snapshot.data.stats)["SCOREMOYENSTANDARD"] + " points",
                              style : TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeT1
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      );
    }

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
                  margin: EdgeInsets.fromLTRB(0,marginLogo,0,0),
                  child : Text(
                    'Classement des meilleurs joueurs',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeT1
                    ),
                  )
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0,marginLogo,0,0),
                width: screenSize.width,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          colorNew = Colors.grey;
                          colorP = Colors.white;
                          colorE = Colors.white;
                          wid = createWidgetPoints();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(paddingWidget),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 3,
                          ),
                          color: colorNew,
                        ),
                        child: Text(
                            'Points utilisateurs'
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          colorP = Colors.grey;
                          colorNew = Colors.white;
                          colorE = Colors.white;
                          wid = createWidgetTaux();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(paddingWidget),
                        decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.black,
                                width: 3.0,
                              ),
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 3.0,
                              ),
                            ),
                            color: colorP
                        ),
                        child: Text(
                            'Taux bonne réponse'
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          colorE = Colors.grey;
                          colorNew = Colors.white;
                          colorP = Colors.white;
                          wid = createWidgetScore();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(paddingWidget),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                            color: colorE
                        ),
                        child: Text(
                            'Score moyen'
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              wid,
            ],
          ),
        ),
      ),
    );
  }

}