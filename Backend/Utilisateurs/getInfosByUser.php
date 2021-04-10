<?php

include("../Connexion/connexion.php");
if(!empty($_POST))
{
  if(empty($_POST['mail']))
  {
    echo 'vide';
  }
  else
  {
    $mail = $_POST["mail"];
    $queryResult = $connection->prepare("SELECT PRENOMUTILISATEUR, NOMUTILISATEUR, PSEUDOUTILISATEUR, DATENAISSANCEUTILISATEUR, NUMEROAVATAR FROM UTILISATEUR WHERE MAILUTILISATEUR = ?");
    $queryResult->execute(array($mail));

    $result = array();

    while ($fetchdata = $queryResult->fetch()) {
      $titre = $mail;
      $arrayt = array();
      $arrayt["PRENOM"] = $fetchdata["PRENOMUTILISATEUR"];
      $arrayt["NOM"] = $fetchdata["NOMUTILISATEUR"];
      $arrayt["PSEUDO"] = $fetchdata["PSEUDOUTILISATEUR"];
      $arrayt["DATENAISSANCE"] = $fetchdata["DATENAISSANCEUTILISATEUR"];
      $arrayt["AVATAR"] = $fetchdata["NUMEROAVATAR"];
      $result[$titre] = $arrayt;
      $i++;
    }

    echo json_encode($result);
  }
}
else
{
  var_dump($_POST);
}
?>