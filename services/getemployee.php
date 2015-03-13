<?php
include 'config.php';

$sql = "select e.id, e.firstName, e.lastName, e.managerId, e.title, e.department, e.city, e.officePhone, e.cellPhone, " .
		"e.email, e.picture, m.firstName managerFirstName, m.lastName managerLastName, count(r.id) reportCount " . 
		"from employee e left join employee r on r.managerId = e.id left join employee m on e.managerId = m.id " .
		"where e.id=:id group by e.lastName order by e.lastName, e.firstName";

try {
	$dbh = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass);	
	$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$stmt = $dbh->prepare($sql);  
	$stmt->bindParam('id', $_GET['id']);
	$stmt->execute();
	$employee = $stmt->fetchObject();  
	$dbh = null;
	echo '{"item":'. json_encode($employee) .'}'; 
} catch(PDOException $e) {
	echo '{"error":{"text":'. $e->getMessage() .'}}'; 
}

?>