<?php

include("../Connexion/connexion.php");

$pseudo = $_POST["pseudo"];
$renvoi;
  $q = $connection->prepare("SELECT * FROM UTILISATEUR WHERE PSEUDOUTILISATEUR = ? ");
  $q->execute(array($pseudo));
  if($q->fetch()!=null)
  {
      $renvoi="true";
  }	
  else
  {
      $renvoi="false";
  }

  echo $renvoi;
?>