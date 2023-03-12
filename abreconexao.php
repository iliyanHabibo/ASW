<?php
$servername = "appserver-01.alunos.di.fc.ul.pt";
$username = "asw18";
$password = "Grupo18bmi";
$dbname = "asw18";
// Cria a ligação à BD
$conn = new mysqli($servername, $username, $password, $dbname);
// Verifica a ligação à BD
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
echo "Conexão efectuada<br>";
?>