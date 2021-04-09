import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
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
                          child: Text(
                              '<PRENOM>'
                          ),
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
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          onPrimary: Colors.white
                        ),
                          onPressed: () {},
                          child: Text(
                            'Modifier le profil'
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