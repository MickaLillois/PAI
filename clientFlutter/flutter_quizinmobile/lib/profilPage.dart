import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizinmobile/editProfil.dart';
import 'package:http/http.dart';

String mail = 'ruru4.matt@gmail.com';
String pseudo, nom, prenom, dateNaissance;

Future<User> _makePostRequest() async {
  Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Utilisateurs/getInfosByUser.php');
  Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
  };
  Response response = await post(
      url,
      headers: headers,
      body: {'mail': mail}
  );
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create user.' + response.statusCode.toString());
  }
}

class User {
  final String prenom;
  final String nom;
  final String pseudo;
  final String dateNaissance;

  User({this.prenom, this.nom, this.pseudo, this.dateNaissance});

  factory User.fromJson(List<dynamic> json) {
    return User(
      prenom: json[0]["PRENOM"],
      nom: json[0]["NOM"],
      pseudo: json[0]["PSEUDO"],
      dateNaissance: json[0]["DATENAISSANCE"],
    );
  }
}

class ProfilPage extends StatefulWidget {
  ProfilPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ProfilPageState createState() => ProfilPageState();
}

class ProfilPageState extends State<ProfilPage> {
  Future<User> _futureUser = _makePostRequest();
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
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.fromLTRB(marginText, marginText, 0, 0),
                    child: Row(
                      children: [
                        Text('Profil utilisateur de ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: standard,
                            )
                        ),
                        FutureBuilder(
                          future: _futureUser,
                          builder: (context, snapshot){
                            if(snapshot.hasData)
                            {
                              pseudo = snapshot.data.pseudo;
                              return Text(
                                  snapshot.data.pseudo,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: standard,
                                  )
                              );
                            }else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return CircularProgressIndicator();
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(marginText, marginText, marginText, 0),
                    child: Image.asset(
                      'assets/images/avatar_test_2.png',
                      height: sizeAvatar,
                      width: sizeAvatar,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: marginText),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prénom :',
                          style: TextStyle(
                            fontSize: standard2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: marginText/2),
                            child: FutureBuilder(
                              future: _futureUser,
                              builder: (context, snapshot){
                                if(snapshot.hasData)
                                {
                                  prenom = snapshot.data.prenom;
                                  return Text(
                                      snapshot.data.prenom,
                                      style: TextStyle(
                                        fontSize: standard3,
                                      )
                                  );
                                }else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return CircularProgressIndicator();
                              },
                            )
                        ),
                        Text(
                          'Nom :',
                          style: TextStyle(
                            fontSize: standard2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            margin : EdgeInsets.fromLTRB(0, marginText/2, 0, 0),
                            child: FutureBuilder(
                              future: _futureUser,
                              builder: (context, snapshot){
                                if(snapshot.hasData)
                                {
                                  nom = snapshot.data.nom;
                                  return Text(
                                      snapshot.data.nom,
                                      style: TextStyle(
                                        fontSize: standard3,
                                      )
                                  );
                                }else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return CircularProgressIndicator();
                              },
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: marginText),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date de naissance :',
                      style: TextStyle(
                        fontSize: standard2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: marginText/2),
                        child: FutureBuilder(
                          future: _futureUser,
                          builder: (context, snapshot){
                            if(snapshot.hasData)
                            {
                              dateNaissance = snapshot.data.dateNaissance;
                              return Text(
                                  snapshot.data.dateNaissance,
                                  style: TextStyle(
                                    fontSize: standard3,
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
                margin: EdgeInsets.symmetric(horizontal: marginText),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pseudo :',
                      style: TextStyle(
                        fontSize: standard2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: marginText/2),
                        child: FutureBuilder(
                          future: _futureUser,
                          builder: (context, snapshot){
                            if(snapshot.hasData)
                            {
                              return Text(
                                  snapshot.data.pseudo,
                                  style: TextStyle(
                                    fontSize: standard3,
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: marginText),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Adresse mail :',
                      style: TextStyle(
                        fontSize: standard2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: marginText/2),
                      child: Text(
                        '$mail',
                        style: TextStyle(
                          fontSize: standard3,
                        ),
                      ),
                    ),
                    Container(
                      width: widthButton,
                      height: heightButton,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, marginText/2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            onPrimary: Colors.white
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfil(pseudo: pseudo, prenom: prenom, nom: nom, mail: mail)));
                        },
                        child: Text(
                          'Modifier le profil',
                          style: TextStyle(fontSize: standard3),
                        ),
                      ),
                    ),
                    Container(
                      width: widthButton,
                      height: heightButton,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, marginText/2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            onPrimary: Colors.white
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/editMdp');
                        },
                        child: Text(
                          'Modifier le mot de passe',
                          style: TextStyle(fontSize: standard3),
                        ),
                      ),
                    ),
                    Container(
                      width: widthButton,
                      height: heightButton,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            onPrimary: Colors.white
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/statsUser');
                        },
                        child: Text(
                          'Accéder aux statistiques',
                          style: TextStyle(fontSize: standard3),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width : widthButton/2,
                          margin : EdgeInsets.fromLTRB(0, marginText/2.5, 0, 0),
                          child: InkWell(
                            child: Text(
                              'Se déconnecter',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => false,
                          ),
                        ),
                        Container(
                          margin : EdgeInsets.fromLTRB(0, marginText/2.5, 0, 0),
                          width : widthButton/2,
                          alignment: Alignment.topRight,
                          child: InkWell(
                            child: Text(
                              'Supprimer son compte',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}