<?php
error_reporting(0);
include_once ("dbconnect.php");
$email = $_POST['email'];

$sql = "SELECT * FROM ADD_GOAL WHERE USERID='$email'";


$result = $conn->query($sql);
if ($result->num_rows > 0)
{
    $response["add_goals"] = array();
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
        array_push($response["add_goals"], $completed_actionlist);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>