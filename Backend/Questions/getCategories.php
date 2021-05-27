<?php

include("../Connexion/connexion.php");

  $queryResult = $connection->query("SELECT * FROM CATEGORIE WHERE IDCATEGORIE <> 5");

  $result = array();
  while ($fetchdata = $queryResult->fetch()) {
      $result[] = $fetchdata;
  }

  echo json_encode($result);

?>