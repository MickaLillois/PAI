<?php

include("../Connexion/connexion.php");

$mail = $_GET["mail"];
$nomQuiz = $_GET["nomQuiz"];
  $queryResult = $connection->prepare("INSERT INTO QUIZ_PERSONNALISE VALUES (0, ?, ?)");
  $queryResult->execute(array($mail, $nomQuiz));


  echo "quiz ajouté";

?>