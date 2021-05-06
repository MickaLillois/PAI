<?php

include("../Connexion/connexion.php");

$mail = $_POST["mail"];
$renvoi;
$q = $connection->prepare("SELECT * FROM UTILISATEUR WHERE MAILUTILISATEUR = ?");
$q->execute(array($mail));
if($q->fetch()!=null)
{
	$renvoi="Adresse mail deja existante";
}	
else
{
    $pseudo = $_POST["pseudo"];//Modifier pour vérifier le pseudo unique
    $query = $connection->prepare("SELECT * FROM UTILISATEUR WHERE PSEUDOUTILISATEUR = ?");
    $query->execute(array($pseudo));
    if($query->fetch()!=null)
    {
      $renvoi="Pseudo deja existant";
    }
    else
    {
      $nom = $_POST["nom"];
      $prenom = $_POST["prenom"];
      $mdp = $_POST["mdp"];
      $dateNaissance = $_POST["dateNaissance"];
      $queryResult = $connection->prepare("INSERT INTO UTILISATEUR VALUES (?, ?, ?, PASSWORD(?), ?, ?, null)");
      $queryResult->execute(array($mail, $prenom, $nom, $mdp, $pseudo, $dateNaissance));
      $q2 = $connection->prepare("INSERT INTO STATSUTILISATEUR VALUES (?, 0, 0, 0, 0, 0, 0, 0, 0, 0)");
      $q2->execute(array($mail));
      $q3 = $connection->prepare("INSERT INTO GESTIONUTILISATEUR VALUES (?, now(), now(), now(), 1, 1)");
      $q3->execute(array($mail));
      $renvoi = "utilisateur cree";
    }
}

  echo $renvoi;

?>