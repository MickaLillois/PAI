import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinPartieStandard extends StatefulWidget{
  FinPartieStandard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => FinPartieStandardState();

}

class FinPartieStandardState extends State<FinPartieStandard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("ok"),
    );
  }

}