<?php
error_reporting(0);
include_once ("dbconnect.php");


$sql = "SELECT * FROM 	VITAL_CO2";


//////////////// Load Completed_Action///////////////////
$result = $conn->query($sql);
if ($result->num_rows > 0)
{
    $response["vital_co2"] = array();
    while ($row = $result->fetch_assoc())
    {
        $vital_co2 = array();
        $vital_co2["YEAR"] = $row["YEAR"];
        $vital_co2["MONTH"] = $row["MONTH"];
        $vital_co2["DATA_CO2"] = $row["DATA_CO2"];

        array_push($response["vital_co2"], $vital_co2);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>