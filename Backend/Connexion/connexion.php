<?php
    //connect
    $connection = new PDO('mysql:host=mysql-quizinmobile.alwaysdata.net;dbname=quizinmobile_bdd', "229981", "Vivemarius59", array('charset'=>'utf8'));
    $connection->query("SET CHARACTER SET utf8");

    if (!$connection) {
        echo "connection failed!";
        exit();
    }
?>