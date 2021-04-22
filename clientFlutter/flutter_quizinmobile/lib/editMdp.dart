import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

String mail = 'ruru4.matt@gmail.com';

class EditMdp extends StatefulWidget {
  EditMdp({Key key}) : super(key: key);

  @override
  EditMdpState createState() => EditMdpState();
}

class EditMdpState extends State<EditMdp> {

  Future<String> updateMdp(String newMdp, String ancienMdp) async {
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Utilisateurs/updateMdpUser.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Response response = await post(
        url,
        headers: headers,
        body: {
          'newMdp': newMdp,
          'ancienMdp': ancienMdp,
          'mail': mail
        }
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update user.' + response.statusCode.toString());
    }
  }


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
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.topCenter,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if(myControllerNew.text == "" || myControllerConfirm.text == "" || myControllerLast.text == ""){
                                    showError(context, "/!\\ Merci de remplir tous les champs pour modifier le mot de passe /!\\");
                                  }
                                  else{
                                    if(myControllerNew.text != myControllerConfirm.text) {
                                      showError(context, "/!\\ Confirmation de mot de passe différente du nouveau mot de passe /!\\");
                                    }
                                    else{
                                      final String res = await updateMdp(myControllerNew.text, myControllerLast.text);
                                      print(res);
                                      if(res == "-2"){
                                        showError(context, "/!\\ Nouveau mot de passe identique à l'ancien /!\\");
                                      }
                                      else if(res == "-1"){
                                        showError(context, "/!\\ Ancien mot de passe pas correct /!\\");
                                      }
                                      else{
                                        Navigator.of(context).pop();
                                      }
                                    }
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

  showError(BuildContext context, String err) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      elevation: 0,
      title: Text("Attention"),
      content: Text(err),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}