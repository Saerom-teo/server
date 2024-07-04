<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/auth/login.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/static/js/auth/login.js"></script>
     <script>
        var baseUrl = window.location.protocol + '//' + window.location.host + '<%=request.getContextPath()%>';
    </script>
    
</head>
<body>
    <div class="container">
		<div class="logo">
			<a href ="<%=request.getContextPath()%>/"><img src="<%=request.getContextPath()%>/static/icon/logo.svg" alt="새롬터 로고"></a>
		</div>
		<form method="post" id="loginForm">
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
            <a href="registration" id="registrationLink">회원가입</a>
            <div class="right-links">
                <a href="reset-password-email" id="resetPasswordLink">비밀번호재발급</a>
            </div>
        </div>
		<div class="divider">또는</div>
		<div class="social-login">
			<a href="<%=request.getContextPath()%>/oauth2/authorization/google">
				<img src="<%=request.getContextPath()%>/static/icon/google-logo.svg" alt="Google 로그인">
			</a> 
			<a href="<%=request.getContextPath()%>/oauth2/authorization/kakao">
				<img src="<%=request.getContextPath()%>/static/icon/kakao-logo.svg" alt="Kakao 로그인">
			</a>
		</div>
		  <%@ include file="/WEB-INF/views/auth/auth-footer.jsp"%>
	</div>
</body>
</html>
