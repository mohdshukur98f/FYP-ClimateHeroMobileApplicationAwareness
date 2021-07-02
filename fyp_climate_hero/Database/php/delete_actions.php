<?php
error_reporting(0);
include_once("dbconnect.php");
$actionid = $_POST['actionid'];


if (isset($_POST['actionid'])){
    $sqldelete = "DELETE FROM ACTION WHERE ACTIONID = '$actionid'";
}
    
    if ($conn->query($sqldelete) === TRUE){
       echo "success";
    }else {
        echo "failed";
    }
?>