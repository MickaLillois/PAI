<?php

include("../Connexion/connexion.php");

$intitule = $_GET["intitule"];
$reponses = $_GET["reponses"];
$nbReponsesMax = $_GET["nbReponsesMax"];
$tempsReponse = $_GET["tempsReponse"];
$mail = $_GET["mail"];
$nomQuiz = $_GET["nomQuiz"];
  $q = $connection->prepare("INSERT INTO QUESTION VALUES 0, 5, 5, :intitu, :rep, :nbRep");
  $q->bindParam(':intitu', $intitule, PDO::PARAM_STR);
  $q->bindParam(':rep', $reponses, PDO::PARAM_STR);
  $q->bindParam(':nbRep', $nbReponsesMax, PDO::PARAM_INT);
  $q->execute();
  $get = $connection->query("SELECT MAX(IDQUESTION) FROM QUESTION");
  $idQuestion = $get->fetch();
  $q2 = $connection->prepare("INSERT INTO QUESTION_PERSO VALUES :id, :mail, :tps");
  $q2->bindParam(':id', $idQuestion, PDO::PARAM_INT);
  $q2->bindParam(':mail', $mail, PDO::PARAM_STR);
  $q2->bindParam(':tps', $tempsReponse, PDO::PARAM_INT);
  $q2->execute();
  $q3 = $connection->prepare("SELECT IDQUIZPERSO FROM QUIZ_PERSONNALISE WHERE WHERE MAILUTILISATEUR = ? AND NOMQUIZ = ?");
  $q3->execute(array($mail, $nomQuiz));
  $idQuiz = $q3->fetch();
  $queryResult = $connection->prepare("INSERT INTO CONTENIR VALUES (:id, :idQ)");
  $queryResult->bindParam(':id', $idQuiz, PDO::PARAM_INT);
  $queryResult->bindParam(':idQ', $idQuestion, PDO::PARAM_INT);
  $queryResult->execute();


  echo "question + quiz ajouté wola";

?>