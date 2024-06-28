<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 입력(필수)</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/emailInput.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/static/js/passwordInput.js"></script>
</head>
<body>
    <div class="container">
       <div class="step-indicator">
            <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-1.svg">&nbsp;
            <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-2.svg">&nbsp;
            <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-3.svg">&nbsp;
            <img src="<%=request.getContextPath()%>/static/icon/registration-step/Black-4.svg">&nbsp;
            <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-5.svg">&nbsp;
            <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-6.svg">&nbsp;
        </div>
        <div class="title">
            <h2>비밀번호 입력(필수)</h2>
            <p>아래 칸에 사용하실 비밀번호를 입력 후 [다음] 버튼을 눌러주세요.</p>
        </div>
        <form id="passwordForm" action="passwordReInput" method="post">
            <div class="form-group">
                <label for="userPassword">비밀번호</label>
                <input type="password" id="userPassword" name="userPassword" required placeholder="비밀번호를 입력하세요">
                <div class="form-group">
                    <p class="emailFormatText">8~16자 사이</p>
                    <span class="check-icon">✔</span>
                </div>
                <div class="form-group">
                    <p class="passwordFormatText" style="bottom:-55px;">영문 (대소문자구분), 숫자, 특수문자 중 2개 사용</p>
                    <span class="check-icon-password-CheckIcon">✔</span>
                </div>
            </div>
            <div class="btn-container">
                <button type="submit" class="btn" id="submitBtn" disabled>다음</button>
            </div>
        </form>
        <div class="footer">
            <p>새롬터 | <a href="#">이용약관</a> | <a href="#">개인정보 처리 방침</a></p>
            <p>SearomTae all rights reserved</p>
        </div>
    </div>
</body>
</html>

