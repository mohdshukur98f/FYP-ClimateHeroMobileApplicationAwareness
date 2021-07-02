<?php
error_reporting(0);
include_once ("dbconnect.php");
$email = $_POST['email'];

$sql = "SELECT * FROM COMPLETED_ACTION WHERE USERID='$email'";


//////////////// Load Completed_Action///////////////////
$result = $conn->query($sql);
if ($result->num_rows > 0)
{
    $response["completed_actions"] = array();
    while ($row = $result->fetch_assoc())
    {
        $completed_actionlist = array();
        $completed_actionlist["userid"] = $row["USERID"];
        $completed_actionlist["id"] = $row["ACTIONID"];
        $completed_actionlist["name"] = $row["NAME"];
        $completed_actionlist["category"] = $row["CATEGORY"];
        $completed_actionlist["vitalsign"] = $row["VITALSIGN"];
        $completed_actionlist["ease"] = $row["EASE"];
        $completed_actionlist["description"] = $row["DESCRIPTION"];
        $completed_actionlist["tips"] = $row["TIPS"];
        array_push($response["completed_actions"], $completed_actionlist);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>