import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Connection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthLogo = screenSize.width*0.8;
    double heightLogo = screenSize.height*0.2;
    return Scaffold(
      body: Center(
          child: Column(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'assets/images/logo_png.png',
                    width : widthLogo,
                    height: heightLogo,
                  ),
                ),
                Text('Se connecter'),
                Form(
                  child: Column(
                    children: [
                      Text('Identifiant :'),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Entrez votre email',
                        ),
                      ),
                      Text('Mot de passe :'),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                        ),
                      ),
                    ],
                  ),
                ),
              ]
          )
      ),
    );
  }
}