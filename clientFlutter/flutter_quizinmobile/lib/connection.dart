import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Connection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Size screenSize = MediaQuery.of(context).size;
    double widthLogo = screenSize.width*0.8;
    double heightLogo = screenSize.height*0.2;
    double marginLogo = screenSize.height*0.05;
    double fontSizeT1 = screenSize.height*0.045;
    double fontSizeText = screenSize.height*0.03;
    double fontSizeInput = screenSize.height*0.025;
    double fontSizeLink = screenSize.height*0.015;
    double widthInput = screenSize.width*0.9;
    double marginLeftInput = screenSize.width*0.05;
    return Scaffold(
      body: Center(
          child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0,marginLogo,0,marginLogo),
                  child: Image.asset(
                    'assets/images/logo_png.png',
                    width : widthLogo,
                    height: heightLogo,
                  ),
                ),
                Text(
                  'Se connecter',
                  style: TextStyle(fontSize: fontSizeT1, color: Colors.indigo),),
                Form(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(marginLeftInput,marginLogo,0,marginLogo/2),
                        child: Text('Identifiant :',style: TextStyle(fontSize: fontSizeText)),
                      ),
                      Container(
                        width: widthInput,
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: fontSizeInput,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Entrez votre email',
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.fromLTRB(marginLeftInput,marginLogo*2,0,marginLogo/2),
                          child: Text('Mot de passe :',style: TextStyle(fontSize: fontSizeText))
                      ),
                      Container(
                        width: widthInput,
                        child: TextFormField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: TextStyle(
                            fontSize: fontSizeInput,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Entrez votre mot de passe',
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0,marginLogo,0,marginLogo),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text('Valider', style: TextStyle(fontSize: fontSizeText),))
                      ),
                      Container(
                        child: new InkWell(
                            child: new Text('Pas encore de compte ? Cliquez ici pour vous inscrire.', style: TextStyle(fontSize: fontSizeLink)),
                            onTap: () => Navigator.pushNamed(context, '/inscription')
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