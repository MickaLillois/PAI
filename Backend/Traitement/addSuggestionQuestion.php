<?php

include("../Connexion/connexion.php");

$mail = $_GET["mail"];
$categ = $_GET["categ"];
$intitule = $_GET["intitule"];
$difficulte = $_GET["difficulte"];
$reponses = $_GET["reponses"];
$nbReponsesMax = $_GET["nbRepMax"];
  $q = $connection->prepare("SELECT IDCATEGORIE FROM CATEGORIE WHERE LIBELLECATEGORIE = ?");
  $q->execute (array($categ));
  $idCateg = $q->fetch();
  $q2 = $connection->prepare("SELECT IDDIFFICULTE FROM DIFFICULTE_QUESTION WHERE LIBELLEDIFFICULTE = ?");
  $q2->execute(array($difficulte));
  $idDifficulte = $q2->fetch();
  $queryResult = $connection->prepare("INSERT INTO SUGGESTION_QUESTION VALUES (0, ?, ?, ?, 2, ?, ?, ?)");
  $queryResult->execute(array($idCateg["IDCATEGORIE"], $idDifficulte["IDDIFFICULTE"], $mail, $intitule, $reponses, $nbReponsesMax));

  echo "Suggestion ajoutée";

?>