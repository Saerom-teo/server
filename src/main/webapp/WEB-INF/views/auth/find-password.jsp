<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>이메일 입력</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/emailInput.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath()%>/static/js/find-password.js"></script>
</head>
<body>
<script>
    var baseURL = '<%=request.getContextPath()%>';
</script>
<div class="container">
    <div class="title">
        <h2>이메일 입력(필수)</h2>
        <p>아래 칸에 비밀번호를 찾으실 이메일을 입력 후 [다음] 버튼을 눌러주세요.</p>
    </div>
    <form id="emailForm" action="verificationCode_3" method="post">
        <div class="form-group">
            <label for="userEmail">이메일</label>
            <input type="email" id="userEmail" name="userEmail" required placeholder="이메일을 입력해 주세요">
        </div>
        <div class="form-group">
            <p id="emailFormatText">이메일 형식</p>
            <span class="check-icon" id="check-icon">✔</span>
        </div>
        <div class="btn-container">
            <button type="submit" class="btn" id="submitBtn" name= "submitBtn" disabled>다음</button>
        </div>
    </form>
    <div class="footer">
        <p>새롬터 | <a href="#">이용약관</a> | <a href="#">개인정보 처리 방침</a></p>
        <p>SearomTae all rights reserved</p>
    </div>
</div>
</body>
</html>
