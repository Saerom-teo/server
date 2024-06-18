<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>본인인증 정보 입력</title>
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
    <h2>본인인증 정보 입력</h2>
    <form action="send_verification_code.jsp" method="post">
        <div class="form-group">
            <label for="name">이름</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="birthdate">생년월일/성별</label>
            <input type="text" id="birthdate" name="birthdate" required>
        </div>
        <div class="form-group">
            <label for="carrier">통신사</label>
            <select id="carrier" name="carrier" required>
                <option value="SKT">SKT</option>
                <option value="KT">KT</option>
                <option value="LGU+">LGU+</option>
                <option value="알뜰폰">알뜰폰</option>
            </select>
        </div>
        <div class="form-group">
            <label for="phone">휴대전화 번호</label>
            <input type="text" id="phone" name="phone" required>
        </div>
        <button type="submit" class="btn">인증문자 받기</button>
    </form>
    <div class="footer">
        새롬터 | 이용약관 | 개인정보 처리 방침<br>
        SearomTae all rights reserved
    </div>
</div>
</body>
</html>
