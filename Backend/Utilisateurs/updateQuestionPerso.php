<?php

include("../Connexion/connexion.php");

$mail = $_GET["mail"];
$intitule = $_GET["intitule"];
$reponses = $_GET["reponses"];
$nbReponsesMax = $_GET["nbReponsesMax"];
$tempsReponse = $_GET["tempsReponse"];
$ancienIntitu = $_GET["ancienIntitule"];
  $query = $connection->prepare("SELECT IDQUESTION FROM QUESTION WHERE INTITULE = ? AND IDCATEGORIE = 5");
  $query->execute(array($ancienIntitu));
  $idQuestion = $query->fetch();
  var_dump($idQuestion["IDQUESTION"]);
  $q = $connection->prepare("UPDATE QUESTION SET INTITULE = :intitu, REPONSES = :rep, NBREPONSESMAX = :nbRep WHERE IDQUESTION = :idQ");
  $q->bindParam(':intitu', $intitule, PDO::PARAM_STR);
  $q->bindParam(':rep', $reponses, PDO::PARAM_STR);
  $q->bindParam(':nbRep', $nbReponsesMax, PDO::PARAM_INT);
  $q->bindParam(':idQ', $idQuestion["IDQUESTION"], PDO::PARAM_INT);
  $q->execute();
  $q2 = $connection->prepare("UPDATE QUESTION_PERSO SET TEMPSREPONSE = :tpsRep WHERE IDQUESTION = :idQu");
  $q2->bindParam(':tpsRep', $tempsReponse, PDO::PARAM_INT);
  $q2->bindParam(':idQu', $idQuestion["IDQUESTION"], PDO::PARAM_INT);
  $q2->execute();
  echo "Question perso mise à jour";

?>