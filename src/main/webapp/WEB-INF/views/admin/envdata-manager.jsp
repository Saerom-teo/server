<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Dashboard - SB Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
     <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.2.3/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/admin/datatables-simple-demo.js"></script>
    <link href="${pageContext.request.contextPath}/static/css/admin-styles.css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/static/js/admin/scripts.js"></script>
<style>
tr img {
	max-width: 100px;
}

.envContent {
	height: 200px;
	
}
</style>

<script>
	$(document).ready(function() {
		$("select.envMainCategory").change(function() {
			$("select.envSubCategory option").remove();
			
			var envMainCategory = $(".envMainCategory").val();
			if(envMainCategory == "홍보-교육자료") {
				$("select.envSubCategory").append("<option selected>환경 교육</option>")
				$("select.envSubCategory").append("<option>재활용 교육</option>")
			}
		});
	});

	function showDetail(envId) {
		$(".btnSection").html("")
		$(".btnSection").html(`<button class="btn btn-primary" onclick="cancel()">취소하기</button>
				<button class="btn btn-primary" onclick="reset()">초기화</button>
				<button class="btn btn-primary" onclick="modify()">수정하기</button>`);
		
		$("select.envSubCategory option").remove();
		$.ajax({
			url: "${pageContext.request.contextPath}/envdata/api/readDetail/" + envId,
			method:"GET",
			dataType: "json",
			success: function(res) {
				$(".envId").val(res.envId);
				$(".envTitle").val(res.envTitle);
				editor.setMarkdown(res.envContent);
				$(".envMainCategory").val(res.envMainCategory);
				if(res.envMainCategory == "홍보-교육자료") {
					$("select.envSubCategory").append("<option selected>환경 교육</option>")
					$("select.envSubCategory").append("<option>재활용 교육</option>")
				}
				$(".envSubCategory").val(res.envSubCategory);
				$(".envType").val(res.envType);
				$(".envType").prop("disabled", true);
				$(".envData").prop("hidden", true);
				$("#envDataLabel").prop("hidden", true);
			},
			error: function(xhr, status, error) {
	            console.error(xhr.responseText);
	        }
		});
		window.scrollTo(0,0)
	}
	
	function cancel() {
		$(".envId").val("");
		$(".envTitle").val("");
		$(".envContent").val("");
		$(".envMainCategory").val("");
		$(".envSubCategory").val("");
		$(".envType").prop("disabled", false);
		$(".envType").val("");
		editor.setMarkdown("");
		$(".envData").prop("hidden", false);
		$("#envDataLabel").prop("hidden", false);
		$(".btnSection").html("");
		$(".btnSection").html(`<button class="btn btn-primary" onclick="create()">생성하기</button>`);
		
	}
	
	function modify() {
		
		if(confirm("수정하시겠습니까?")) {
			var env_data = {
					"envId" : $(".envId").val(),
					"envTitle" : $(".envTitle").val(),
					"envContent" : editor.getHTML(),
					"envMainCategory" : $(".envMainCategory").val(),
					"envSubCategory" : $(".envSubCategory").val(),
				}
			$.ajax({
		        url: '${pageContext.request.contextPath}/envdata/api/update',
		        type: 'PUT',
		        contentType:"application/json",
				data:JSON.stringify(env_data),
		        success: function(response) {
		        	alert("환경자료가 수정되었습니다.");
		        	location.href = "${pageContext.request.contextPath}/admin/envdata-manager";
		        },
		        error: function(xhr, status, error) {
		        	alert("수정 실패")
		        }
		    });
		}
	} 
	
	function reset() {
		showDetail($(".envId").val());
		
	}
	
	function create() {
		if(confirm("환경자료를 생성하시겠습니까?")) {
			var formData = new FormData();
			formData.append('envTitle', $('.envTitle').val());
		    formData.append('envContent', $('.envContent').val());
		    formData.append('envDataFile', $('.envData')[0].files[0]);
		    formData.append('envMainCategory', $('.envMainCategory').val());
		    formData.append('envSubCategory', $('.envSubCategory').val());
		    formData.append('envType', $('.envType').val());
		    $.ajax({
		        url: '${pageContext.request.contextPath}/envdata/api/create',
		        type: 'POST',
		        contentType: false,
		        processData: false,
		        data: formData,
		        success: function(response) {
		        	alert("환경자료가 생성되었습니다.");
		        	location.href = "${pageContext.request.contextPath}/admin/envdata-manager";
		        },
		        error: function(xhr, status, error) {
		        	alert("생성 실패")
		        }
		    });
			
		} 
		
	}
	
	function envDelete(envId) {
		if(confirm(envId + "번 자료를 삭제하시겠습니까?")) {
			$.ajax({
		        url: '${pageContext.request.contextPath}/envdata/api/delete/' + envId,
		        type: 'DELETE',
		        success: function(response) {
		        	alert("삭제가 완료되었습니다.");
		        	location.href = "${pageContext.request.contextPath}/admin/envdata-manager";
		        },
		        error: function(xhr, status, error) {
		        	alert("삭제 실패")
		        }
		    });
		}
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
							<label for="envId"><b>아이디</b></label><br>
							<input type="text" class="datatable-input envId" disabled placeholder="아이디는 임의로 설정할 수 없습니다."/>
							<label for="envTitle"><b>제목</b></label><br>
							<input type="text" class="datatable-input envTitle"/>
							<label for="envContent"><b>내용</b></label><br>
							<!-- <textarea class="datatable-input envContent">
							</textarea> -->
							<%@include file="/WEB-INF/views/editor/editor-envdata-form.jsp" %>
							<br><label><b>데이터타입</b></label><br>
							<select type="text" class="datatable-selector envType">
								<option selected>사진</option>
								<option>동영상</option>
								<option>문서</option>
								<option>기타</option>
							</select>
							<input type="file" class="envData"> 
							<br><br>
							<label><b>카테고리</b></label><br>
							<label for="envMainCategory">메인</label>
							<select type="text" class="datatable-selector envMainCategory">
								<option selected>홍보-교육자료</option>
								<option>제도-정책자료</option>
								<option>기타 자료</option>
							</select>
							<span> > </span>
							<label for="envSubCategory">서브</label>
							<select type="text" class="datatable-selector envSubCategory">
								<option selected>환경 교육</option>
								<option>재활용 교육</option>
							</select><br><br>
							
							
							<div class="btnSection">
								<button id="submitBoardBtn" onclick="submitCreate()" class="btn btn-primary">생성하기</button>
							</div>
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
										<th>삭제</th>
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
										<th>삭제</th>
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
											<td><button class="btn btn-danger" onclick="envDelete(${envdata.envId})">삭제</button></td>
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
