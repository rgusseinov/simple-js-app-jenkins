<?php
$envFile = __DIR__ . '/.env';
if (file_exists($envFile)) {
	$lines = file($envFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
	foreach ($lines as $line) {
		if (strpos(trim($line), '#') === 0) {
			continue;
		}
		list($name, $value) = explode('=', $line, 2);
		putenv(trim($name) . '=' . trim($value));
	}
}

$host = getenv('DB_HOST') ?: '127.0.0.1';
$dbname = getenv('DB_NAME');
$username = getenv('DB_USER');
$password = getenv('DB_PASS');

try {
	$pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
	$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

	// Fetch column names dynamically
	$stmt = $pdo->query("SHOW COLUMNS FROM users");
	$columns = $stmt->fetchAll(PDO::FETCH_COLUMN);

	// Fetch all users data
	$stmt = $pdo->query("SELECT * FROM users");
	$users = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
	die("Database connection failed: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Users List</title>
	<style>
		table {
			border-collapse: collapse;
			width: 100%;
		}

		th,
		td {
			border: 1px solid black;
			padding: 8px;
			text-align: left;
		}

		th {
			background-color: #f2f2f2;
		}
	</style>
</head>

<body>
	<h2>Users List</h2>
	<table>
		<thead>
			<tr>
				<?php foreach ($columns as $column): ?>
					<th><?= htmlspecialchars($column) ?></th>
				<?php endforeach; ?>
			</tr>
		</thead>
		<tbody>
			<?php foreach ($users as $user): ?>
				<tr>
					<?php foreach ($columns as $column): ?>
						<td><?= htmlspecialchars($user[$column]) ?></td>
					<?php endforeach; ?>
				</tr>
			<?php endforeach; ?>
		</tbody>
	</table>
</body>

</html>