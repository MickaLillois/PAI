import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfil extends StatelessWidget {
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