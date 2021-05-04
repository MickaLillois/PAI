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
    if(data!=null){
      var decode = jsonDecode(data);
      var user = await UserModel.fromJson(decode);
      sessionUser = user;
    }else{
      sessionUser=null;
    }
  }

  static String getMail() {
    return sessionUser.email;
  }

  static void logOut() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    //pref.setString("user", null);
    pref.remove("user");
    sessionUser=null;
    pref.commit();
  }
}