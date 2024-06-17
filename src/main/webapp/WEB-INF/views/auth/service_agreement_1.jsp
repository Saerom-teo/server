<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>서비스 이용약관 동의</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            max-width: 600px;
            width: 100%;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            text-align: center;
        }
        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .step-indicator div {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: #ccc;
            margin: 0 5px;
        }
        .step-indicator .active {
            background-color: #000;
        }
        .agreement {
            text-align: left;
            margin: 20px 0;
        }
        .agreement label {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .agreement input {
            margin-right: 10px;
        }
        .btn {
            background-color: green;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-top: 20px;
        }
        .btn:disabled {
            background-color: grey;
        }
        .notice {
            margin-top: 20px;
            font-size: 12px;
            color: grey;
        }
        .footer {
            margin-top: 20px;
            font-size: 12px;
            color: grey;
        }
        .footer a {
            color: grey;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="step-indicator">
        <div class="active"></div>
        <div></div>
        <div></div>
        <div></div>
    </div>
    <h2>새롬터 서비스 이용약관 동의</h2>
    <p>새롬터 회원이 되기 위해서는 '새롬터 서비스 이용약관'과 '개인정보 수집 · 이용 동의'에 동의해 주셔야 합니다. 체크 후 [동의하고 본인 인증하기]를 눌러주세요.</p>
    <div class="agreement">
        <label><input type="checkbox" required> [필수] 새롬터 서비스 이용약관 동의 <a href="#">보기</a></label>
        <label><input type="checkbox" required> [필수] 개인정보 수집 · 이용 동의 <a href="#">보기</a></label>
        <label><input type="checkbox"> [선택] 홍보 및 마케팅 이용 동의 <a href="#">보기</a></label>
        <label><input type="checkbox"> [선택] 마케팅 개인정보 3자 제공 동의 <a href="#">보기</a></label>
    </div>
    <a href="next_step.jsp" class="btn">동의하고 계속하기</a>
    <div class="notice">
        <p>※ 주의사항</p>
        <p>통신사 정책으로 인해 법인명의의 휴대전화 번호로는 본인인증이 되지 않아 가입이 불가할 수 있습니다.</p>
    </div>
    <div class="footer">
        <p>새롬터 | <a href="#">이용약관</a> | <a href="#">개인정보 처리 방침</a></p>
        <p>SearomTae all rights reserved</p>
    </div>
</div>
</body>
</html>
