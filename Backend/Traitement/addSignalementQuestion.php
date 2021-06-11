<?php

include("../Connexion/connexion.php");

$mail = $_POST["mail"];
$categSign = $_POST["categSign"];
$intitule = $_POST["intitule"];
$commentaires = $_POST["commentaires"];
  $q = $connection->prepare("SELECT IDCATEGORIE_SIGNALEMENT FROM CATEGORIE_SIGNALEMENT WHERE LIBELLECATEGORIE_SIGNALEMENT = ?");
  $q->execute (array($categSign));
  $idCateg = $q->fetch();
  $q2 = $connection->prepare("SELECT IDQUESTION FROM QUESTION WHERE INTITULE = ? AND IDCATEGORIE <> 5");
  $q2->execute(array($intitule));
  $idQuestion = $q2->fetch();
  $queryResult = $connection->prepare("INSERT INTO SIGNALEMENT_QUESTION VALUES (0, ?, ?, 2, ?, ?)");
  $queryResult->execute(array($idQuestion["IDQUESTION"], $idCateg["IDCATEGORIE_SIGNALEMENT"], $mail, $commentaires));

  echo "Signalement ajouté";

?>