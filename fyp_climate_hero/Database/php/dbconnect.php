<?php
$servername = "localhost";
$username   = "seriousl_climate_hero";
$password   = "Jsgfc2013";
$dbname     = "seriousl_climate_hero";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>