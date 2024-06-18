<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/complete.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">



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
<title>Document</title>
</head>
<body>
	<div class="div">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="frame-8928">
			<img class="_2-2"
				src="${pageContext.request.contextPath}/static/img/tree.png" /> <img
				class="_2-3"
				src="${pageContext.request.contextPath}/static/img/tree.png" />
			<div class="div2">
				결제에 실패했습니다. <br /> 다시 주문을 진행해주세요.
			</div>
		</div>
		<div class="button-bar">
			<div class="button-1">
				<div class="div3">메인 메뉴로 돌아가기</div>
			</div>
			<div class="button-2">
				<div class="div3">계속 쇼핑하기</div>
			</div>
		</div>
	</div>

</body>
</html>