<?php

    $connection = new mysqli("mysql-quizinmobile.alwaysdata.net", "quizinmobile_bdd", "Vivemarius59", "quizinmobile_bdd");

    if (!$connection) {
        echo "connection failed!";
        exit();
    }
?>