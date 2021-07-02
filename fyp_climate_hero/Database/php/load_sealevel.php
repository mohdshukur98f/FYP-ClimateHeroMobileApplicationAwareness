<?php
error_reporting(0);
include_once ("dbconnect.php");

$sql = "SELECT * FROM 	VITAL_SEA";

//////////////// Load Completed_Action///////////////////
$result = $conn->query($sql);
if ($result->num_rows > 0)
{
    $response["vital_sealevel"] = array();
    while ($row = $result->fetch_assoc())
    {
        $vital_sealevel = array();
        $vital_sealevel["YEAR"] = $row["YEAR"];
        $vital_sealevel["SEALEVEL"] = $row["SEALEVEL"];

        array_push($response["vital_sealevel"], $vital_sealevel);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>