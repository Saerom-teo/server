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
	href="${pageContext.request.contextPath}/static/css/envdetail.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
html, body, .body {
	height: 100%;
}
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

.header {
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 1000;
}
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
    // 원하는 id에 current-page 클래스를 추가합니다.
    var currentPageId = "envdata";
    document.getElementById(currentPageId).classList.add("current-page");
});

	function goQuiz() {
		location.href = "${pageContext.request.contextPath}/quiz";
	}
</script>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
<title>환경자료 | 새롬터</title>
</head>
<body>
	<div class="envdetail" style="margin-bottom: 30px;">
		<%@ include file="/WEB-INF/views/collection/header.jsp"%>
		<%@ include file="/WEB-INF/views/common/dashboard-nav.jsp"%>
		<div class="div">자료</div>
		<div class="body">
			<div class="body-1">
				<img class="image-36"
					src="${envData.envData}" />
				<div class="div2">${envData.envTitle}</div>
				<div class="div3">
                    <c:out value="${envData.envContent}" escapeXml="false" />
                </div>
			</div>
			<div class="body-2">
				<div class="body-2-2">
					<div class="div4">퀴즈를 풀고 포인트를 획득하세요</div>
					<div class="_3">
						하루에 최대 5개의 문제를 풀 수 있어요 <br /> 포인트로는 상품을 구매할 수 있고 기부도 가능해요
					</div>
					<div class="button-1" onclick="goQuiz()">
						<div class="div5" >퀴즈 풀러 가기</div>
					</div>
				</div>
				<div class="body-2-3">
					<div class="feat">
						<span> <span class="feat-span">주제</span> <span
							class="feat-span2"></span> <span class="feat-span3">${envData.envTitle }</span>
						</span>
					</div>
					<div class="div6">
						<span> <span class="div-6-span">타입</span> <span
							class="div-6-span2"></span> <span class="div-6-span3">${envData.envType }</span>
						</span>
					</div>
					<div class="_2024-06-01">
						<span> <span class="_2024-06-01-span">등록 날짜</span> <span
							class="_2024-06-01-span2"></span> <span class="_2024-06-01-span3">${envData.enrolledDate }</span>
						</span>
					</div>
					<div class="_2024-06-01">
						<span> <span class="_2024-06-01-span">카테고리</span> <span
							class="_2024-06-01-span2"></span> <span class="_2024-06-01-span3">${envData.envMainCategory} > ${envData.envSubCategory}</span>
						</span>
					</div>
				</div>
			</div>
		</div>
	</div>
		<%@ include file="/WEB-INF/views/collection/footer.jsp"%>

</body>
</html>