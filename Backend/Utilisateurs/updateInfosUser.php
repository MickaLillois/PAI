<?php

include("../Connexion/connexion.php");

$mail = $_GET["mail"];
$nom = $_GET["nom"];
$prenom = $_GET["prenom"];
$pseudo = $_GET["pseudo"];
  $queryResult = $connection->prepare("UPDATE UTILISATEUR SET NOMUTILISATEUR = ?, PRENOMUTILISATEUR = ?, PSEUDOUTILISATEUR = ? WHERE MAILUTILISATEUR = ?");
  $queryResult->execute(array($nom, $prenom, $pseudo, $mail));

  echo "utilisateur mis à jour";

?>