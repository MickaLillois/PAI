import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfil extends StatelessWidget {
  final String pseudo;
  final String prenom;
  final String nom;

  EditProfil({Key key, @required this.pseudo, @required this.prenom, @required this.nom}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double widthLogo = screenSize.width * 0.8;
    double heightLogo = screenSize.height * 0.12;
    double marginImageTop = screenSize.height * 0.05;

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
                  Text(
                    pseudo + '/' + prenom + '/' + nom,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}