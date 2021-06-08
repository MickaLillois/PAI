<?php

include("../Connexion/connexion.php");

  $queryResult = $connection->query("SELECT PSEUDOUTILISATEUR, TAUXBONNEREPONSE, S.MAILUTILISATEUR, @curRank := @curRank + 1 AS rank FROM STATSUTILISATEUR S JOIN UTILISATEUR U ON S.MAILUTILISATEUR = U.MAILUTILISATEUR, (SELECT @curRank := 0) r ORDER BY TAUXBONNEREPONSE DESC");

  $result = array();
  $i = 1;
  while ($fetchdata = $queryResult->fetch()) {
    $arrayt = array();
    $titre = "stats".$i;
    $arrayt["PSEUDOUTILISATEUR"] = $fetchdata["PSEUDOUTILISATEUR"];
    $arrayt["TAUXBONNEREPONSE"] = $fetchdata["TAUXBONNEREPONSE"];
    $arrayt["MAILUTILISATEUR"] = $fetchdata["MAILUTILISATEUR"];
    $arrayt["RANG"] = $fetchdata["rank"];

    $result[$titre] = $arrayt;
    $i++;
  }

  echo json_encode($result);

?>