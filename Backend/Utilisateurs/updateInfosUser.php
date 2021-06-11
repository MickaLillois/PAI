<?php

include("../Connexion/connexion.php");

$mail = $_POST["mail"];
$nom = $_POST["nom"];
$prenom = $_POST["prenom"];
$pseudo = $_POST["pseudo"];

$q = $connection->prepare("SELECT * FROM UTILISATEUR WHERE PSEUDOUTILISATEUR = ? AND MAILUTILISATEUR <> ?");
$q->execute(array($pseudo, $mail));
if($q->fetch() != null)
{
	echo "-1";
}
else
{
  $queryResult = $connection->prepare("UPDATE UTILISATEUR SET NOMUTILISATEUR = ?, PRENOMUTILISATEUR = ?, PSEUDOUTILISATEUR = ? WHERE MAILUTILISATEUR = ?");
  $queryResult->execute(array($nom, $prenom, $pseudo, $mail));

  echo $queryResult->rowcount();
}
  

?>