<?php

include("../Connexion/connexion.php");

$mail = $_GET["mail"];
$nomQuiz = $_GET["nomQuiz"];
  $queryResult = $connection->prepare("DELETE FROM QUIZ_PERSONNALISE WHERE NOMQUIZ = ? AND MAILUTILISATEUR = ?");
  $queryResult->execute(array($nomQuiz, $mail));


  echo "quiz supprimé wola";

?>