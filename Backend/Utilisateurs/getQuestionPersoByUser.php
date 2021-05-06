<?php

include("../Connexion/connexion.php");

$mail = $_POST["mail"];
  $queryResult = $connection->prepare("SELECT INTITULE, REPONSES, NBREPONSESMAX, TEMPSREPONSE FROM QUESTION Q JOIN QUESTION_PERSO U ON Q.IDQUESTION = U.IDQUESTION WHERE U.MAILUTILISATEUR = ?");
  $queryResult->execute(array($mail));

  $result = array();
  $arrayf = array();
  $arrayf["RIEN"] = "rien";
  $result["Question0"] = $arrayf;
  $i = 1;
  while ($fetchdata = $queryResult->fetch()) {
    $titre = "Question".$i;
    $arrayt = array();
    $arrayt["INTITULE"] = $fetchdata["INTITULE"];
    $arrayt["REPONSES"] = $fetchdata["REPONSES"];
    $arrayt["NBREPONSESMAX"] = $fetchdata["NBREPONSESMAX"];
    $arrayt["TEMPSREPONSE"] = $fetchdata["TEMPSREPONSE"];
    $result[$titre] = $arrayt;
    $i++;
  }

  echo json_encode($result);

?>