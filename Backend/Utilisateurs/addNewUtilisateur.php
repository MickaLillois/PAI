<?php

include("../Connexion/connexion.php");

$mail = $_GET["mail"];
$renvoi;
$q = $connection->prepare("SELECT * FROM UTILISATEUR WHERE MAILUTILISATEUR = ?");
$q->execute(array($mail));
if($q->fetch()!=null)
{
	$renvoi="adresse mail existante";
}	
else
{
    $nom = $_GET["nom"];
    $prenom = $_GET["prenom"];
    $mdp = $_GET["mdp"];
    $pseudo = $_GET["pseudo"];
    $dateNaissance = $_GET["dateNaissance"];
    $queryResult = $connection->prepare("INSERT INTO UTILISATEUR VALUES (?, ?, ?, PASSWORD(?), ?, ?)");
    $queryResult->execute(array($mail, $prenom, $nom, $mdp, $pseudo, $dateNaissance));
    $q2 = $connection->prepare("INSERT INTO STATSUTILISATEUR VALUES (?, 0, 0, 0, 0, 0, 0, 0, 0, 0)");
    $q2->execute(array($mail));
    $q3 = $connection->prepare("INSERT INTO GESTIONUTILISATEUR VALUES (?, now(), now(), now(), 1, 1)");
    $q3->execute(array($mail));
    $renvoi = "utilisateur ajouté";
}

  echo $renvoi;

?>