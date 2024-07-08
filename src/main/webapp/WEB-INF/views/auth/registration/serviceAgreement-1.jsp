<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>새롬터 서비스 이용약관 동의</title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
        <script>
        var baseUrl = window.location.protocol + '//' + window.location.host + '<%=request.getContextPath()%>';
    </script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/static/css/auth/service-agreement.css">
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/static/js/auth/service-agreement.js"></script>
        <script>
        var baseUrl = window.location.protocol + '//' + window.location.host + '<%=request.getContextPath()%>';
    </script>
</head>

<body>
	<div class="container">
		<div class="step-indicator">
			<img
				src="<%=request.getContextPath()%>/static/icon/registration-step/Black-1.svg">&nbsp
			<img
				src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-2.svg">&nbsp
			<img
				src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-3.svg">&nbsp
			<img
				src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-4.svg">&nbsp
			<img
				src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-5.svg">&nbsp
		</div>
		<div class="title">
			<h2>새롬터 서비스 이용약관 동의</h2>
			<p>새롬터 회원이 되기 위해서는 '새롬터 서비스 이용약관'과 '개인정보 수집 · 이용 동의'에 동의해 주셔야
				합니다. 체크 후 [동의하고 계속하기]를 눌러주세요.</p>
		</div>
		<form id="agreementForm" method="post">
			<div class="terms">
				<div>
					<label> <input type="checkbox" id="serviceTOS"
						name="serviceTOS" required> [필수] 새롬터 서비스 이용약관 동의
					</label> <a href="javascript:void(0);" onclick="openModal('serviceTOS')">보기</a>
				</div>
				<div>
					<label> <input type="checkbox" id="personalTOS"
						name="personalTOS" required> [필수] 개인정보 수집 · 이용 동의
					</label> <a href="javascript:void(0);" onclick="openModal('personalTOS')">보기</a>
				</div>
				<div>
					<label> <input type="checkbox" id="marketingTOS"
						name="marketingTOS"> [선택] 홍보 및 마케팅 이용 동의
					</label> <a href="javascript:void(0);" onclick="openModal('marketingTOS')">보기</a>
				</div>
				<div>
					<label> <input type="checkbox" id="thirdPartyTOS"
						name="thirdPartyTOS"> [선택] 마케팅 개인정보 3자 제공 동의
					</label> <a href="javascript:void(0);" onclick="openModal('thirdPartyTOS')">보기</a>
				</div>
			</div>
			<div class="btn-container">
				<button type="submit" class="btn" disabled>동의하고 계속하기</button>
			</div>
		</form>
   	<%@ include file="/WEB-INF/views/auth/auth-footer.jsp"%>	 
	</div>

	<!-- Modal -->


</body>
</html>
