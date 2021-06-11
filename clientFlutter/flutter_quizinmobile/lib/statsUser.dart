import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizinmobile/editMdp.dart';
import 'package:flutter_quizinmobile/model/userModel/userModel.dart';
import 'package:http/http.dart';

String scoreMoyen, tauxRep, nbPartiesJouees, ptsUser;

Future<Stats> _makePostRequest() async {
  mail = UserModel.getMail();
  Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Stats/getStats.php');
  Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
  };
  Response response = await post(
      url,
      headers: headers,
      body: {'mail': mail}
  );
  if (response.statusCode == 200) {
    return Stats.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to extract stats.' + response.statusCode.toString());
  }
}

class Stats {
  final String scoreMoyen;
  final String tauxRep;
  final String nbPartiesJouees;
  final String ptsUser;

  Stats({this.scoreMoyen, this.tauxRep, this.nbPartiesJouees, this.ptsUser});

  factory Stats.fromJson(List<dynamic> json) {
    return Stats(
      scoreMoyen: json[0]["SCOREMOYENSTANDARD"],
      tauxRep: json[0]["TAUXBONNEREPONSE"],
      nbPartiesJouees: json[0]["NBPARTIESSTANDARDJOUEES"],
      ptsUser: json[0]["POINTSUTILISATEUR"],
    );
  }
}

class StatsUser extends StatefulWidget {
  StatsUser({Key key, this.title}) : super(key: key);

  final String title;

  @override
  StatsUserState createState() => StatsUserState();
}

class StatsUserState extends State<StatsUser> {
  Future<Stats> _futureStats = _makePostRequest();
  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double sizeAvatar = screenSize.width * 0.3;
    double widthLogo = screenSize.width * 0.8;
    double heightLogo = screenSize.height * 0.12;
    double standard = screenSize.width * 0.06;
    double standard2 = screenSize.width * 0.045;
    double standard3 = screenSize.width * 0.038;
    double widthButton = screenSize.width*0.85;
    double marginText = screenSize.width * 0.06;
    double marginImageTop = screenSize.height * 0.05;
    double heightButton = screenSize.height * 0.045;

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
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
                    child: Text(
                      'Vos statistiques ',
                      style: TextStyle(
                        fontSize: standard,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vos points  :',
                          style: TextStyle(
                            fontSize: standard2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: marginText/2),
                            child: FutureBuilder(
                              future: _futureStats,
                              builder: (context, snapshot){
                                if(snapshot.hasData)
                                {
                                  tauxRep = snapshot.data.ptsUser;
                                  return Text(
                                      snapshot.data.ptsUser,
                                      style: TextStyle(
                                        fontSize: standard2,
                                      )
                                  );
                                  return Text(snapshot.data.dateNaissance);
                                }else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return CircularProgressIndicator();
                              },
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Taux de bonne réponse :',
                          style: TextStyle(
                            fontSize: standard2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: marginText/2),
                            child: FutureBuilder(
                              future: _futureStats,
                              builder: (context, snapshot){
                                if(snapshot.hasData)
                                {
                                  tauxRep = snapshot.data.tauxRep;
                                  return Text(
                                      (double.parse(snapshot.data.tauxRep)*100).toString() + "%",
                                      style: TextStyle(
                                        fontSize: standard2,
                                      )
                                  );
                                  return Text(snapshot.data.dateNaissance);
                                }else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return CircularProgressIndicator();
                              },
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Score moyen en partie :',
                          style: TextStyle(
                            fontSize: standard2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: marginText/2),
                            child: FutureBuilder(
                              future: _futureStats,
                              builder: (context, snapshot){
                                if(snapshot.hasData)
                                {
                                  tauxRep = snapshot.data.scoreMoyen;
                                  return Text(
                                      snapshot.data.scoreMoyen,
                                      style: TextStyle(
                                        fontSize: standard2,
                                      )
                                  );
                                  return Text(snapshot.data.dateNaissance);
                                }else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return CircularProgressIndicator();
                              },
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nombre de parties jouées :',
                          style: TextStyle(
                            fontSize: standard2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: marginText/2),
                            child: FutureBuilder(
                              future: _futureStats,
                              builder: (context, snapshot){
                                if(snapshot.hasData)
                                {
                                  tauxRep = snapshot.data.nbPartiesJouees;
                                  return Text(
                                      snapshot.data.nbPartiesJouees,
                                      style: TextStyle(
                                        fontSize: standard2,
                                      )
                                  );
                                }else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return CircularProgressIndicator();
                              },
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}