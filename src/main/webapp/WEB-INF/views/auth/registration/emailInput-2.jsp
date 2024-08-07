<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>이메일 입력</title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/auth/emailInput.css">
        <script>
        var baseUrl = window.location.protocol + '//' + window.location.host + '<%=request.getContextPath()%>';
    </script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath()%>/static/js/auth/emailInput.js"></script>
</head>
<body>
<script>
    var baseURL = '<%=request.getContextPath()%>';
</script>
<div class="container">
    <div class="step-indicator">
        <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-1.svg">&nbsp
        <img src="<%=request.getContextPath()%>/static/icon/registration-step/Black-2.svg">&nbsp
        <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-3.svg">&nbsp
        <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-4.svg">&nbsp
        <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-5.svg">&nbsp
    </div>
    <div class="title">
        <h2>이메일 입력(필수)</h2>
        <p>아래 칸에 사용하실 이메일을 입력 후 [다음] 버튼을 눌러주세요.</p>
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
  <%@ include file="/WEB-INF/views/auth/auth-footer.jsp"%>
</div>
</body>
</html>
