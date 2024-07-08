<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>인증번호 입력</title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
        <script>
        var baseUrl = window.location.protocol + '//' + window.location.host + '<%=request.getContextPath()%>';
    </script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/auth/emailInput.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath()%>/static/js/auth/verification-code.js"></script>
</head>
<body>
    <div class="container">
        <div class="step-indicator">
            <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-1.svg">&nbsp;
            <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-2.svg">&nbsp;
            <img src="<%=request.getContextPath()%>/static/icon/registration-step/Black-3.svg">&nbsp;
            <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-4.svg">&nbsp;
            <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-5.svg">&nbsp;
        </div>
        <div class="title">
            <h2>인증번호 입력</h2>
            <p>이메일로 수신받은 6자리 인증번호를 아래 칸에 입력 후 [인증하기] 버튼을 눌러주세요.</p>
        </div>
        <form id="verificationForm" action="verification-process" method="post">
            <div class="form-group">
                <label for="code">인증번호</label>
                <input type="text" id="code" name="code" placeholder="인증번호를 입력하세요">
            </div>
            <div class="form-group form-group-inline">
                <span id="timer" class="timer-text">남은시간 2:59</span>
                <span id="resend" class="resend-btn">재전송</span>
            </div>
            <div class="btn-container">
                <button id="submitBtn" class="btn" type="submit" disabled>인증하기</button>
            </div>
        </form>
  <%@ include file="/WEB-INF/views/auth/auth-footer.jsp"%>
    </div>
    
</body>
</html>
