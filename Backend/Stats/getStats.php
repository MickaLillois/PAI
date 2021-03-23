<?php

include("../Connexion/connexion.php");

  $queryResult = $connection->query("SELECT * FROM STATSUTILISATEUR ORDER BY MAILUTILISATEUR");

  $result = array();

  while ($fetchdata = $queryResult->fetch()) {
      $result[] = $fetchdata;
  }

  echo json_encode($result);

?>