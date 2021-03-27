<?php

include("../Connexion/connexion.php");

$mail = $_GET["mail"];
  $queryResult = $connection->prepare("DELETE FROM UTILISATEUR WHERE MAILUTILISATEUR = ?");
  $queryResult->execute(array($mail));


  echo "utilisateur supprimé wola";

?>