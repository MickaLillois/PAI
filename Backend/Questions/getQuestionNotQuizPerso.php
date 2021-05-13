<?php

include("../Connexion/connexion.php");

$nomQuiz = $_POST["nomQuiz"];
  $queryResult = $connection->prepare("SELECT INTITULE, REPONSES, NBREPONSESMAX FROM QUESTION P WHERE P.IDQUESTION NOT IN (SELECT IDQUESTION FROM CONTENIR C JOIN QUIZ_PERSONNALISE Q ON Q.IDQUIZPERSO = C.IDQUIZPERSO WHERE Q.NOMQUIZ = ?) AND IDCATEGORIE <> 5
  ");
  $queryResult->execute(array($nomQuiz));

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