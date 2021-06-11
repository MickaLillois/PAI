<?php

include("../Connexion/connexion.php");

$mail = $_POST["mail"];
$nomQuiz = $_POST["nomQuiz"];
  $queryResult = $connection->prepare("INSERT INTO QUIZ_PERSONNALISE VALUES (0, ?, ?)");
  $queryResult->execute(array($mail, $nomQuiz));


  echo "quiz ajouté";

?>