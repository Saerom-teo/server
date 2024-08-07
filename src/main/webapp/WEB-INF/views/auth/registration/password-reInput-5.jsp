<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 재입력</title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/auth/emailInput.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
        <script>
        var baseUrl = window.location.protocol + '//' + window.location.host + '<%=request.getContextPath()%>';
    </script>
    <script src="<%=request.getContextPath()%>/static/js/auth/password-reinput.js "></script>
<body>
<div class="container">
    <div class="step-indicator">
        <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-1.svg">&nbsp;
        <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-2.svg">&nbsp;
        <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-3.svg">&nbsp;
        <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-4.svg">&nbsp;
        <img src="<%=request.getContextPath()%>/static/icon/registration-step/Black-5.svg">&nbsp;
    </div>
    <div class="title">
        <h2>비밀번호 재입력(필수)</h2>
        <p>아래 칸에 입력하신 비밀번호를 입력 후 [다음] 버튼을 눌러주세요.</p>
    </div>
    <form id="passWordReInput">
        <div class="form-group">
            <label for="confirmPassword">비밀번호</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="비밀번호를 입력해 주세요" maxlength="16">
        </div>
        <div class="btn-container">
            <button type="submit" class="btn active" id="submitBtn">다음</button>
        </div>
    </form>
  <%@ include file="/WEB-INF/views/auth/auth-footer.jsp"%>
</div>
</body>
</html>
