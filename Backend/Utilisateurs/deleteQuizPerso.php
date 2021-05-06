<?php

include("../Connexion/connexion.php");

$mail = $_POST["mail"];
$nomQuiz = $_POST["nomQuiz"];
  $queryResult = $connection->prepare("DELETE FROM QUIZ_PERSONNALISE WHERE NOMQUIZ = ? AND MAILUTILISATEUR = ?");
  $queryResult->execute(array($nomQuiz, $mail));


  echo "quiz supprimé";

?>