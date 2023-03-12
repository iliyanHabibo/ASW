<?php
	include "abreconexao.php";

	ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

	$stmt = $conn->prepare( "INSERT INTO utilizador (nome,data_nascimento,genero,morada,localidade,codigo_postal,telefone,email,passwd) VALUES (?, ?, ?, ?)" );
	$stmt->bind_param("siss",$nome,$data_nascimento,$genero,$morada,$localidade,$codigo_postal,$telefone,$email,$passwd);

	$nome = htmlspecialchars($_POST['nome']);
	$data_nascimento = htmlspecialchars(DateTime::createFromFormat('Y-m-d', $_POST['data_nascimento']));
	$genero = htmlspecialchars($_POST['genero']);
    $morada = htmlspecialchars($_POST['morada']);
	$localidade = htmlspecialchars($_POST['localidade']);
	$codigo_postal = htmlspecialchars($_POST['codigo_postal']);
    $telefone = htmlspecialchars($_POST['telefone']);
	$email = htmlspecialchars($_POST['email']);
	$passwd = password_hash(htmlspecialchars($_POST['passwd']), PASSWORD_DEFAULT);
	
	$stmt->execute();
	echo "Sucesso";
	
	if(!preg_match("/^[a-zA-Z]+$/", $nome)) {
		echo "Nome inválido. Insira apenas caracteres alfabéticos.";
		exit();
	}

    if(!$data_nascimento && $data_nascimento->format('Y-m-d') === $_POST['data_nascimento']){
    	echo "Data inválida.";
		exit();
    }

    /*if(!preg_match("/^[a-zA-Z]+$/", $morada)) {
		echo "Morada inválida. Insira apenas caracteres alfabéticos.";
		exit();
	}*/

    if(!preg_match("/^[a-zA-Z]+$/", $localidade)) {
		echo "Localidade inválida. Insira apenas caracteres alfabéticos.";
		exit();
	}

    if(!preg_match ("#[0-9] {7} #", $codigo_postal)) {
		echo "Código postal inválido. Insira apenas valores numéricos naturais.";
		exit();
	}

    if(!preg_match ("#[0-9] {9} #", $telefone)) {
		echo "Telefone inválido. Insira apenas valores numéricos naturais.";
		exit();
	}
	
	if(!filter_var($email, FILTER_VALIDATE_EMAIL)) {
		echo "Email inválido. Insira um email válido no formato username@domain.";
		exit();
	}
	
	if(strlen($passwd) < 8) {
		echo "Senha inválida. Insira uma senha com no mínimo 8 caracteres.";
		exit();
	}
?>