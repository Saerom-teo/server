<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>인증번호 입력</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/static/css/verificationCode.css">
</head>
<body>
	<div class="container">
		<div class="step-indicator">
			<img
				src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-1.svg">
			<img
				src="<%=request.getContextPath()%>/static/icon/registration-step/Black-2.svg">
			<img
				src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-3.svg">
			<img
				src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-4.svg">
			<img
				src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-5.svg">
			<img
				src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-6.svg">
		</div>
		<div class="title">
			<h2>인증번호 입력</h2>
			<p>이메일로 수신받은 6자리 인증번호를 아래 칸에 입력 후 [인증하기] 버튼을 눌러주세요.</p>
		</div>
		<form id="verificationForm" action="verification_process"
			method="post">
			<div class="form-group">
				<label for="code">인증번호</label> <input type="text" id="code"
					name="code" placeholder="인증번호를 입력하세요">
				<div class="resend-container">
					<p id="timer">남은시간 3:00</p>
					<a id="resend">재전송</a>
				</div>
			</div>
			<div class="notice-container">
				<div class="notice">
					<p>※이메일을 받지 못한 경우</p>
					<p>이메일의 차단메시지함을 확인 혹은 스팸 메시지함을 확인해주세요.</p>
				</div>
			</div>
			<div class="btn-container">
				<button id="submitBtn" class="btn" type="submit">인증하기</button>
			</div>
		</form>
		<div class="footer">
			<p>
				새롬터 | <a href="#">이용약관</a> | <a href="#">개인정보 처리 방침</a>
			</p>
			<p>SearomTae all rights reserved</p>
		</div>
	</div>
	<script
		src="<%=request.getContextPath()%>/static/js/verificationCode.js"></script>
</body>
</html>
