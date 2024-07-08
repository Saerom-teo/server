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
    <title>퀴즈관리 | 새롬터</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
     <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.2.3/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/admin/datatables-simple-demo.js"></script>
    <link href="${pageContext.request.contextPath}/static/css/admin-styles.css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/static/js/admin/scripts.js"></script>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
<link
	href="${pageContext.request.contextPath}/static/css/admin-styles.css"
	rel="stylesheet" />
<script
	src="${pageContext.request.contextPath}/static/js/admin/scripts.js"></script>

<style>
tr img {
	max-width: 100px;
}


.custom-checkbox {
	display: none;
}

.custom-checkbox-label {
	cursor: pointer;
	display: inline-block;
	width: 30px;
	height: 30px;
	background-color: white;
	border-radius: 5px;
	text-align: center;
	line-height: 30px;
	font-size: 24px;
	color: red;
}

.custom-checkbox-label::after {
	content: 'X';
	display: block;
	transition: 0.3s ease;
}

.custom-checkbox:checked+.custom-checkbox-label::after {
	content: 'O';
	color: green;
}

.quizContent {
	height: 200px;
}

.point {
	width: 100px;
}
</style>

<script>
	function showDetail(quizId) {
		$(".btnSection").html("")
		$(".btnSection").html(`<button class="btn btn-primary" onclick="cancel()">취소하기</button>
				<button class="btn btn-primary" onclick="reset()">초기화</button>
				<button class="btn btn-primary" onclick="modify()">수정하기</button>`);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/quiz/api/readDetail/" + quizId,
			method:"GET",
			dataType: "json",
			success: function(res) {
				$(".quizId").val(res.quizId);
				$(".quizName").val(res.quizName);
				$(".quizContent").val(res.quizContent);
				$(".quizAnswer").prop('checked', res.quizAnswer);
				$(".point").val(res.point);
			},
			error: function(xhr, status, error) {
	            console.error(xhr.responseText);
	        }
		});
		
		window.scrollTo(0,0)
	}
	
	function cancel() {
		$(".quizId").val("");
		$(".quizName").val("");
		$(".quizContent").val("");
		$(".quizAnswer").prop("checked", true);
		$(".point").val("10");
		$(".btnSection").html("");
		$(".btnSection").html(`<button class="btn btn-primary" onclick="create()">생성하기</button>`);
		
	}
	
	function modify() {
		
		if(confirm("수정하시겠습니까?")) {
			var quiz_data = {
					"quizId" : $(".quizId").val(),
					"quizName" : $(".quizName").val(),
					"quizContent" : $(".quizContent").val(),
					"quizAnswer" : $(".quizAnswer").is(":checked"),
					"point" : $(".point").val()
				}
				$.ajax({
					url:"${pageContext.request.contextPath}/quiz/api/update",
					method:"PUT",
					contentType:"application/json",
					data:JSON.stringify(quiz_data),
					success:function(res) {
						alert("수정이 완료되었습니다.");
						location.href = "${pageContext.request.contextPath}/admin/quiz-manager"
					},
					error: function(xhr, status, error) {
						alert("수정 실패");
			            console.error(xhr.responseText);
			        }
				});
			
		} 
		
		
	}
	
	function reset() {
		showDetail($(".quizId").val());
	}
	
	function create() {
		if(confirm("퀴즈를 생성하시겠습니까?")) {
			var quiz_data = {
					"quizName" : $(".quizName").val(),
					"quizContent" : $(".quizContent").val(),
					"quizAnswer" : $(".quizAnswer").is(":checked"),
					"point" : $(".point").val()
				}
				$.ajax({
					url:"${pageContext.request.contextPath}/quiz/api/create",
					method:"POST",
					contentType:"application/json",
					data:JSON.stringify(quiz_data),
					success:function(res) {
						alert("생성이 완료되었습니다.");
						location.href = "${pageContext.request.contextPath}/admin/quiz-manager"
					},
					error: function(xhr, status, error) {
						alert("생성 실패");
			            console.error(xhr.responseText);
			        }
				});
			
		} 
	}
	
	function quizDelete(quizId) {
		if(confirm(quizId + "번 퀴즈를 삭제하시겠습니까?")) {
			$.ajax({
		        url: '${pageContext.request.contextPath}/quiz/api/delete/' + quizId,
		        type: 'DELETE',
		        success: function(response) {
		        	alert("삭제가 완료되었습니다.");
		        	location.href = "${pageContext.request.contextPath}/admin/quiz-manager";
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
					<h1 class="mt-4">퀴즈 관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
						<li class="breadcrumb-item active">퀴즈 관리</li>
					</ol>

					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i> 세부정보
						</div>
						<div class="card-body detail">
							<form id="updateForm">
								<label for="quizId">아이디</label><br> <input
									placeholder="아이디는 임의로 설정할 수 없습니다." type="text"
									class="datatable-input quizId" disabled /> <label for="quizId">퀴즈
									제목</label><br> <input type="text" class="datatable-input quizName" />
								<label for="quizId">퀴즈 내용</label><br> <textarea class="datatable-input quizContent"></textarea>
									 <br>
									<label>퀴즈 답 :</label>
									<input type="checkbox" checked id="custom-checkbox-1" class="custom-checkbox quizAnswer">
    								<label for="custom-checkbox-1" class="custom-checkbox-label"></label> <br><br><label for="quizId">적립
									포인트</label><br> <input type="number" class="datatable-input point" value="10" />
							</form>
							<br>
							<div class="btnSection">
								<button class="btn btn-primary" onclick="create()">생성하기</button>
							</div>

						</div>
					</div>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i> 퀴즈 목록
						</div>
						<div class="card-body">
							<table id="datatablesSimple">
								<thead>
									<tr>
										<th>퀴즈아이디</th>
										<th>이름</th>
										<th>내용</th>
										<th>답</th>
										<th>포인트</th>
										<th>상세정보</th>
										<th>삭제</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<th>퀴즈아이디</th>
										<th>이름</th>
										<th>내용</th>
										<th>답</th>
										<th>포인트</th>
										<th>상세정보</th>
										<th>삭제</th>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach var="quiz" items="${quizList}">

										<tr>
											<td>${quiz.quizId}</td>
											<td>${quiz.quizName}</td>
											<td>${quiz.quizContent}</td>
											<td>${quiz.quizAnswer}</td>
											<td>${quiz.point}</td>
											<td><button class="btn btn-primary"
													onclick="showDetail(${quiz.quizId})">상세보기</button></td>
											<td><button class="btn btn-danger"
													onclick="quizDelete(${quiz.quizId})">삭제</button></td>
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
