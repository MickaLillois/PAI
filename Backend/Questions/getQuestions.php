<?php

include("../Connexion/connexion.php");

  $queryResult = $connection->query("SELECT * FROM QUESTION");

  $result = array();

  while ($fetchdata = $queryResult->fetch()) {
      $result[] = $fetchdata;
  }

  echo json_encode($result);

?>