<?php

include("../Connexion/connexion.php");

$mail = $_GET["mail"];
  $queryResult = $connection->prepare("SELECT NOMQUIZ, count(*) as NBQUESTIONSQUIZ FROM QUIZ_PERSONNALISE Q JOIN CONTENIR C ON C.IDQUIZPERSO = Q.IDQUIZPERSO WHERE MAILUTILISATEUR = ?");
  $queryResult->execute(array($mail));

  $result = array();

  while ($fetchdata = $queryResult->fetch()) {
      $result[] = $fetchdata;
  }

  echo json_encode($result);

?>