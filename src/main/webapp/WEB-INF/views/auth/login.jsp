<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/login.js"></script>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/login.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
</head>
<body>
    <div class="container">
        <div class="logo">
            <img src="<%=request.getContextPath()%>/static/img/logo.svg" alt="새롬터 로고">
        </div>
        <form action="login_process.jsp" method="post">
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" required placeholder="아이디를 입력해 주세요">
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required placeholder="비밀번호를 입력해 주세요">
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
            <a href="<%=request.getContextPath()%>/oauth2/authorization/google" class="google">
                <img src="<%=request.getContextPath()%>/static/img/google.png" alt="Google 로그인">
            </a>
            <a href="<%=request.getContextPath()%>/oauth2/authorization/kakao" class="kakao">
                <img src="<%=request.getContextPath()%>/static/img/kakao.png" alt="Kakao 로그인">
            </a>
        </div>
        <div class="footer">
            <p>새롬터 | <a href="#">이용약관</a> | <a href="#">개인정보 처리 방침</a></p>
            <p>SearomTae all rights reserved</p>
        </div>
    </div>
</body>
</html>
