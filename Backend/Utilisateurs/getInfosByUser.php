<?php

include("../Connexion/connexion.php");

$mail = $_GET["mail"];
  $queryResult = $connection->prepare("SELECT PRENOMUTILISATEUR, NOMUTILISATEUR, PSEUDOUTILISATEUR, DATENAISSANCEUTILISATEUR FROM UTILISATEUR WHERE MAILUTILISATEUR = ?");
  $queryResult->execute(array($mail));

  $result = array();

  while ($fetchdata = $queryResult->fetch()) {
      $result[] = $fetchdata;
  }

  echo json_encode($result);

?>