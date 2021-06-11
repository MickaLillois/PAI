<?php

include("../Connexion/connexion.php");

  $user = $_GET["user"];
  $nbQuestion = $_GET["nbQue"];
  $tempsReponseMoyen = $_GET["TmpRepMoy"];
  $pointsUtilisateur = $_GET["ptsUs"];
  $classement = $_GET["clmt"];

  $var0 = 0;
  $var1 = 1;
  
  $queryResult = $connection->prepare("UPDATE `STATSUTILISATEUR` SET 
  `TEMPSREPONSEMOYEN`=((SELECT (TEMPSREPONSEMOYEN*NBTOTALREPONSES) FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+ (:tempsResponseMoyen * :nbQuestion) )/((SELECT NBTOTALREPONSES FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+ :nbQuestion ),
  `POINTSUTILISATEUR`=(SELECT POINTSUTILISATEUR FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+ :pointsUtilisateur ,
  `NBTOP1BR`=(SELECT NBTOP1BR FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+ :top1,
  `NBTOTALREPONSES`=(SELECT NBTOTALREPONSES FROM STATSUTILISATEUR WHERE MAILUTILISATEUR = :user)+ :nbQuestion
  WHERE MAILUTILISATEUR = :user");

  $queryResult->bindParam(':user', $user);
  $queryResult->bindParam(':nbQuestion', $nbQuestion, PDO::PARAM_INT);
  $queryResult->bindParam(':tempsResponseMoyen', $tempsReponseMoyen);
  $queryResult->bindParam(':pointsUtilisateur', $pointsUtilisateur, PDO::PARAM_INT);

  if ($classement == 1)
  {
      $queryResult->bindParam(':top1', $var1, PDO::PARAM_INT);
  }
  else
  {
      $queryResult->bindParam(':top1', $var0, PDO::PARAM_INT);
  }
 
  $queryResult->execute();

  $result = array();

  while ($fetchdata = $queryResult->fetch()) {
      $result[] = $fetchdata;
  }

  echo json_encode($result);

?>