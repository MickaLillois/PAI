<?php

include("../Connexion/connexion.php");

$intitule = $_GET["intitule"];
$nomQuiz = $_GET["nomQuiz"];
$mail = $_GET["mail"];
$qPerso = $_GET["qPerso"];
$idQuestion;

if($qPerso == "true")
{
    $q = $connection->prepare("SELECT IDQUESTION FROM QUESTION WHERE INTITULE = ? AND IDCATEGORIE = 5");
    $q->execute(array($intitule));
    $idQuestion = $q->fetch();
    var_dump($qPerso);
}
else
{
    $q2 = $connection->prepare("SELECT IDQUESTION FROM QUESTION WHERE INTITULE = ? AND IDCATEGORIE <> 5");
    $q2->execute(array($intitule));
    $idQuestion = $q2->fetch();
}

$q3 = $connection->prepare("SELECT IDQUIZPERSO FROM QUIZ_PERSONNALISE WHERE MAILUTILISATEUR = ? AND NOMQUIZ = ?");
$q3->execute(array($mail, $nomQuiz));
$idQuiz = $q3->fetch();

  $queryResult = $connection->prepare("DELETE FROM CONTENIR WHERE IDQUIZPERSO = :idQu AND IDQUESTION = :idQ");
  $queryResult->bindParam(':idQu', $idQuiz["IDQUIZPERSO"], PDO::PARAM_INT);
  $queryResult->bindParam(':idQ', $idQuestion["IDQUESTION"], PDO::PARAM_INT);
  $queryResult->execute();


  echo "question supprimée du quiz wola";

?>