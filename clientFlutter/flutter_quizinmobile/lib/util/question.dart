class Question{
  String intitule;
  List<String> reponses;
  int nbChances;
  double temps;

  Question(String intitule, String reponses, int nbChances, temps){
    this.intitule=intitule;
    this.nbChances=nbChances;
    this.temps=temps;
    this.reponses = reponses.split("/");
  }
}