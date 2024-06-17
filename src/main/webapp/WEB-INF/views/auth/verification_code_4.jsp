<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>인증번호 입력</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; text-align: center; }
        .form-group { margin-bottom: 15px; text-align: left; }
        .form-group label { display: block; margin-bottom: 5px; }
        .form-group input { width: 100%; padding: 8px; }
        .btn { background-color: green; color: white; padding: 10px 20px; text-decoration: none; }
        .btn:disabled { background-color: grey; }
        .footer { margin-top: 20px; font-size: 12px; color: grey; }
    </style>
</head>
<body>
<div class="container">
    <h2>인증번호 입력</h2>
    <form action="verify_code.jsp" method="post">
        <div class="form-group">
            <label for="verification_code">인증번호</label>
            <input type="text" id="verification_code" name="verification_code" required>
        </div>
        <button type="submit" class="btn">인증하기</button>
    </form>
    <div class="footer">
        새롬터 | 이용약관 | 개인정보 처리 방침<br>
        SearomTae all rights reserved
    </div>
</div>
</body>
</html>
