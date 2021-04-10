import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class StatsUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<String> _makePostRequest() async {
      String url = 'https://quizinmobile.alwaysdata.net/Utilisateurs/getInfosByUser.php';
      Map<String, String> headers = {"Content-type": "application/json"};
      String json = '{"mail": "ruru4.matt@gmail.com"}';
      Response response = await post(url, headers: headers, body: json);
      int statusCode = response.statusCode;
      String body = response.body;
      return body;
    }
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
                    'coucou $_makePostRequest()',
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