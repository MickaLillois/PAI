<?php

include("../Connexion/connexion.php");

$mail = $_POST["mail"];
$nomQuiz = $_POST["nomQuiz"];
  $queryResult = $connection->prepare("SELECT INTITULE, LIBELLEDIFFICULTE, LIBELLECATEGORIE, REPONSES, NBREPONSESMAX, TEMPSREPONSE FROM CONTENIR C JOIN QUIZ_PERSONNALISE P ON C.IDQUIZPERSO = P.IDQUIZPERSO JOIN QUESTION Q ON C.IDQUESTION = Q.IDQUESTION LEFT JOIN QUESTION_PERSO U ON Q.IDQUESTION = U.IDQUESTION JOIN DIFFICULTE_QUESTION D ON D.IDDIFFICULTE = Q.IDDIFFICULTE JOIN CATEGORIE A ON A.IDCATEGORIE = Q.IDCATEGORIE WHERE P.MAILUTILISATEUR = ? AND NOMQUIZ = ?");
  $queryResult->execute(array($mail, $nomQuiz));

  $result = array();
  $arrayf = array();
  $arrayf["RIEN"] = "rien";
  $result["Question0"] = $arrayf;
  $i = 1;
  while ($fetchdata = $queryResult->fetch()) {
      $titre = "Question".$i;
      $arrayt = array();
      $arrayt["INTITULE"] = $fetchdata["INTITULE"];
      $arrayt["LIBELLEDIFFICULTE"] = $fetchdata["LIBELLEDIFFICULTE"];
      $arrayt["LIBELLECATEGORIE"] = $fetchdata["LIBELLECATEGORIE"];
      $arrayt["REPONSES"] = $fetchdata["REPONSES"];
      $arrayt["NBREPONSESMAX"] = $fetchdata["NBREPONSESMAX"];
      $arrayt["TEMPSREPONSE"] = $fetchdata["TEMPSREPONSE"];
      $result[$titre] = $arrayt;
      $i++;
  }

  echo json_encode($result);

?>