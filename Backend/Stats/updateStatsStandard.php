<?php

include("../Connexion/connexion.php");

  $user = $_GET["user"];
  $scorePartie = $_GET["scPart"];
  $tempsReponseMoyen = $_GET["TmpRepMoy"];
  $tauxBonneReponse = $_GET["txBonRep"];
  $nbQuestion = $_GET["nbQue"];
  $pointsUtilisateur = $_GET["ptsUs"];
  $classement = $_GET["clmt"];

  $var0 = 0;
  $var1 = 1;
  
  $queryResult = $connection->prepare("UPDATE `STATSUTILISATEUR` 
  SET `SCOREMOYENSTANDARD`=((SELECT (SCOREMOYENSTANDARD*NBPARTIESSTANDARDJOUEES) FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+ :scorePartie )/((SELECT NBPARTIESSTANDARDJOUEES FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+1),
  `TEMPSREPONSEMOYEN`=((SELECT (TEMPSREPONSEMOYEN*NBTOTALREPONSES) FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+ (:tempsResponseMoyen * :nbQuestion) )/((SELECT NBTOTALREPONSES FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+ :nbQuestion ),
  `TAUXBONNEREPONSE`=((SELECT (TAUXBONNEREPONSE*NBTOTALREPONSES) FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+ (:tauxBonneReponse * :nbQuestion) )/((SELECT NBTOTALREPONSES FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+ :nbQuestion ),
  `POINTSUTILISATEUR`=(SELECT POINTSUTILISATEUR FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+ :pointsUtilisateur ,
  `NBPODIUMSTANDARD`=(SELECT NBPODIUMSTANDARD FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+ :podium ,
  `NBTOP1STANDARD`=(SELECT NBTOP1STANDARD FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+ :top1 ,
  `NBTOTALREPONSES`=(SELECT NBTOTALREPONSES FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+ :nbQuestion ,
  `NBPARTIESSTANDARDJOUEES`=(SELECT NBPARTIESSTANDARDJOUEES FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+1
  WHERE MAILUTILISATEUR = :user");

  $queryResult->bindParam(':user', $user);
  $queryResult->bindParam(':scorePartie', $scorePartie, PDO::PARAM_INT);
  $queryResult->bindParam(':tempsResponseMoyen', $tempsReponseMoyen);
  $queryResult->bindParam(':tauxBonneReponse', $tauxBonneReponse);
  $queryResult->bindParam(':nbQuestion', $nbQuestion, PDO::PARAM_INT);
  $queryResult->bindParam(':pointsUtilisateur', $pointsUtilisateur, PDO::PARAM_INT);
  if ($classement <= 3) 
  {
    $queryResult->bindParam(':podium', $var1, PDO::PARAM_INT);
    if ($classement == 1)
    {
      $queryResult->bindParam(':top1', $var1, PDO::PARAM_INT);
    }
    else
    {
      $queryResult->bindParam(':top1', $var0, PDO::PARAM_INT);
    }
  }
  else 
  {
    $queryResult->bindParam(':podium', $var0, PDO::PARAM_INT);
    $queryResult->bindParam(':top1', $var0, PDO::PARAM_INT);
  }

  $queryResult->execute();

  $result = array();

  while ($fetchdata = $queryResult->fetch()) {
      $result[] = $fetchdata;
  }

  echo json_encode($result);

?>