<?php

include("../Connexion/connexion.php");

$nbQuestions = $_GET["nbQuestions"];
  $queryResult = $connection->prepare("SELECT * FROM QUESTION ORDER BY RAND() LIMIT :rows");
  $queryResult->bindParam(':rows', $nbQuestions, PDO::PARAM_INT);
  $queryResult->execute();

  $result = array();

  while ($fetchdata = $queryResult->fetch()) {
      $result[] = $fetchdata;
  }

  echo json_encode($result);

?>