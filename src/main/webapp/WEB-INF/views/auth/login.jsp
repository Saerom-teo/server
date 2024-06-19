<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<meta charset="UTF-8">
<head>
<script src="${pageContext.request.contextPath}/static/js/login.js"></script>
<link rel="stylesheet"
	href="%=request.getContextPath()%>/static/css/login.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>

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
			<a href="<%=request.getContextPath()%>/oauth2/authorization/google">
				<button type="button">Login with google</button></a>
			<a href="<%=request.getContextPath()%>/oauth2/authorization/kakao">
				<button type="button">Login with Kakao</button>
			</a>
		</div>
		<p>
			Don't have an account? <a href="registration">Sign Up</a>
		</p>
	</div>

</body>
</html>
