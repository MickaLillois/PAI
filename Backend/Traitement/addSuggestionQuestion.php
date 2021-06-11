<?php

include("../Connexion/connexion.php");

$mail = $_POST["mail"];
$categ = $_POST["categ"];
$intitule = $_POST["intitule"];
$difficulte = $_POST["difficulte"];
$reponses = $_POST["reponses"];
$nbReponsesMax = $_POST["nbRepMax"];
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