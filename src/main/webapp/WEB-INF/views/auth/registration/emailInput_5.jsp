<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>이메일 입력</title>
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
    <h2>이메일 입력</h2>
    <form action="next_step.jsp" method="post">
        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" required>
        </div>
        <button type="submit" class="btn">다음</button>
    </form>
    <div class="footer">
        새롬터 | 이용약관 | 개인정보 처리 방침<br>
        SearomTae all rights reserved
    </div>
</div>
</body>
</html>


