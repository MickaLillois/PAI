<?php

include("../Connexion/connexion.php");

$intitule = $_GET["intitule"];
$reponses = $_GET["reponses"];
$nbReponsesMax = $_GET["nbReponsesMax"];
$tempsReponse = $_GET["tempsReponse"];
$mail = $_GET["mail"];
$nomQuiz = $_GET["nomQuiz"];
  $q = $connection->prepare("INSERT INTO QUESTION VALUES 0, 5, 5, ?, ?, ?");
  $q->execute(array($intitule, $reponses, $nbReponsesMax));
  $id = mysql_insert_id();
  $q2 = $connection->prepare("INSERT INTO QUESTION_PERSO VALUES ?, ?, ?");
  $q2->execute(array($id, $mail, $tempsReponse));
  $q3 = $connection->prepare("SELECT IDQUIZPERSO FROM QUIZ_PERSONNALISE WHERE WHERE MAILUTILISATEUR = ? AND NOMQUIZ = ?");
  $q3->execute(array($mail, $nomQuiz));
  $idQuiz = $q3->fetch();
  $queryResult = $connection->prepare("INSERT INTO CONTENIR VALUES (?, ?)");
  $queryResult->execute(array($idQuiz, $id));


  echo "question + quiz ajouté wola";

?>