<?php

$users = [];

$dsn = 'mysql:host=db;port=3306;dbname=sample';
$username = 'root';
$password = 'secret';

try {
    echo 'db1';
    $pdo = new PDO($dsn, $username, $password);
    echo 'db2';
    $statement = $pdo->query('select * from user');
    echo 'db3';
    $statement->execute();
    echo 'db4';

    while ($row = $statement->fetch()) {
        $users[] = $row;
    }

    $pdo = null;
} catch (PDOException $e) {
    echo 'dbに接続できませんでした。';
}

foreach ($users as $user) {
    echo '<p>id: ' . $user['id'] . ', name:' . $user['name'] . '</p>';
}

$subject = 'test mail';
$message = 'docker hub はこちらです -> https://hub.docker.com/';
foreach ($users as $user) {
    $success = mb_send_mail($user['email'], $subject, $message);
    if ($succes) {
        echo '<p>' . $user['name'] . 'にmailを送信しました</p>';
    } else {
        echo 'mailの送信に失敗しました';

    }
}

