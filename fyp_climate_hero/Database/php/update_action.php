<?php
error_reporting(0);
include_once("dbconnect.php");
$id = $_POST['id'];
$name = $_POST['name'];
$category = $_POST['category'];
$ease = $_POST['ease'];
$vital = $_POST['vital'];
$description = $_POST['description'];
$tips = $_POST['tips'];

$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);

$path = '../actionsimages/'.$id.'.jpg';

$sqlupdate = "UPDATE ACTION SET NAME='$name', CATEGORY='$category',VITALSIGN='$vital', EASE='$ease',  DESCRIPTION ='$description', TIPS='$tips' WHERE ACTIONID = '$id'";
// $sqlsearch = "SELECT * FROM ACTION WHERE ACTIONID='$id'";
// $resultsearch = $conn->query($sqlsearch);

if ($conn->query($sqlupdate) === true)
{
    if (file_put_contents($path, $decoded_string)){
        echo 'successUpdatedImg';
    }else{
        echo 'SuccessUpdatedData';
    }
}
else
{
    echo "failed2";
}    


$conn->close();
?>