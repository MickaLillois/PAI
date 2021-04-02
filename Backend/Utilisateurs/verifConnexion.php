<?php

include("../Connexion/connexion.php");

$mail = $_GET["mail"];
$mdp = $_GET["mdp"];
$renvoi;
  $q = $connection->prepare("SELECT MAILUTILISATEUR FROM UTILISATEUR WHERE MAILUTILISATEUR = ? AND MDPUTILISATEUR = password(?)");
  $q->execute(array($mail, $mdp));
  if($q->fetch()!=null)
  {
      $renvoi="Bon mot de passe";
  }	
  else
  {
      $renvoi="Mauvais mot de passe";
  }

  echo $renvoi;
?>