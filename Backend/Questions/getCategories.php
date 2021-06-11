<?php

include("../Connexion/connexion.php");

  $queryResult = $connection->query("SELECT * FROM CATEGORIE WHERE IDCATEGORIE <> 5");

  $result = array();
  $i = 1;
  while ($fetchdata = $queryResult->fetch()) {
    $titre = "Categorie".$i;
    $arrayt = array();
    $arrayt["LIBELLECATEGORIE"] = $fetchdata["LIBELLECATEGORIE"];
    $result[$titre] = $arrayt;
    $i++;
}

  echo json_encode($result);

?>