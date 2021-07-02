<?php
error_reporting(0);
include_once ("dbconnect.php");


$sql = "SELECT * FROM 	VITAL_TEMPT";


//////////////// Load Completed_Action///////////////////
$result = $conn->query($sql);
if ($result->num_rows > 0)
{
    $response["vital_tempt"] = array();
    while ($row = $result->fetch_assoc())
    {
        $vital_tempt = array();
        $vital_tempt["YEAR"] = $row["YEAR"];
        $vital_tempt["CELSIUS"] = $row["CELSIUS"];

        array_push($response["vital_tempt"], $vital_tempt);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>