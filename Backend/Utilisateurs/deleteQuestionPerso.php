<?php

include("../Connexion/connexion.php");

$intitule = $_GET["intitule"];
$mail = $_GET["mail"];
$idQuestion;

$q = $connection->prepare("SELECT IDQUESTION FROM QUESTION WHERE INTITULE = ? AND IDCATEGORIE = 5");
$q->execute(array($intitule));
$idQuestion = $q->fetch();
  $queryResult = $connection->prepare("DELETE FROM QUESTION WHERE IDQUESTION = :idQ");
  $queryResult->bindParam(':idQ', $idQuestion["IDQUESTION"], PDO::PARAM_INT);
  $queryResult->execute();


  echo "question supprimée du quiz";

?>