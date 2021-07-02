<?php
error_reporting(0);
include_once ("dbconnect.php");
$userid = $_POST['userid'];
$actionid  = $_POST['actionid'];
$name  = $_POST['name'];
$category  = $_POST['category'];
$vitalsign  = $_POST['vitalsign'];
$ease  = $_POST['ease'];
$description  = $_POST['description'];
$tips  = $_POST['tips'];


$sqlinsert = "INSERT INTO COMPLETED_ACTION(USERID,ACTIONID,NAME,CATEGORY,VITALSIGN,EASE,DESCRIPTION,TIPS) VALUES ('$userid','$actionid','$name','$category','$vitalsign','$ease','$description','$tips')";

$sqldelete = "DELETE FROM ADD_GOAL WHERE ACTIONID = '$actionid' AND USERID = '$userid'";
$sqldelete1 = "DELETE FROM SAVED_GOAL WHERE ACTIONID = '$actionid' AND USERID = '$userid'";

$sqlsearch = "SELECT * FROM COMPLETED_ACTION WHERE ACTIONID='$actionid' AND USERID = '$userid'";

// $sqlsearchsaved = "SELECT * FROM ADD_GOAL WHERE ACTIONID='$actionid' AND USERID = '$userid'";
// $sqlsearchsaved2 = "SELECT * FROM SAVED_ACTION WHERE ACTIONID='$actionid' AND USERID = '$userid'";

$resultsearch = $conn->query($sqlsearch);

$conn->query($sqldelete);
$conn->query($sqldelete1);

if ($resultsearch->num_rows > 0)
{
    echo 'found';
}else{
if ($conn->query($sqlinsert) === true)
{
    
     if ($conn->query($sqldelete) ===true){
        
        echo 'success';
    }else{
        echo 'failed';
    }
        // echo 'success';
}
else
{
    echo "failed";
}    
}
?>