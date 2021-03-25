<?php

include("../Connexion/connexion.php");

$mail = $_GET["mail"];
$nomQuiz = $_GET["nomQuiz"];
  $queryResult = $connection->prepare("SELECT INTITULE, LIBELLEDIFFICULTE, LIBELLECATEGORIE, REPONSES, NBREPONSESMAX, TEMPSREPONSE FROM CONTENIR C JOIN QUIZ_PERSONNALISE P ON C.IDQUIZPERSO = P.IDQUIZPERSO JOIN QUESTION Q ON C.IDQUESTION = Q.IDQUESTION LEFT JOIN QUESTION_PERSO U ON Q.IDQUESTION = U.IDQUESTION JOIN DIFFICULTE_QUESTION D ON D.IDDIFFICULTE = Q.IDDIFFICULTE JOIN CATEGORIE A ON A.IDCATEGORIE = Q.IDCATEGORIE WHERE P.MAILUTILISATEUR = ? AND NOMQUIZ = ?");
  $queryResult->execute(array($mail, $nomQuiz));

  $result = array();

  while ($fetchdata = $queryResult->fetch()) {
      $result[] = $fetchdata;
  }

  echo json_encode($result);

?>