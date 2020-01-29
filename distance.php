<?php

function vincentyGreatCircleDistance(
  $latitudeFrom, $longitudeFrom, $latitudeTo, $longitudeTo, $earthRadius = 6371000)
{
  // convert from degrees to radians
  $latFrom = deg2rad($latitudeFrom);
  $lonFrom = deg2rad($longitudeFrom);
  $latTo = deg2rad($latitudeTo);
  $lonTo = deg2rad($longitudeTo);

  $lonDelta = $lonTo - $lonFrom;
  $a = pow(cos($latTo) * sin($lonDelta), 2) +
    pow(cos($latFrom) * sin($latTo) - sin($latFrom) * cos($latTo) * cos($lonDelta), 2);
  $b = sin($latFrom) * sin($latTo) + cos($latFrom) * cos($latTo) * cos($lonDelta);

  $angle = atan2(sqrt($a), $b);
  return $angle * $earthRadius;
}


$inputLat = $_GET['lat'];
$inputLong = $_GET['long'];

$con = mysqli_connect("51.137.144.220", "root", "password", "lol") or die("failed");

$results = mysqli_query($con, "SELECT * from locations;");

$distances = [];

while ($row = mysqli_fetch_array($results)) {
	$distanceInM = vincentyGreatCircleDistance($inputLat, $inputLong, $row["Lat"], $row["Long"]);
	$distances[$row["Provider_Id"]] = $distanceInM/1609;
}

asort($distances);

foreach(array_slice($distances, 0, 10, true) as $id => $values) {
	$result2 = mysqli_query($con, "SELECT distinct Provider_Name from operations where Provider_Id = '" . $id . "'");
	$row = mysqli_fetch_assoc($result2);

	echo $row["Provider_Name"] . " - " . $values[0] . " miles away (lat: ".$values[1].", long: ".$values[2].")<br/>";
}