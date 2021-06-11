<?php

include("../Connexion/connexion.php");

$mail = $_POST["mail"];
$mdp = $_POST["mdp"];
$renvoi;
  $q = $connection->prepare("SELECT MAILUTILISATEUR FROM UTILISATEUR WHERE MAILUTILISATEUR = ? AND MDPUTILISATEUR = password(?)");
  $q->execute(array($mail, $mdp));
  if($q->fetch()!=null)
  {
      $renvoi="Bon mot de passe";
  }	
  else
  {
      $renvoi="Mauvais email ou mot de passe";
  }

  echo $renvoi;
?>