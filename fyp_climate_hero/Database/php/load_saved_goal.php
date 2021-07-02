<?php
error_reporting(0);
include_once ("dbconnect.php");
$email = $_POST['email'];

$sql = "SELECT * FROM SAVED_GOAL WHERE USERID='$email'";

//////////////// Load Completed_Action///////////////////
$result = $conn->query($sql);
if ($result->num_rows > 0)
{
    $response["saved_goals"] = array();
    while ($row = $result->fetch_assoc())
    {
        $saved_goalslist = array();
        $saved_goalslist["userid"] = $row["USERID"];
        $saved_goalslist["id"] = $row["ACTIONID"];
        $saved_goalslist["name"] = $row["NAME"];
        $saved_goalslist["category"] = $row["CATEGORY"];
        $saved_goalslist["vitalsign"] = $row["VITALSIGN"];
        $saved_goalslist["ease"] = $row["EASE"];
        $saved_goalslist["description"] = $row["DESCRIPTION"];
        $saved_goalslist["tips"] = $row["TIPS"];
        array_push($response["saved_goals"], $saved_goalslist);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>