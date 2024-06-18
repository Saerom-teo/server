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
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 8px;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
    <script>
        function openModal(modalId) {
            document.getElementById(modalId).style.display = "block";
        }

        function closeModal(modalId) {
            document.getElementById(modalId).style.display = "none";
        }

        window.onclick = function(event) {
            var modals = document.getElementsByClassName('modal');
            for (var i = 0; i < modals.length; i++) {
                if (event.target == modals[i]) {
                    modals[i].style.display = "none";
                }
            }
        }

        function validateForm() {
            var requiredAgreements = document.querySelectorAll('.agreement input[type="checkbox"][required]');
            for (var i = 0; i < requiredAgreements.length; i++) {
                if (!requiredAgreements[i].checked) {
                    alert('필수 항목에 동의하셔야 합니다.');
                    return false;
                }
            }

            var marketingAgreement = document.querySelector('.agreement input[name="marketing"]').checked;
            var thirdPartyAgreement = document.querySelector('.agreement input[name="thirdParty"]').checked;

            var form = document.getElementById('agreementForm');
            var marketingInput = document.createElement('input');
            marketingInput.type = 'hidden';
            marketingInput.name = 'marketing';
            marketingInput.value = marketingAgreement;

            var thirdPartyInput = document.createElement('input');
            thirdPartyInput.type = 'hidden';
            thirdPartyInput.name = 'thirdParty';
            thirdPartyInput.value = thirdPartyAgreement;

            form.appendChild(marketingInput);
            form.appendChild(thirdPartyInput);

            return true;
        }
    </script>
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
    <form id="agreementForm" action="next_step.jsp" method="post" onsubmit="return validateForm();">
        <div class="agreement">
            <label><input type="checkbox" required> [필수] 새롬터 서비스 이용약관 동의 <a href="javascript:void(0);" onclick="openModal('serviceModal')">보기</a></label>
            <label><input type="checkbox" required> [필수] 개인정보 수집 · 이용 동의 <a href="javascript:void(0);" onclick="openModal('personalModal')">보기</a></label>
            <label><input type="checkbox" name="marketing"> [선택] 홍보 및 마케팅 이용 동의 <a href="javascript:void(0);" onclick="openModal('marketingModal')">보기</a></label>
            <label><input type="checkbox" name="thirdParty"> [선택] 마케팅 개인정보 3자 제공 동의 <a href="javascript:void(0);" onclick="openModal('thirdPartyModal')">보기</a></label>
        </div>
        <button type="submit" class="btn">동의하고 계속하기</button>
    </form>
    <div class="notice">
        <p>※ 주의사항</p>
        <p>통신사 정책으로 인해 법인명의의 휴대전화 번호로는 본인인증이 되지 않아 가입이 불가할 수 있습니다.</p>
    </div>
    <div class="footer">
        <p>새롬터 | <a href="#">이용약관</a> | <a href="#">개인정보 처리 방침</a></p>
        <p>SearomTae all rights reserved</p>
    </div>
</div>

<div id="serviceModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('serviceModal')">&times;</span>
        <h2>새롬터 서비스 이용약관</h2>
        <p>여기에 서비스 이용약관 내용을 입력합니다...</p>
    </div>
</div>

<div id="personalModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('personalModal')">&times;</span>
        <h2>개인정보 수집 및 이용 동의</h2>
        <p>여기에 개인정보 수집 및 이용 동의 내용을 입력합니다...</p>
    </div>
</div>

<div id="marketingModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('marketingModal')">&times;</span>
        <h2>홍보 및 마케팅 이용 동의</h2>
        <p>여기에 홍보 및 마케팅 이용 동의 내용을 입력합니다...</p>
    </div>
</div>

<div id="thirdPartyModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('thirdPartyModal')">&times;</span>
        <h2>마케팅 개인정보 3자 제공 동의</h2>
        <p>여기에 마케팅 개인정보 3자 제공 동의 내용을 입력합니다...</p>
    </div>
</div>

</body>
</html>
