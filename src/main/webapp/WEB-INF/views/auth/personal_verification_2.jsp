<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>본인인증 이용약관 동의</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; text-align: center; }
        .agreement { text-align: left; margin-top: 20px; }
        .agreement input { margin-right: 10px; }
        .btn { background-color: green; color: white; padding: 10px 20px; text-decoration: none; }
        .btn:disabled { background-color: grey; }
        .footer { margin-top: 20px; font-size: 12px; color: grey; }
    </style>
</head>
<body>
<div class="container">
    <h2>본인인증 이용약관 동의</h2>
    <p>본인인증 서비스를 이용하기 위해서는 아래 약관을 동의해 주셔야 합니다.</p>
    <div class="agreement">
        <label><input type="checkbox" required> [필수] 개인정보 이용 동의</label> <a href="#">보기</a><br>
        <label><input type="checkbox" required> [필수] 고유식별 정보처리 동의</label> <a href="#">보기</a><br>
        <label><input type="checkbox" required> [필수] 서비스 이용약관 동의</label> <a href="#">보기</a><br>
        <label><input type="checkbox" required> [필수] 통신사 이용약관 동의</label> <a href="#">보기</a><br>
    </div>
    <a href="verify_identity.jsp" class="btn">동의하고 본인인증하기</a>
    <div class="footer">
        새롬터 | 이용약관 | 개인정보 처리 방침<br>
        SearomTae all rights reserved
    </div>
</div>
</body>
</html>
