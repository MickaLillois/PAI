<?php

include("../Connexion/connexion.php");

  $queryResult = $connection->query("SELECT PSEUDOUTILISATEUR, SCOREMOYENSTANDARD, S.MAILUTILISATEUR, @curRank := @curRank + 1 AS rank FROM STATSUTILISATEUR S JOIN UTILISATEUR U ON S.MAILUTILISATEUR = U.MAILUTILISATEUR, (SELECT @curRank := 0) r ORDER BY SCOREMOYENSTANDARD DESC");

  $result = array();
  $i = 1;
  while ($fetchdata = $queryResult->fetch()) {
    $arrayt = array();
    $titre = "stats".$i;
    $arrayt["PSEUDOUTILISATEUR"] = $fetchdata["PSEUDOUTILISATEUR"];
    $arrayt["SCOREMOYENSTANDARD"] = $fetchdata["SCOREMOYENSTANDARD"];
    $arrayt["MAILUTILISATEUR"] = $fetchdata["MAILUTILISATEUR"];
    $arrayt["RANG"] = $fetchdata["rank"];

    $result[$titre] = $arrayt;
    $i++;
  }

  echo json_encode($result);

?>