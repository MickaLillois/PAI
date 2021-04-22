import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class Jouer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        /*child: ElevatedButton(
          child: Text('Ping', style: TextStyle(fontSize: 25.0),),
          onPressed: () {
            IO.Socket socket = IO.io('https://quizinmobile.herokuapp.com/partie1');
            socket.onConnect((_) {
              print('connect');
              socket.emit('msg', 'test');
            });
            socket.on('message', (data) => print(data));
            socket.onDisconnect((_) => print('disconnect'));
          },
        ),*/

      ),
    );

  }
}