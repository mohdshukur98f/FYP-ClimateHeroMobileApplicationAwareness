<?php
error_reporting(0);
include_once ("dbconnect.php");
$userid = $_POST['userid'];


$sql1= "SELECT COUNT(WHERE CATEGORY='Home & Work' AND USERID = '$userid') AS NumberOfHomeWork FROM COMPLETED_ACTION";



//////////////// Load Completed_Action///////////////////
$result = $conn->query($sql1);
if ($result->num_rows > 0)
{
    $response["completed_action_category"] = array();
    while ($row = $result->fetch_assoc())
    {
        $completed_actionlist = array();
        $completed_actionlist["NumberOfHomeWork"] = $row["NumberOfHomeWork"];
    
        array_push($response["completed_action_category"], $completed_actionlist);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>