import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditMdp extends StatefulWidget {
  EditMdp({Key key}) : super(key: key);

  @override
  EditMdpState createState() => EditMdpState();
}

class EditMdpState extends State<EditMdp> {
  final myControllerLast= TextEditingController();
  final myControllerNew = TextEditingController();
  final myControllerConfirm = TextEditingController();
  bool _obscureText = true;
  String _lastPass;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _obscureText2 = true;
  String _newPass;

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  bool _obscureText3 = true;
  String _confirmPass;

  void _toggle3() {
    setState(() {
      _obscureText3 = !_obscureText3;
    });
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double widthLogo = screenSize.width * 0.8;
    double heightLogo = screenSize.height * 0.12;
    double marginImageTop = screenSize.height * 0.05;
    double fontSizeT1 = screenSize.height*0.055;
    double fontSizeText = screenSize.height*0.027;
    double fontSizeInput = screenSize.height*0.03;
    double widthInput = screenSize.width*0.9;
    double widthInput2 = screenSize.width*0.4;
    double marginText = screenSize.width * 0.06;
    double marginLeftInput = screenSize.width*0.05;

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
                  Container(
                    margin: EdgeInsets.fromLTRB(0, marginText, 0, 0),
                    child: Text(
                      'Modification mot de passe',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeT1*0.9
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(marginLeftInput, marginText*2, 0, marginText*2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text (
                            'Ancien mot de passe : ',
                            style: TextStyle(
                              fontSize: fontSizeText,
                            ),
                          ),
                        ),
                        Container(
                          width: widthInput,
                          child: TextFormField(
                            enableSuggestions: false,
                            autocorrect: false,
                            style: TextStyle(
                              fontSize: fontSizeInput,
                            ),
                            decoration: new InputDecoration(
                                hintText: "Ancien mot de passe",
                                suffixIcon: IconButton(
                                    icon : Icon(_obscureText ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_rounded),
                                    onPressed: _toggle
                                )
                            ),
                            onSaved: (val) => _lastPass = val,
                            obscureText: _obscureText,
                            controller: myControllerLast,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, marginText*2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, marginText*2, 0, 0),
                                child: Text (
                                  'Nouveau mot de passe : ',
                                  style: TextStyle(
                                    fontSize: fontSizeText,
                                  ),
                                ),
                              ),
                              Container(
                                width: widthInput,
                                child: TextFormField(
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  style: TextStyle(
                                    fontSize: fontSizeInput,
                                  ),
                                  decoration: new InputDecoration(
                                      hintText: "Nouveau mot de passe",
                                      suffixIcon: IconButton(
                                          icon : Icon(_obscureText2 ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_rounded),
                                          onPressed: _toggle2
                                      )
                                  ),
                                  onSaved: (val) => _newPass = val,
                                  obscureText: _obscureText2,
                                  controller: myControllerNew,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, marginText),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text (
                                  'Confirmation mot de passe : ',
                                  style: TextStyle(
                                    fontSize: fontSizeText,
                                  ),
                                ),
                              ),
                              Container(
                                width: widthInput,
                                child: TextFormField(
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  style: TextStyle(
                                    fontSize: fontSizeInput,
                                  ),
                                  decoration: new InputDecoration(
                                      hintText: "Confirmation mot de passe",
                                      suffixIcon: IconButton(
                                          icon : Icon(_obscureText3 ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_rounded),
                                          onPressed: _toggle3
                                      )
                                  ),
                                  onSaved: (val) => _newPass = val,
                                  obscureText: _obscureText3,
                                  controller: myControllerConfirm,
                                  onChanged: (text) {
                                    if(text != myControllerNew.text)
                                      {
                                        print("First text field: $text");
                                      }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.topCenter,
                            child: ElevatedButton(
                                onPressed: () {
                                  if(myControllerNew.text != myControllerConfirm.text) {

                                  }
                                },
                                child: Text('Modifier', style: TextStyle(fontSize: fontSizeText),)
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}