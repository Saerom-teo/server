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
	href="${pageContext.request.contextPath}/static/css/envdata.css">
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

.header {
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 1000;
}
</style>

<script>

function readDetail(envId) {
	var link = "/app/envdata/readDetail/" + envId;
	location.href = link;
}

</script>

<title>Document</title>
</head>
<body>
	<div class="envdata">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<%@ include file="/WEB-INF/views/common/newsnav.jsp"%>
		<div class="div">자료</div>
		<div class="body">
			<div class="envdata-category">
				<div class="div2">홍보-교육자료 ▼</div>
				<div class="div3">환경 교육</div>
				<div class="div4">재활용 교육</div>
				<div class="div2">제도-정책자료 </div>
				<div class="div2">기타 자료</div>
			</div>
			<div class="envdata-body">
				<c:forEach var="envData" items="${envDataList}">
				<div class="envdata-1" onclick="readDetail(${envData.envId})">
					<img class="image-17" src="${pageContext.request.contextPath}/static/img/news-image1.png"/>
					<div class="frame-52">
						<div class="div5">${envData.envTitle}</div>
						<div class="div6" tu:utext="${envData.envContent}">
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>

</body>
</html>