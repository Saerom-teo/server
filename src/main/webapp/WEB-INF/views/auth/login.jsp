<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/login.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/static/js/login.js"></script>
</head>
<body>
    <div class="container">
		<div class="logo">
			<img src="<%=request.getContextPath()%>/static/icon/logo.svg" alt="새롬터 로고">
		</div>
		<form action="login" method="post" id="loginForm">
			<div class="form-group">
				<label for="userEmail">아이디</label>
				<input type="text" id="userEmail" name="userEmail" class="adjusted-input" required placeholder="아이디를 입력해 주세요">
				<div id="emailError" class="error-message">이메일 형식으로 작성해 주세요.</div>
			</div>
			<div class="form-group">
				<label for="userPassword">비밀번호</label>
				<input type="password" id="userPassword" name="userPassword" class="adjusted-input" required placeholder="비밀번호를 입력해 주세요">
				<div id="passwordError" class="error-message">비밀번호를 입력해 주세요.</div>
			</div>
			<button type="submit" class="btn">로그인</button>
		</form>
		<div class="links">
			<a href="registration">회원가입</a>
			<div class="right-links">
				<a href="find_id">아이디 찾기</a> 
				<a href="find_password">비밀번호 찾기</a>
			</div>
		</div>
		<div class="divider">또는</div>
		<div class="social-login">
			<a href="<%=request.getContextPath()%>/oauth2/authorization/google">
				<img src="<%=request.getContextPath()%>/static/img/google.png" alt="Google 로그인">
			</a> 
			<a href="<%=request.getContextPath()%>/oauth2/authorization/kakao">
				<img src="<%=request.getContextPath()%>/static/img/kakao.png" alt="Kakao 로그인">
			</a>
		</div>
		<div class="footer">
			<p>
				새롬터 | <a href="#">이용약관</a> | <a href="#">개인정보 처리 방침</a>
			</p>
			<p>SaeromTeo all rights reserved</p>
		</div>
	</div>
</body>
</html>
