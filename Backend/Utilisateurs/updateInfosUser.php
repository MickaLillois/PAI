<?php

include("../Connexion/connexion.php");

$mail = $_POST["mail"];
$nom = $_POST["nom"];
$prenom = $_POST["prenom"];
$pseudo = $_POST["pseudo"];
  $queryResult = $connection->prepare("UPDATE UTILISATEUR SET NOMUTILISATEUR = ?, PRENOMUTILISATEUR = ?, PSEUDOUTILISATEUR = ? WHERE MAILUTILISATEUR = ?");
  $queryResult->execute(array($nom, $prenom, $pseudo, $mail));

  echo $queryResult->rowcount();

?>