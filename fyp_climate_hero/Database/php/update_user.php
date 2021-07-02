<?php
error_reporting(0);
include_once("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];

$newpassword = $_POST["password"];
$newpass = sha1($newpassword);


// $encoded_string = $_POST["encoded_string"];
// $decoded_string = base64_decode($encoded_string);

// $path = '../productimage/'.$prid.'.jpg';

// if (file_put_contents($path, $decoded_string)){
//     echo 'success';
// }else{
//     echo 'failed';
// }

if (isset($name)){
    $sqlupdate = "UPDATE USER SET NAME = '$name', PHONE='$phone', PASSWORD='$newpass' WHERE EMAIL = '$email'";

    if ($conn->query($sqlupdate)){
        echo 'success';    
    }else{
        echo 'failed';
    }
    
}


$conn->close();
?>