<?php

include("../Connexion/connexion.php");

  $queryResult = $connection->query("SELECT * FROM DIFFICULTE_QUESTION WHERE IDDIFFICULTE <> 5");

  $result = array();
  $i = 1;
  while ($fetchdata = $queryResult->fetch()) {
    $titre = "Difficulte".$i;
    $arrayt = array();
    $arrayt["LIBELLEDIFFICULTE"] = $fetchdata["LIBELLEDIFFICULTE"];
    $result[$titre] = $arrayt;
    $i++;
}

  echo json_encode($result);

?>