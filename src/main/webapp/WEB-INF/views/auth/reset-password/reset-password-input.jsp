<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 입력(필수)</title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/auth/emailInput.css">
        <script>
        var baseUrl = window.location.protocol + '//' + window.location.host + '<%=request.getContextPath()%>';
    </script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath()%>/static/js/auth/reset-password-input.js"></script>

</head>
<body>
	<div class="container">
		<div class="title">
			<h2>비밀번호 재설정</h2>
			<p>아래 칸에 사용하실 비밀번호를 입력 후 [다음] 버튼을 눌러주세요.</p>
		</div>
		<form id="passwordForm" method="post">
			<div class="form-group">
				<label for="userPassword">비밀번호</label> <input type="password"
					id="userPassword" name="userPassword" required
					placeholder="비밀번호를 입력하세요" maxlength="16">
				<div class="form-group">
					<p class="emailFormatText">8~16자 사이</p>
					<span class="check-icon">✔</span>
				</div>
				<div class="form-group">
					<p class="passwordFormatText" style="bottom: -55px;">영문
						(대소문자구분), 숫자, 특수문자 중 2개 사용</p>
					<span class="check-icon-password-CheckIcon">✔</span>
				</div>
			</div>
			<div class="btn-container">
				<button type="submit" class="btn" id="submitBtn" disabled>다음</button>
			</div>
		</form>
		<%@ include file="/WEB-INF/views/auth/auth-footer.jsp"%>
	</div>
</body>
</html>

