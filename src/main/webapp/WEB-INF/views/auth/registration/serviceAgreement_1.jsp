<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>새롬터 서비스 이용약관 동의</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/serviceAgreement_1.css">
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
            <h2>새롬터 서비스 이용약관 동의</h2>
            <p>새롬터 회원이 되기 위해서는 '새롬터 서비스 이용약관'과 '개인정보 수집 · 이용 동의'에 동의해 주셔야 합니다. 체크 후 [동의하고 계속하기]를 눌러주세요.</p>
        </div>
        <form id="agreementForm" action="registration/personalVerification_2" method="get">
            <div class="terms">
                <div>
                    <label>
                        <input type="checkbox" name="serviceTOS" required> [필수] 새롬터 서비스 이용약관 동의
                    </label>
                    <a href="javascript:void(0);" onclick="openModal('serviceTOS')">보기</a>
                </div>
                <div>
                    <label>
                        <input type="checkbox" name="personalTOS" required> [필수] 개인정보 수집 · 이용 동의
                    </label>
                    <a href="javascript:void(0);" onclick="openModal('personalTOS')">보기</a>
                </div>
                <div>
                    <label>
                        <input type="checkbox" name="marketingTOS"> [선택] 홍보 및 마케팅 이용 동의
                    </label>
                    <a href="javascript:void(0);" onclick="openModal('marketingTOS')">보기</a>
                </div>
                <div>
                    <label>
                        <input type="checkbox" name="thirdPartyTOS"> [선택] 마케팅 개인정보 3자 제공 동의
                    </label>
                    <a href="javascript:void(0);" onclick="openModal('thirdPartyTOS')">보기</a>
                </div>
            </div>
            <div class="btn-container">
                <button type="submit">동의하고 계속하기</button>
            </div>
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

    <!-- Modal -->
    <div id="modal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <div id="modal-text"></div>
        </div>
    </div>

    <script src="<%=request.getContextPath()%>/static/js/serviceAgreement_1.js"></script>
</body>
</html>
