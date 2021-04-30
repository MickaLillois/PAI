import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizinmobile/model/userModel/userModel.dart';
import 'package:flutter_quizinmobile/profilPage.dart';
import 'package:http/http.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Quiz {
  final LinkedHashMap<String, dynamic> quiz;

  Quiz({this.quiz});

  factory Quiz.fromJson(LinkedHashMap<String, dynamic> json) {
    return Quiz(
      quiz: json,
    );
  }
}

class DetailsQuiz extends StatefulWidget{
  DetailsQuiz({Key key, @required this.nomQuiz}) : super(key: key);

  final String nomQuiz;

  DetailsQuizState createState() => DetailsQuizState(nomQuiz: nomQuiz);

}

class DetailsQuizState extends State<DetailsQuiz> {
  String nomQuiz;

  static List<String> imageThumbUrls = [
    "https://lh4.googleusercontent.com/-7-EHhtQthII/URqvEYTk4vI/AAAAAAAAAbs/QSJZoB3YjVg/s240-c/Tenaya%252520Lake%2525202.jpg",
    "https://lh6.googleusercontent.com/-8MrjV_a-Pok/URqvFC5repI/AAAAAAAAAbs/9inKTg9fbCE/s240-c/Tenaya%252520Lake.jpg",
    "https://lh5.googleusercontent.com/-B1HW-z4zwao/URqvFWYRwUI/AAAAAAAAAbs/8Peli53Bs8I/s240-c/The%252520Cave%252520BW.jpg",
    "https://lh3.googleusercontent.com/-PO4E-xZKAnQ/URqvGRqjYkI/AAAAAAAAAbs/42nyADFsXag/s240-c/The%252520Fisherman.jpg",
    "https://lh4.googleusercontent.com/-iLyZlzfdy7s/URqvG0YScdI/AAAAAAAAAbs/1J9eDKmkXtk/s240-c/The%252520Night%252520is%252520Coming.jpg",
    "https://lh6.googleusercontent.com/-G-k7YkkUco0/URqvHhah6fI/AAAAAAAAAbs/_taQQG7t0vo/s240-c/The%252520Road.jpg",
    "https://lh6.googleusercontent.com/-h-ALJt7kSus/URqvIThqYfI/AAAAAAAAAbs/ejiv35olWS8/s240-c/Tokyo%252520Heights.jpg",
    "https://lh5.googleusercontent.com/-Hy9k-TbS7xg/URqvIjQMOxI/AAAAAAAAAbs/RSpmmOATSkg/s240-c/Tokyo%252520Highway.jpg",
    "https://lh6.googleusercontent.com/-83oOvMb4OZs/URqvJL0T7lI/AAAAAAAAAbs/c5TECZ6RONM/s240-c/Tokyo%252520Smog.jpg",
    "https://lh3.googleusercontent.com/-FB-jfgREEfI/URqvJI3EXAI/AAAAAAAAAbs/XfyweiRF4v8/s240-c/Tufa%252520at%252520Night.jpg",
    "https://lh4.googleusercontent.com/-vngKD5Z1U8w/URqvJUCEgPI/AAAAAAAAAbs/ulxCMVcU6EU/s240-c/Valley%252520Sunset.jpg",
    "https://lh6.googleusercontent.com/-DOz5I2E2oMQ/URqvKMND1kI/AAAAAAAAAbs/Iqf0IsInleo/s240-c/Windmill%252520Sunrise.jpg",
    "https://lh5.googleusercontent.com/-biyiyWcJ9MU/URqvKculiAI/AAAAAAAAAbs/jyPsCplJOpE/s240-c/Windmill.jpg",
    "https://lh4.googleusercontent.com/-PDT167_xRdA/URqvK36mLcI/AAAAAAAAAbs/oi2ik9QseMI/s240-c/Windmills.jpg",
    "https://lh5.googleusercontent.com/-kI_QdYx7VlU/URqvLXCB6gI/AAAAAAAAAbs/N31vlZ6u89o/s240-c/Yet%252520Another%252520Rockaway%252520Sunset.jpg",
    "https://lh4.googleusercontent.com/-e9NHZ5k5MSs/URqvMIBZjtI/AAAAAAAAAbs/1fV810rDNfQ/s240-c/Yosemite%252520Tree.jpg",
  ];

  DetailsQuizState({@required this.nomQuiz});

  Future<Quiz> _makePostRequest() async {
    mail = UserModel.getMail();
    Uri url = Uri.https('quizinmobile.alwaysdata.net', 'Utilisateurs/getQuestionsByQuizPerso.php');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    Response response = await post(
        url,
        headers: headers,
        body: {
          'mail': mail,
          'nomQuiz': this.nomQuiz
        }
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return Quiz.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.' + response.statusCode.toString());
    }
  }

  String imageForIndex(int index) {
    return imageThumbUrls[index % imageThumbUrls.length];
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double sizeAvatar = screenSize.width * 0.3;
    double widthLogo = screenSize.width * 0.8;
    double heightLogo = screenSize.height * 0.12;
    double standard = screenSize.width * 0.06;
    double standard2 = screenSize.width * 0.045;
    double standard3 = screenSize.width * 0.038;
    double widthButton = screenSize.width*0.85;
    double marginText = screenSize.width * 0.06;
    double marginImageTop = screenSize.height * 0.05;
    double heightButton = screenSize.height * 0.045;
    _makePostRequest();
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
                    margin: EdgeInsets.fromLTRB(0, marginText, 0, marginText/2),
                    child: Text(
                      'Détail du quiz : $nomQuiz',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: standard
                      ),
                    ),
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return StickyHeader(
                          header: Container(
                            height: 50.0,
                            color: Colors.blueGrey[700],
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.centerLeft,
                            child: Text('Header #$index',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          content: Container(
                            child: Image.network(imageForIndex(index), fit: BoxFit.cover,
                                width: double.infinity, height: 150),
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton : FloatingActionButton(
        onPressed: () => {
          Navigator.pushNamed(context, '/newQuestion'),
        },
        tooltip: 'Nouvelle question',
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

}