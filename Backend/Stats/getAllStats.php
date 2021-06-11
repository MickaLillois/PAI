<?php

include("../Connexion/connexion.php");

  $queryResult = $connection->query("SELECT PSEUDOUTILISATEUR, POINTSUTILISATEUR, S.MAILUTILISATEUR, @curRank := @curRank + 1 AS rank FROM STATSUTILISATEUR S JOIN UTILISATEUR U ON S.MAILUTILISATEUR = U.MAILUTILISATEUR, (SELECT @curRank := 0) r ORDER BY POINTSUTILISATEUR DESC");

  $result = array();
  $i = 1;
  while ($fetchdata = $queryResult->fetch()) {
    $arrayt = array();
    $titre = "stats".$i;
    $arrayt["PSEUDOUTILISATEUR"] = $fetchdata["PSEUDOUTILISATEUR"];
    $arrayt["POINTSUTILISATEUR"] = $fetchdata["POINTSUTILISATEUR"];
    $arrayt["MAILUTILISATEUR"] = $fetchdata["MAILUTILISATEUR"];
    $arrayt["RANG"] = $fetchdata["rank"];

    $result[$titre] = $arrayt;
    $i++;
  }

  echo json_encode($result);

?>