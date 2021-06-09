<?php

include("../Connexion/connexion.php");

  $queryResult = $connection->query("SELECT * FROM CATEGORIE_SIGNALEMENT");

  $result = array();
  $i = 1;
  while ($fetchdata = $queryResult->fetch()) {
    $arrayt = array();
    $titre = "categ".$i;
    $arrayt["LIBELLECATEGORIE_SIGNALEMENT"] = $fetchdata["LIBELLECATEGORIE_SIGNALEMENT"];
    $result[$titre] = $arrayt;
    $i++;
  }

  echo json_encode($result);

?>