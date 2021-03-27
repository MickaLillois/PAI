<?php

include("../Connexion/connexion.php");

$user = $_GET["utilisateur"];
  $queryResult = $connection->prepare("SELECT * FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = ?");
  $queryResult->execute(array($user));

  $result = array();

  while ($fetchdata = $queryResult->fetch()) {
      $result[] = $fetchdata;
  }

  echo json_encode($result);

?>