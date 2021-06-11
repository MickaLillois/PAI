<?php

include("../Connexion/connexion.php");

$mail = $_POST["mail"];
  $queryResult = $connection->prepare("SELECT * FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = ?");
  $queryResult->execute(array($mail));

  $result = array();

  while ($fetchdata = $queryResult->fetch()) {
    $arrayt = array();
    $arrayt["SCOREMOYENSTANDARD"] = $fetchdata["SCOREMOYENSTANDARD"];
    $arrayt["TAUXBONNEREPONSE"] = $fetchdata["TAUXBONNEREPONSE"];
    $arrayt["NBPARTIESSTANDARDJOUEES"] = $fetchdata["NBPARTIESSTANDARDJOUEES"];
    $arrayt["POINTSUTILISATEUR"] = $fetchdata["POINTSUTILISATEUR"];
    $result[] = $arrayt;
  }

  echo json_encode($result);

?>