<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>인증번호 입력</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/verificationCode.css">
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
            <h2>인증번호 입력</h2>
            <p>문자메세지로 수신받은 6자리 인증번호를 아래 칸에 입력 후 [인증하기] 버튼을 눌러주세요.</p>
        </div>
        <form id="verificationForm" action="verification_process.jsp" method="post">
            <div class="form-group">
                <label for="code">인증번호</label>
                <input type="text" id="code" name="code" required placeholder="인증번호를 입력해 주세요">
                <p id="timer">남은시간 2:56</p>
                <a href="javascript:void(0);" id="resend">재전송</a>
            </div>
            <div class="notice-container">
                <div class="notice">
                    <p>※문자메시지를 받지 못한 경우</p>
                    <p>휴대전화의 차단메시지함을 확인하시거나 가입한 통신사로 문자 차단 서비스를 이용하고 있는지 확인해주세요.</p>
                </div>
            </div>
            <div class="btn-container">
                <button type="submit" class="btn" id="submitBtn">인증하기</button>
            </div>
        </form>
        <div class="footer">
            <p>새롬터 | <a href="#">이용약관</a> | <a href="#">개인정보 처리 방침</a></p>
            <p>SearomTae all rights reserved</p>
        </div>
    </div>
    <script src="<%=request.getContextPath()%>/static/js/verificationCode.js"></script>
</body>
</html>
