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
	href="${pageContext.request.contextPath}/static/css/envdata.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
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

$(document).ready(function() {
	var now =  decodeURIComponent(window.location.pathname);
	if (now.includes('홍보')) {
		toggle();
		$(".hong").addClass("primary_div");
		if(now.includes('all')) {
			$(".hongall").addClass("primary_div");
		} else if(now.includes('환경')) {
			$(".edu").addClass("primary_div");
		} else {
			$(".recycle").addClass("primary_div");
		}
		
	} else if (now.includes('제도')) {
		$(".jae").addClass("primary_div");
		
	} else if(now.includes('기타')){
		$(".etc").addClass("primary_div");
	} else {
		
		$(".all").addClass("primary_div");
	}
});

function readDetail(envId) {
	var link = "${pageContext.request.contextPath}/envdata/readDetail/" + envId;
	location.href = link;
}

var isOpen = false;
function toggle() {
	if(isOpen) {
		$(".div2-2").html("홍보-교육자료 ▲");
		$(".div2-1").html("");
		isOpen = false;
	} else {
		$(".div2-2").html("홍보-교육자료 ▼");
		let tmp = `
			<div class="hongall div4" onclick="readCategory('홍보-교육자료', 'all')">전체</div>
			<div class="edu  div4 " onclick="readCategory('홍보-교육자료', '환경 교육')">환경 교육</div>
			<div class="recycle div4" onclick="readCategory('홍보-교육자료', '재활용 교육')">재활용 교육</div>
		`;
		$(".div2-1").html(tmp);
		isOpen = true;
	}
}

function readAll() {
	var link = "${pageContext.request.contextPath}/envdata";
	location.href = link;
}

function readCategory(main, sub) {
	var link = "${pageContext.request.contextPath}/envdata/category/" + main + "/" + sub;
	location.href = link;
}

</script>

<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
<title>환경자료 | 새롬터</title>
</head>
<body>
	<div class="envdata">
		<%@ include file="/WEB-INF/views/collection/header.jsp"%>
		<%@ include file="/WEB-INF/views/common/dashboard-nav.jsp"%>
		<div class="div">자료</div>
		<div class="body">
			<div class="envdata-category">
				<div class="all div2" onclick="readAll()">전체</div>
				<div class="hong div2 div2-2" onclick="toggle()">홍보-교육자료 ▲</div>
				<div class="div2-1">
					
				</div>
				<div class="jae div2" onclick="readCategory('제도-정책자료', 'all')">제도-정책자료 </div>
				<div class="etc div2" onclick="readCategory('기타 자료', 'all')">기타 자료</div>
			</div>
			<div class="envdata-body">
				<c:forEach var="envData" items="${envDataList}">
				<div class="envdata-1" onclick="readDetail(${envData.envId})">
					<img class="image-17" src="${envData.envData}"/>
					<div class="frame-52">
						<div class="div5">${envData.envTitle}</div>
						<div class="div6">
						${envData.envContent}
						</div>
					</div>
					<div class="overlay">
						<div><span style="color:yellow">주제</span>${envData.envTitle}</div>
						<div><span style="color:yellow">자료타입</span>${envData.envType}</div>
						<div><span style="color:yellow">등록날짜</span>${envData.enrolledDate}</div>
						<div><span style="color:yellow">카테고리</span>${envData.envMainCategory} > ${envData.envSubCategory}</div>
					</div>
				</div>
				</c:forEach>
			</div>
		</div>
		<%@ include file="/WEB-INF/views/collection/footer.jsp"%>
	</div>

</body>
</html>