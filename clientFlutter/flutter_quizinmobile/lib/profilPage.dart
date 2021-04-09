import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body :
      Container(
        child : Column(
          children: <Widget>[
            Column(
              children: [
                Container(
                  child: Image.asset('assets/images/logo_with_text.PNG'

                  )
                )
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text('Profil utilisateur',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}