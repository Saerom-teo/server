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
	href="${pageContext.request.contextPath}/static/css/notice.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

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
	<div class="notice">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div class="body">
			<div class="nav">
				<div class="frame-8914">
					<img class="image-26"
						src="${pageContext.request.contextPath}/static/img/notice-img.png" />
					<div class="div">고객 센터</div>
				</div>
				<div class="div2">공지사항</div>
				<div class="div3">자주 묻는 질문</div>
				<div class="div3">문의사항</div>
			</div>
			<div class="ul">
				<div class="head">
					<div class="num">
						<div class="div4">번호</div>
					</div>
					<div class="cate">
						<div class="div4">분류</div>
					</div>
					<div class="title">
						<div class="div4">제목</div>
					</div>
					<div class="date">
						<div class="div5">등록일</div>
					</div>
				</div>
				<div class="li">
					<div class="frame-8916">
						<div class="_5">5</div>
					</div>
					<div class="frame-8917">
						<div class="div6">문의</div>
					</div>
					<div class="frame-8918">
						<div class="div7">상품 배송이 안됐어요</div>
					</div>
					<div class="frame-8919">
						<div class="_2024-01-05">2024-01-05</div>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>

</body>
</html>