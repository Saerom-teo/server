<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>뉴스관리 | 새롬터</title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<link
	href="${pageContext.request.contextPath}/static/css/admin-styles.css"
	rel="stylesheet" />
<script
	src="${pageContext.request.contextPath}/static/js/admin/scripts.js"></script>

<style>
tr img {
	max-width: 100px;
}
[id^="toggle-slider"] {
	display: none;
}

.toggle-slider-label {
	text-indent: -999em;
	cursor: pointer;
	width: 60px;
	height: 30px;
	background-color: #e0e0e0;
	border-radius: 25px;
	position: relative;
	transition: 0.05s ease-out;
}

.toggle-slider-label::after {
    content: ''; 
    width: 20px; 
    height: 20px;
    background-color: #fff;
    position: absolute;
    border-radius: 50%;
    top: 5px;
    left: 5px;
    transition: 0.05s ease-out;
}

[id^="toggle-slider"]:checked + .toggle-slider-label {
    background-color: #20d51a;
}

[id^="toggle-slider"]:checked + .toggle-slider-label::after {
    left:calc(60%);
    background-color: #fff;
}
</style>


<script>
function update_news_check(who, newsId) {
	var isChecked = $(who).is(":checked")
	
	var news_data = {
		"newsId" : newsId,
		"newsCheck" : isChecked
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/news/api/updateNews",
		method: "PUT",
		contentType: "application/json",
		data: JSON.stringify(news_data),
		success : function(data) {
		},
		error: function(xhr, status, error) {
            console.error(xhr.responseText);
        }
	})
}


</script>
</head>
<body class="sb-nav-fixed">
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-primary"
		id="nav-bar">
		<%@ include file="/WEB-INF/views/admin/nav.jsp"%>
	</nav>
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<%@ include file="/WEB-INF/views/admin/side-nav.jsp"%>
		</div>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">뉴스 관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
						<li class="breadcrumb-item active">뉴스 관리</li>
					</ol>
					<div class="card mb-4">
						<div class="card-body">
							업데이트된 날짜 <br> ${updateNewsDate}
						</div>
					</div>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i> 뉴스 목록
						</div>
						<div class="card-body">
							<table id="datatablesSimple">
								<thead>
									<tr>
										<th>뉴스아이디</th>
										<th>제목</th>
										<th>요약</th>
										<th>게시일</th>
										<th>링크</th>
										<th>공개</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<th>뉴스아이디</th>
										<th>공개여부</th>
										<th>제목</th>
										<th>요약</th>
										<th>게시일</th>
										<th>링크</th>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach var="news" items="${newsList}">
										<tr>
											<td>${news.newsId}</td>
											<td>${news.newsTitle}</td>
											<td>${news.newsDescription}</td>
											<td>${news.newsPubdate}</td>
											<td><a href="${news.newsUrl}" target="_blanck">링크</a></td>
											
											<td>
											<input type="checkbox" id="toggle-slider-${news.newsId}" onclick="update_news_check(this, ${news.newsId})"
											<c:if test="${news.newsCheck == true}"> checked </c:if>
											>
											
											<label for="toggle-slider-${news.newsId}" class="toggle-slider-label">on/off</label>
											</td>

										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</main>
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; Your Website 2023</div>
						<div>
							<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
								&amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/admin/datatables-simple-demo.js"></script>
</body>
</html>
