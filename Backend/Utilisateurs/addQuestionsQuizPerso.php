<?php

include("../Connexion/connexion.php");

$intitule = $_POST["intitule"];
$qPerso = $_POST["qPerso"];
$mail = $_POST["mail"];
$nomQuiz = $_POST["nomQuiz"];
$idQuestion;

if($qPerso == "true")
{
    $q = $connection->prepare("SELECT IDQUESTION FROM QUESTION WHERE INTITULE = ? AND IDCATEGORIE = 5");
    $q->execute(array($intitule));
    $idQuestion = $q->fetch();
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

  $queryResult = $connection->prepare("INSERT INTO CONTENIR VALUES (:idQu, :idQ)");
  $queryResult->bindParam(':idQu', $idQuiz["IDQUIZPERSO"], PDO::PARAM_INT);
  $queryResult->bindParam(':idQ', $idQuestion["IDQUESTION"], PDO::PARAM_INT);
  $queryResult->execute();


  echo "question ajoutée !";

?>