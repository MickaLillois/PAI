import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sizeAvatar = screenSize.width * 0.3;
    double widthLogo = screenSize.width * 0.8;
    double heightLogo = screenSize.height * 0.2;
    return Scaffold(
      body :
      Container(
        child : Column(
          children: <Widget>[
            Column(
              children: [
                Container(
                    child: Image.asset(
                      'assets/images/logo_png.png',
                      width : widthLogo,
                      height: heightLogo,

                    )
                )
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text('Profil utilisateur de <PSEUDO>',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      )
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Image.asset(
                    'assets/images/avatar_test_2.png',
                    height: sizeAvatar,
                    width: sizeAvatar,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      child: Text(
                        'Prénom :',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                          '<PRENOM>'
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}