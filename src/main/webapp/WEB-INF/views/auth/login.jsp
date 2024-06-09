<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/include/header.jsp"%>

<html lang="ko">
<meta charset="UTF-8">
<head>
 <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/login.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<style>
body {
	font-family: Arial, sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	background-color: #f7f7f7;
}

.login-container {
	background-color: #ffffff;
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.login-container h1 {
	margin-bottom: 10px;
}

.login-container p {
	margin-bottom: 20px;
	color: #888;
}

.login-container input[type="email"], .login-container input[type="password"]
	{
	width: 100%;
	padding: 10px;
	margin: 10px 0;
	border: 1px solid #ddd;
	border-radius: 5px;
}

.login-container button {
	width: 100%;
	padding: 10px;
	background-color: #4caf50;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.login-container button:hover {
	background-color: #45a049;
}

.login-container .social-login {
	display: flex;
	justify-content: space-around;
	margin: 20px 0;
}

.login-container .social-login img {
	width: 40px;
	height: 40px;
	cursor: pointer;
}

.login-container a {
	color: #4caf50;
	text-decoration: none;
}

.login-container a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<div class="login-container">
		<h1>로그인</h1>
		<p>Hi welcome back</p>
		<form id="loginForm">
			<input type="email" name="userEmail" placeholder="example@gmail.com"
				required> <input type="password" name="userPassword"
				placeholder="**********" required> <a href="#">Forget
				Password?</a>
			<button type="submit">Log In</button>
		</form>
		<hr>
		<p>Or Log in with</p>
		<div class="social-login">
			<img src="" alt="Google"> <img src="" alt="Kakao">
		</div>
		<p>
			Don't have an account? <a href="registration">Sign Up</a>
		</p>
	</div>
</body>
</html>
