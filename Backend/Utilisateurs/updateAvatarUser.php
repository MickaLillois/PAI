<?php

include("../Connexion/connexion.php");

$mail = $_GET["mail"];
$avatar = $_GET["avatar"];
  $queryResult = $connection->prepare("UPDATE UTILISATEUR SET NUMEROAVATAR = ? WHERE MAILUTILISATEUR = ?");
  $queryResult->execute(array($avatar, $mail));
  echo "avatar mis à jour";

?>