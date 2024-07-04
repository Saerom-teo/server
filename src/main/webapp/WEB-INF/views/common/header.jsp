<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/header.css">
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
<title>Insert title here</title>
</head>
<body>
	<div class="header">
		<div class="logo">
			<img class="union"
				src="${pageContext.request.contextPath}/static/img/logo.svg" />
			<div class="header-div"><span id="logo-text" style="color: var(--primary)">새롬터</span></div>
		</div>
		<div class="header-div2">
			플라스틱 <br /> 수거
		</div>
		<div class="header-div3">
			친환경 <br /> 장터
		</div>
		<div class="header-div3">
			친환경 <br /> 커뮤니티
		</div>
		<div class="search">
			<div class="frame-6">
				<img class="group-8736"
					src="${pageContext.request.contextPath}/static/img/search.svg" />
			</div>
		</div>
		<img class="favorite-fill"
			src="${pageContext.request.contextPath}/static/img/zzim.svg" /> <img
			class="box-alt"
			src="${pageContext.request.contextPath}/static/img/basket.svg" /> <img
			class="bell-pin"
			src="${pageContext.request.contextPath}/static/img/notice.svg" /> <img
			class="header-user"
			src="${pageContext.request.contextPath}/static/img/User.svg" />
	</div>
	
</body>
</html>