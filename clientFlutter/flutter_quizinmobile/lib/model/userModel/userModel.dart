import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String email;
  UserModel({this.email});
  static UserModel sessionUser;
  factory UserModel.fromJson(Map<String,dynamic> i)=>UserModel(
      email: i['MAILUTILISATEUR']
  );

  Map<String,dynamic> toMap()=>{
    'MAILUTILISATEUR': email
  };

  static void saveUser(UserModel user) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = jsonEncode(user.toMap());
    pref.setString("user", data);
    pref.commit();
  }

  static void getUser() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString("user");
    var decode = jsonDecode(data);
    var user = await UserModel.fromJson(decode);
    sessionUser = user;
    print(sessionUser.email);
  }
}