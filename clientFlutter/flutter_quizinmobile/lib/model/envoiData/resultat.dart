class Resultat {
  final String email;
  final String scorePartie;
  final String tpsReponseMoy;
  final String tauxBonneRep;
  final String nbQuestions;
  final String ptsUser;
  final String classement;

  Resultat(this.email, this.scorePartie, this.nbQuestions, this.classement, this.ptsUser, this.tauxBonneRep, this.tpsReponseMoy);

  Resultat.fromJson(Map<String, dynamic> json)
      : scorePartie = json['scorePartie'],
        email = json['email'],
        nbQuestions = json['nbQuestions'],
        classement = json['classement'],
        ptsUser = json['ptsUser'],
        tauxBonneRep = json['tauxBonneRep'],
        tpsReponseMoy = json["tpsReponseMoy"];

  Map<String, dynamic> toJson() => {
    'scorePartie': scorePartie,
    'email': email,
    'nbQuestions': nbQuestions,
    'classement': classement,
    'ptsUser': ptsUser,
    'tauxBonneRep': tauxBonneRep,
    'tpsReponseMoy': tpsReponseMoy
  };
}