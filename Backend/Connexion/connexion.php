<?php

    $connection = new PDO('mysql:host=mysql-quizinmobile.alwaysdata.net;dbname=quizinmobile_bdd', "229981", "Vivemarius59");

    if (!$connection) {
        echo "connection failed!";
        exit();
    }
?>