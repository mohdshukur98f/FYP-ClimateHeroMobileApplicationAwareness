<?php
error_reporting(0);
include_once ("dbconnect.php");


$sql = "SELECT * FROM 	VITAL_ARCTICSEAICE";


//////////////// Load Completed_Action///////////////////
$result = $conn->query($sql);
if ($result->num_rows > 0)
{
    $response["vital_arcticseaice"] = array();
    while ($row = $result->fetch_assoc())
    {
        $vital_arcticseaice = array();
        $vital_arcticseaice["YEAR"] = $row["YEAR"];
        $vital_arcticseaice["DATA_ARCTICSEAICE"] = $row["DATA_ARCTICSEAICE"];

        array_push($response["vital_arcticseaice"], $vital_arcticseaice);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>