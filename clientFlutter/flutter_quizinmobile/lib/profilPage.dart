import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sizeAvatar = screenSize.width * 0.3;
    double widthLogo = screenSize.width * 0.8;
    double heightLogo = screenSize.height * 0.3;
    double standard = screenSize.width * 0.05;
    double standard2 = screenSize.width * 0.035;
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
                  alignment: Alignment.topCenter,
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
                  margin: EdgeInsets.symmetric(horizontal: standard, vertical: standard),
                  child: Image.asset(
                    'assets/images/avatar_test_2.png',
                    height: sizeAvatar,
                    width: sizeAvatar,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: standard*1.5),
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
                        margin: EdgeInsets.symmetric(vertical: standard/2),
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
                        margin : EdgeInsets.fromLTRB(0, standard/2, 0, 0),
                        child: Text(
                          '<NOM>',
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}