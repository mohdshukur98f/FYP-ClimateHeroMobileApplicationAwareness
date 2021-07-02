<?php
error_reporting(0);
include_once ("dbconnect.php");
// $type = $_POST['type'];
// $name = $_POST['name'];

//////////////// Sorting///////////////////
// if (isset($type)){
//     if ($type == "All"){
//         $sql = "SELECT * FROM PRODUCT ORDER BY DATE DESC lIMIT 20";    
//     }else{
//         $sql = "SELECT * FROM PRODUCT WHERE TYPE = '$type'";    
//     }
// }else{
//     $sql = "SELECT * FROM PRODUCT ORDER BY DATE DESC lIMIT 20";    
// }
if (isset($name)){
  $sql = "SELECT * FROM PRODUCT WHERE NAME LIKE  '%$name%'";
} else {
    $sql = "SELECT * FROM ACTION";
}



//////////////// Load Action///////////////////
$result = $conn->query($sql);

if ($result->num_rows > 0)
{
    $response["actions"] = array();
    while ($row = $result->fetch_assoc())
    {
        $actionlist = array();
        $actionlist["id"] = $row["ACTIONID"];
        $actionlist["name"] = $row["NAME"];
        $actionlist["category"] = $row["CATEGORY"];
        $actionlist["vitalsign"] = $row["VITALSIGN"];
        $actionlist["ease"] = $row["EASE"];
        $actionlist["description"] = $row["DESCRIPTION"];
        $actionlist["tips"] = $row["TIPS"];
        array_push($response["actions"], $actionlist);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>