<?php

include("../Connexion/connexion.php");

$intitule = $_GET["intitule"];
$reponses = $_GET["reponses"];
$nbReponsesMax = $_GET["nbReponsesMax"];
$tempsReponse = $_GET["tempsReponse"];
$mail = $_GET["mail"];
$q = $connection->prepare("INSERT INTO QUESTION VALUES (0, 5, 5, :intitu, :rep, :nbRep)");
$q->bindParam(':intitu', $intitule, PDO::PARAM_STR);
$q->bindParam(':rep', $reponses, PDO::PARAM_STR);
$q->bindParam(':nbRep', $nbReponsesMax, PDO::PARAM_INT);
$q->execute();
$get = $connection->query("SELECT MAX(IDQUESTION) AS MAXIMUM FROM QUESTION");
$idQuestion = $get->fetch();
$q2 = $connection->prepare("INSERT INTO QUESTION_PERSO VALUES (:idQ, :mail, :tps)");
$q2->bindParam(':idQ', $idQuestion["MAXIMUM"], PDO::PARAM_INT);
$q2->bindParam(':mail', $mail, PDO::PARAM_STR);
$q2->bindParam(':tps', $tempsReponse, PDO::PARAM_INT);
$q2->execute();


  echo "question ajoutée";

?>