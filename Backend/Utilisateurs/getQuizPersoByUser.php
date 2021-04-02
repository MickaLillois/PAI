<?php

include("../Connexion/connexion.php");

$mail = $_GET["mail"];
  $queryResult = $connection->prepare("SELECT NOMQUIZ, count(*) as NBQUESTIONSQUIZ FROM QUIZ_PERSONNALISE Q JOIN CONTENIR C ON C.IDQUIZPERSO = Q.IDQUIZPERSO WHERE MAILUTILISATEUR = ? GROUP BY NOMQUIZ");
  $queryResult->execute(array($mail));

  $result = array();
    $i = 1;
  while ($fetchdata = $queryResult->fetch()) {
      $titre = "Quiz".$i;
      $arrayt = array();
      $arrayt["NOMQUIZ"] = $fetchdata["NOMQUIZ"];
      $arrayt["NBQUESTIONSQUIZ"] = $fetchdata["NBQUESTIONSQUIZ"];
      $result[$titre] = $arrayt;
      $i++;
  }

  echo json_encode($result);

?>