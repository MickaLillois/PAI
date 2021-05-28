<?php

include("../Connexion/connexion.php");

$nbQuestions = $_POST["nbQuestions"];
$difficulte = $_POST["difficulte"];
$categorie = $_POST["categorie"];
$req;
if($difficulte == "Toutes")
{
  if($categorie == "Toutes")
  {
    $req = "SELECT * FROM QUESTION Q JOIN DIFFICULTE_QUESTION D ON Q.IDDIFFICULTE = D.IDDIFFICULTE JOIN CATEGORIE C ON Q.IDCATEGORIE = C.IDCATEGORIE WHERE Q.IDCATEGORIE <> 5 ORDER BY RAND() LIMIT :rows";
    $queryResult = $connection->prepare($req);
    $queryResult->bindParam(':rows', $nbQuestions, PDO::PARAM_INT);
    $queryResult->execute();
  }
  else
  {
    $req = "SELECT * FROM QUESTION Q JOIN DIFFICULTE_QUESTION D ON Q.IDDIFFICULTE = D.IDDIFFICULTE JOIN CATEGORIE C ON Q.IDCATEGORIE = C.IDCATEGORIE WHERE C.LIBELLECATEGORIE = :categ ORDER BY RAND() LIMIT :rows";
    $queryResult = $connection->prepare($req);
    $queryResult->bindParam(':categ', $categorie, PDO::PARAM_STR);
    $queryResult->bindParam(':rows', $nbQuestions, PDO::PARAM_INT);
    $queryResult->execute();
  }
}
else if($categorie == "Toutes"){
  $req = "SELECT * FROM QUESTION Q JOIN DIFFICULTE_QUESTION D ON Q.IDDIFFICULTE = D.IDDIFFICULTE JOIN CATEGORIE C ON Q.IDCATEGORIE = C.IDCATEGORIE WHERE Q.IDCATEGORIE <> 5 AND D.LIBELLEDIFFICULTE = :diff ORDER BY RAND() LIMIT :rows";
    $queryResult = $connection->prepare($req);
    $queryResult->bindParam(':diff', $difficulte, PDO::PARAM_STR);
    $queryResult->bindParam(':rows', $nbQuestions, PDO::PARAM_INT);
    $queryResult->execute();
}
else{
  $req = "SELECT * FROM QUESTION Q JOIN DIFFICULTE_QUESTION D ON Q.IDDIFFICULTE = D.IDDIFFICULTE JOIN CATEGORIE C ON Q.IDCATEGORIE = C.IDCATEGORIE WHERE C.LIBELLECATEGORIE = :categ AND D.LIBELLEDIFFICULTE = :diff ORDER BY RAND() LIMIT :rows";
    $queryResult = $connection->prepare($req);
    $queryResult->bindParam(':diff', $difficulte, PDO::PARAM_STR);
    $queryResult->bindParam(':categ', $categorie, PDO::PARAM_STR);
    $queryResult->bindParam(':rows', $nbQuestions, PDO::PARAM_INT);
    $queryResult->execute();
}

  $result = array();
  $i = 1;
  while ($fetchdata = $queryResult->fetch()) {
      $titre = "Question".$i;
      $arrayt = array();
      $arrayt["INTITULE"] = $fetchdata["INTITULE"];
      $arrayt["REPONSES"] = $fetchdata["REPONSES"];
      $arrayt["NBREPONSESMAX"] = $fetchdata["NBREPONSESMAX"];
      $arrayt["CATEGORIE"] = $fetchdata["LIBELLECATEGORIE"];
      $arrayt["DIFFICULTE"] = $fetchdata["LIBELLEDIFFICULTE"];
      $result[$titre] = $arrayt;
      $i++;
  }

  echo json_encode($result);

?>