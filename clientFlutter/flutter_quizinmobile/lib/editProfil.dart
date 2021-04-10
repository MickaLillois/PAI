import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfil extends StatelessWidget {
  final String pseudo;
  final String prenom;
  final String nom;

  EditProfil({Key key, @required this.pseudo, @required this.prenom, @required this.nom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SingleChildScrollView(
        child : Container(
          child : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/logo_png.png',
                        width : 500,
                        height: 100,

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