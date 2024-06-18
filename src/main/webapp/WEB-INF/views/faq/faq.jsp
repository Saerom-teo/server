<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">
  <link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/faq.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
a, button, input, select, h1, h2, h3, h4, h5, * {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	border: none;
	text-decoration: none;
	background: none;
	-webkit-font-smoothing: antialiased;
}

menu, ol, ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
}
</style>
<script src="${pageContext.request.contextPath}/static/js/faq.js"></script>
<title>Document</title>
</head>
<body>
	<div class="notice">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="body">
			<div class="nav">
				<div class="frame-8914">
					<img class="image-26"
						src="${pageContext.request.contextPath}/static/img/notice-img.png" />
					<div class="div">고객 센터</div>
				</div>
				<a href="../notice/readAll"><div class="div2">공지사항</div></a>
				<a href="../faq/read"><div class="div3">자주 묻는 질문</div></a>
				<div class="div4">문의사항</div>
			</div>
		</div>
	<div class="faq">
	<div class="faqTitle">
        <p>궁금한 사항이 있으시면 문의 사항 카테고리를 통해 편하게 질문 해 주시면 상세히 답변 해 드리겠습니다.</p>
    </div>
    <div class="faqContent">
        <div class="faqItem">
            <p class="faqQuestion" onclick="toggleAnswer(this)">Q: 플라스틱 수거 신청은 어떻게 하나요?</p>
            <p class="faqAnswer">A: 홈페이지에 로그인한 후, 
            '플라스틱 수거 신청' 섹션에서 필요한 정보를 입력하고 신청 버튼을 클릭하시면 됩니다. 
            신청 완료 후, 수거 일정과 방법에 대한 상세 정보를 이메일로 받으실 수 있습니다.</p>
        </div>
        <div class="faqItem">
            <p class="faqQuestion" onclick="toggleAnswer(this)">Q: 수거된 플라스틱은 어떻게 처리되나요?</p>
            <p class="faqAnswer">A: 수거된 플라스틱은 저희 시설로 옮겨져 철저한 검사를 거친 후, 
            재활용 가능한 플라스틱은 다양한 친환경 제품을 만드는 데 사용됩니다. 
            모든 과정은 환경 보호 기준에 따라 진행됩니다.</p>
        </div>
        <div class="faqItem">
            <p class="faqQuestion" onclick="toggleAnswer(this)">Q: 포인트는 어떻게 사용할 수 있나요?</p>
            <p class="faqAnswer">A: 적립된 포인트는 웹사이트 내에서 친환경 제품을 구매할 때 사용할 수 있습니다. 
            포인트 사용 옵션은 결제 페이지에서 선택할 수 있으며, 
            포인트 잔액은 계정 페이지에서 확인할 수 있습니다.</p>
        </div>
        <div class="faqItem">
            <p class="faqQuestion" onclick="toggleAnswer(this)">Q: 제품 배송은 얼마나 걸리나요?</p>
            <p class="faqAnswer">A: 제품은 주문 확인 후 3-5 영업일 이내에 배송됩니다. 
            배송 상태는 웹사이트의 '주문 상태 조회' 섹션에서 실시간으로 확인 가능합니다.</p>
        </div>
        <div class="faqItem">
            <p class="faqQuestion" onclick="toggleAnswer(this)">Q: 제품을 반품하거나 교환하고 싶어요. 어떻게 해야 하나요?</p>
            <p class="faqAnswer">A: 제품 수령 후 7일 이내에 반품이나 교환을 원하시면, 
            웹사이트의 '고객 지원' 섹션을 통해 반품 또는 교환 요청을 할 수 있습니다. 
            제품 상태와 반품 이유를 명시해 주세요.</p>
        </div>
        <div class="faqItem">
            <p class="faqQuestion" onclick="toggleAnswer(this)">Q: 계정 정보를 잊어버렸어요. 어떻게 해야 하나요?</p>
            <p class="faqAnswer">A: '로그인' 페이지에서 '비밀번호 찾기' 또는 '아이디 찾기' 옵션을 선택하여 계정 복구 절차를 진행할 수 있습니다. 
            필요한 정보를 입력하면 이메일로 계정 복구 링크를 보내드립니다.</p>
        </div>
        <div class="faqItem">
            <p class="faqQuestion" onclick="toggleAnswer(this)">Q: 환경 교육 자료는 어디에서 볼 수 있나요?</p>
            <p class="faqAnswer">A: '환경 교육' 섹션에서 다양한 환경 보호 및 재활용 관련 교육 자료를 제공하고 있습니다. 
            교육 자료는 정기적으로 업데이트되며 뉴스, 정보, 퀴즈 형식으로 제공됩니다.</p>
        </div>
    </div>
    </div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>