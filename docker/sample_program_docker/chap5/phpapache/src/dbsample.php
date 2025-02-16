<?php
    try {
        $dsn = 'mysql:dbname=testdb;host=db';
        $db = new PDO($dsn, 'testuser', 'testpass');
        echo "接続に成功しました";
    }catch(PDOException $e) {
        echo "接続に失敗しました";
        echo $e->getMessage();
        exit;
 }
?>