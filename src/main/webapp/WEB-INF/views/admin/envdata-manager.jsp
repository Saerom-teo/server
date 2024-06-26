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
<title>Tables - SB Admin</title>
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

button {
	width: 100px;
	height: 30px;
	font-size: 12px;
}
</style>

<script>
	function showDetail(envId) {
		$.ajax({
			url: "/app/envdata/api/readDetail/" + envId,
			method:"GET",
			dataType: "json",
			success: function(res) {
				$(".envid").val(res.envId);
				$(".envTitle").val(res.envTitle);
				$(".envContent").val(res.envContent);
				$(".envMainCategory").val(res.envMainCategory);
				$(".envSubCategory").val(res.envSubCategory);
				$(".envType").val(res.envType);
			},
			error: function(xhr, status, error) {
	            console.error(xhr.responseText);
	        }
		});
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
					<h1 class="mt-4">환경자료 관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
						<li class="breadcrumb-item active">환경자료 관리</li>
					</ol>
					
					<div class="card mb-4">
					<div class="card-header">
							<i class="fas fa-table me-1"></i> 세부정보
						</div>
						<div class="card-body detail">
							<input type="text" class="envId" disabled/>
							<input type="text" class="envTitle"/>
							<input type="text" class="envContent"/>
							<input type="text" class="envMainCategory"/>
							<input type="text" class="envSubCategory"/>
							<input type="text" class="envType"/>
						</div>
					</div>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i> 환경자료 목록
						</div>
						<div class="card-body">
							<table id="datatablesSimple">
								<thead>
									<tr>
										<th>환경자료아이디</th>
										<th>제목</th>
										<th>메인카테고리</th>
										<th>서브카테고리</th>
										<th>자료형태</th>
										<th>등록날짜</th>
										<th>상세보기</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<th>환경자료아이디</th>
										<th>제목</th>
										<th>메인카테고리</th>
										<th>서브카테고리</th>
										<th>자료형태</th>
										<th>등록날짜</th>
										<th>상세보기</th>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach var="envdata" items="${envDataList}">
									
										<tr>
											<td>${envdata.envId}</td>
											<td>${envdata.envTitle}</td>
											<td>${envdata.envMainCategory}</td>
											<td>${envdata.envSubCategory}</td>
											<td>${envdata.envType}</td>
											<td>${envdata.enrolledDate}</td>
											<td><button class="btn btn-primary" onclick="showDetail(${envdata.envId})">상세보기</button></td>
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
