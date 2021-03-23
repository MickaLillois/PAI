<?php

include("../Connexion/connexion.php");

$mail = $_GET["mail"];
$nomQuiz = $_GET["nomQuiz"];
  $queryResult = $connection->prepare("SELECT INTITULE, LIBELLEDIFFICULTE, LIBELLECATEGORIE FROM CONTENIR C JOIN QUIZ_PERSONNALISE P ON C.IDQUIZPERSO = P.IDQUIZPERSO JOIN QUESTION Q ON C.IDQUESTION = Q.IDQUESTION JOIN DIFFICULTE_QUESTION D ON D.IDDIFFICULTE = Q.IDDIFFICULTE JOIN CATEGORIE A ON A.IDCATEGORIE = Q.IDCATEGORIE WHERE MAILUTILISATEUR = ? AND NOMQUIZ = ?");
  $queryResult->execute(array($mail, $nomQuiz));

  $result = array();

  while ($fetchdata = $queryResult->fetch()) {
      $result[] = $fetchdata;
  }

  echo json_encode($result);

?>