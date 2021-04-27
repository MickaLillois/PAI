class UserModel {
  String pseudo;
  String email;
  UserModel({this.pseudo, this.email});
  factory UserModel.fromJson(Map<String,dynamic> i)=>UserModel(
    pseudo: i['PSEUDOUTILISATEUR'],
    email: i['MAILUTILISATEUR']
  );

  Map<String,dynamic> toMap()=>{
    'PSEUDOUTILISATEUR': pseudo,
    'MAILUTILISATEUR': email
  };
}