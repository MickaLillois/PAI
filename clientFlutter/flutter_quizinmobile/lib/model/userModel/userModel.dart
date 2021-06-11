/// Classe permettant la gestion de session utilisateur

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

  /// permet d'enregistrer un utilisateur
  static void saveUser(UserModel user) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = jsonEncode(user.toMap());
    pref.setString("user", data);
    pref.commit();
  }

  /// permet de récupérer un utilisateur pour le définir en tant que utilisateur courant
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

  /// récupère le mail de l'utilisateur courant
  static String getMail() {
    return sessionUser.email;
  }

  /// permet de supprimer l'utilisateur de la session courante (le déconnecter)
  static void logOut() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    //pref.setString("user", null);
    pref.remove("user");
    sessionUser=null;
    pref.commit();
  }
}