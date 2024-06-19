<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>이메일 입력</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/emailInput.css">
</head>
<body>
    <div class="container">
        <div class="step-indicator">
            <div class="active"></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
        <div class="title">
            <h2>이메일 입력(필수)</h2>
            <p>아래 칸에 사용하실 이메일을 입력 후 [다음] 버튼을 눌러주세요.</p>
        </div>
        <form id="emailForm" action="verificationCode_3" method="post">
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required placeholder="이메일을 입력해 주세요">
            </div>
            <div class="form-group">
                <p id="emailFormatText">이메일 형식</p>
                <span class="check-icon" id="emailCheckIcon">&#10003;</span>
            </div>
            <div class="btn-container">
                <button type="submit" class="btn" id="submitBtn">다음</button>
            </div>
        </form>
        <div class="footer">
            <p>새롬터 | <a href="#">이용약관</a> | <a href="#">개인정보 처리 방침</a></p>
            <p>SearomTae all rights reserved</p>
        </div>
    </div>
    <script src="<%=request.getContextPath()%>/static/js/emailInput.js"></script>
</body>
</html>
