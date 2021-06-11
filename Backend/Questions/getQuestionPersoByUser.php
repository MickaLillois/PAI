<?php

include("../Connexion/connexion.php");

$mail = $_POST["mail"];
$nomQuiz = $_POST["nomQuiz"];
  $queryResult = $connection->prepare("SELECT INTITULE, REPONSES, NBREPONSESMAX, TEMPSREPONSE FROM QUESTION_PERSO Q JOIN QUESTION P ON Q.IDQUESTION = P.IDQUESTION WHERE Q.IDQUESTION NOT IN (SELECT IDQUESTION FROM CONTENIR C JOIN QUIZ_PERSONNALISE Q ON Q.IDQUIZPERSO = C.IDQUIZPERSO WHERE Q.MAILUTILISATEUR = ? AND Q.NOMQUIZ = ?) AND MAILUTILISATEUR = ?");
  $queryResult->execute(array($mail, $nomQuiz, $mail));

  $result = array();
  $arrayf = array();
  $arrayf["RIEN"] = "rien";
  $result["Question0"] = $arrayf;
  $i = 1;
  while ($fetchdata = $queryResult->fetch()) {
    $titre = "Question".$i;
    $arrayt = array();
    $arrayt["INTITULE"] = $fetchdata["INTITULE"];
    $arrayt["REPONSES"] = $fetchdata["REPONSES"];
    $arrayt["NBREPONSESMAX"] = $fetchdata["NBREPONSESMAX"];
    $arrayt["TEMPSREPONSE"] = $fetchdata["TEMPSREPONSE"];
    $result[$titre] = $arrayt;
    $i++;
  }

  echo json_encode($result);

?>