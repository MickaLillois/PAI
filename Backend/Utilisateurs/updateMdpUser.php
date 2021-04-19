<?php

include("../Connexion/connexion.php");

$mail = $_POST["mail"];
$newMdp = $_POST["newMdp"];
$ancienMdp = $_POST["ancienMdp"];
$q2 = $connection->query("SELECT * FROM UTILISATEUR WHERE MAILUTILISATEUR = ? AND MDPUTILISATEUR = password(?) ");
$q2->execute(array($mail, $ancienMdp));
if($q->rowcount == 1)
{
  if($ancienMdp == $newMdp)
  {
    echo "-2";
  }
  else
  {
    $queryResult = $connection->prepare("UPDATE UTILISATEUR SET MDPUTILISATEUR = password(?) WHERE MAILUTILISATEUR = ?");
    $queryResult->execute(array($newMdp, $mail));
    $q = $connection->prepare("UPDATE GESTIONUTILISATEUR SET DATEDERNIERCHANGEMENTMDP = now() WHERE MAILUTILISATEUR = ?");
    $q->execute(array($mail));
    echo $q->rowcount();
  }
}
else
{
  echo "-1";
}
  

?>