<?php

include("../Connexion/connexion.php");

$mail = $_POST["mail"];
$newMdp = $_POST["newMdp"];
$ancienMdp = $_POST["ancienMdp"];
if($ancienMdp == $newMdp)
{

}
else
{
  $queryResult = $connection->prepare("UPDATE UTILISATEUR SET MDPUTILISATEUR = password(?) WHERE MAILUTILISATEUR = ?");
  $queryResult->execute(array($newMdp, $mail));
  $q = $connection->prepare("UPDATE GESTIONUTILISATEUR SET DATEDERNIERCHANGEMENTMDP = now() WHERE MAILUTILISATEUR = ?");
  $q->execute(array($mail));
  echo "mot de passe mis à jour";
}
  

?>