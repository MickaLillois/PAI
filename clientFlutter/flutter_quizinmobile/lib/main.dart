import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quizinmobile/profilPage.dart';
import 'package:flutter/src/material/icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: MyHomePage(title: 'Rudy trop beau'),
        routes: {
          //'/': (context) => MyHomePage(title: "Connexion"),
          '/profilPage': (context) => ProfilPage(),
        },
        initialRoute: '/'
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Center(
          child: Column(
              children: <Widget>[
                Container(
                    child: Image.asset('assets/images/logo_with_text.PNG'),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: IconButton(
                    icon: const Icon(Icons.account_circle),
                    color: Colors.black,
                    iconSize: 50,
                    onPressed: () {
                      Navigator.pushNamed(context, '/profilPage');
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: screenSize.width*0.85,
                  child: ElevatedButton(
                    child: Column(children: <Widget>[
                      Container(child: Text('Mode Standard', style: TextStyle(fontSize: 30.0),),),
                      Container(child: Text('Rejoindre une partie rapide', style: TextStyle(fontSize: 12.0),),),
                    ]),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // background
                      onPrimary: Colors.white, // foreground
                      padding: EdgeInsets.all(20.0),
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: screenSize.width*0.85,
                  child: ElevatedButton(
                    child: Column(children: <Widget>[
                      Container(child: Text('Mode Battle Royal', style: TextStyle(fontSize: 30.0),),),
                      Container(child: Text('Rejoindre une partie rapide', style: TextStyle(fontSize: 12.0),),),
                    ]),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // background
                      onPrimary: Colors.white, // foreground
                      padding: EdgeInsets.all(20.0),
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: screenSize.width*0.85,
                  child: ElevatedButton(
                    child: Column(children: <Widget>[
                      Container(child: Text('Partie privée', style: TextStyle(fontSize: 30.0),),),
                      Container(child: Text('Rejoindre le menu de partie privée', style: TextStyle(fontSize: 12.0),),),
                    ]),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // background
                      onPrimary: Colors.white, // foreground
                      padding: EdgeInsets.all(20.0),
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: screenSize.width*0.85,
                  child: ElevatedButton(
                    child: Text('Proposer une question', style: TextStyle(fontSize: 20.0),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // background
                      onPrimary: Colors.white, // foreground
                      padding: EdgeInsets.all(10.0),
                    ),
                    onPressed: () {},
                  ),
                ),
              ]
          ),
          ),
        ));
  }
}
