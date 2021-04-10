import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

Future<User> _makePostRequest() async {
  String mail = 'ruru4.matt@gmail.com';
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

  User({this.prenom, this.nom, this.pseudo});

  factory User.fromJson(List<dynamic> json) {
    return User(
      prenom: json[0]["PRENOM"],
      nom: 'oui',
      pseudo: 'test',
    );
  }
}
class ProfilPage extends StatelessWidget {
  Future<User> _futureUser = _makePostRequest();
  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double sizeAvatar = screenSize.width * 0.3;
    double widthLogo = screenSize.width * 0.8;
    double heightLogo = screenSize.height * 0.2;
    double standard = screenSize.width * 0.07;
    double standard2 = screenSize.width * 0.045;
    double widthButton = screenSize.width*0.85;
    double marginText = screenSize.width * 0.06;
    double marginImageTop = screenSize.height * 0.05;
    double heightButton = screenSize.height * 0.055;
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
                        'assets/images/logo_png.png',
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
                    margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
                    child: Text('Profil utilisateur de <PSEUDO>',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: standard,
                        )
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: marginText, vertical: marginText),
                    child: Image.asset(
                      'assets/images/avatar_test_2.png',
                      height: sizeAvatar,
                      width: sizeAvatar,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: marginText*1.2),
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
                                  return Text(snapshot.data.prenom);
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
                          child: Text(
                            '<NOM>',
                          ),
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
                      child: Text(
                          '<DATENAISSANCE>'
                      ),
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
                      child: Text(
                          '<PSEUDO>'
                      ),
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
                          '<MAIL>'
                      ),
                    ),
                    Container(
                      width: widthButton,
                      height: heightButton,
                      margin: EdgeInsets.fromLTRB(0, marginText/2, 0, marginText/2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            onPrimary: Colors.white
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/editProfil');
                        },
                        child: Text(
                            'Modifier le profil',
                          style: TextStyle(fontSize: standard2),
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
                          style: TextStyle(fontSize: standard2),
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
                          style: TextStyle(fontSize: standard2),
                        ),
                      ),
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