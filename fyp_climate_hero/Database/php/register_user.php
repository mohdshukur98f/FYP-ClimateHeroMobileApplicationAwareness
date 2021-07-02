<?php
error_reporting(0);
include_once ("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);



$sqlinsert = "INSERT INTO USER(NAME,EMAIL,PHONE,PASSWORD,POINT,DATEREGISTER) 
VALUES ('$name','$email','$phone','$password','0',now())";

if ($conn->query($sqlinsert) === true)
{
    sendEmail($email);
    echo "success";
}
else
{
    echo "failed";
}

function sendEmail($email) {
    $to      = $email; 
    $subject = 'Registeration for Climate Hero Application Account'; 
    $message = 'Congratulation, now you are hero. Lets save our world!'; 
    $headers = 'From: noreply@climatehero.com' . "\r\n" . 
    'Reply-To: '.$email . "\r\n" . 
    'X-Mailer: PHP/' . phpversion(); 
    mail($to, $subject, $message, $headers); 
}

?>