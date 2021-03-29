<?php

include("../Connexion/connexion.php");

$mail = $_GET["mail"];
  $q = $connection->prepare("UPDATE GESTIONUTILISATEUR SET DATEDERNIERECONNEXION = now() WHERE MAILUTILISATEUR = ?");
  $q->execute(array($mail));
  echo "dernière connexion mise à jour";

?>