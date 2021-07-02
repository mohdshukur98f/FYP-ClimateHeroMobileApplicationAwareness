<?php
error_reporting(0);
include_once ("dbconnect.php");
$actionid = $_POST['actionid'];
$name  = $_POST['name'];
$category  = $_POST['category'];
$vitalsign  = $_POST['vitalsign'];
$ease  = $_POST['ease'];
$description  = $_POST['description'];
$tips  = $_POST['tips'];
$encoded_string = $_POST["encoded_string"];

$decoded_string = base64_decode($encoded_string);
$path = '../actionsimages/'.$actionid.'.jpg';

$sqlinsert = "INSERT INTO ACTION(ACTIONID,NAME,CATEGORY,VITALSIGN,EASE,DESCRIPTION,TIPS) VALUES ('$actionid','$name','$category','$vitalsign','$ease','$description','$tips')";
$sqlsearch = "SELECT * FROM ACTION WHERE ACTIONID='$actionid'";
$resultsearch = $conn->query($sqlsearch);
if ($resultsearch->num_rows > 0)
{
    echo 'found';
}else{
if ($conn->query($sqlinsert) === true)
{
    if (file_put_contents($path, $decoded_string)){
        echo 'success';
    }else{
        echo 'failed';
    }
}
else
{
    echo "failed";
}    
}


?>