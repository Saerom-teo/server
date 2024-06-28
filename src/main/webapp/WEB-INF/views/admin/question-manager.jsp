<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Tables - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
        <link href="${pageContext.request.contextPath}/static/css/admin-styles.css" rel="stylesheet" />
        <script src="${pageContext.request.contextPath}/static/js/admin/scripts.js"></script>        
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-primary" id="nav-bar">
        	<%@ include file="/WEB-INF/views/admin/nav.jsp"%>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
            	<%@ include file="/WEB-INF/views/admin/side-nav.jsp"%>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">문의사항</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
                            <li class="breadcrumb-item active">Tables</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                                DataTables is a third party plugin that is used to generate the demo table below. For more information about DataTables, please visit the
                                <a target="_blank" href="https://datatables.net/">official DataTables documentation</a>
                                .
                            </div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                문의
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th>카테고리</th>
                                            <th>제목</th>
                                            <th>등록날짜</th>
                                            <th>답변여부</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>번호</th>
                                            <th>카테고리</th>
                                            <th>제목</th>
                                            <th>등록날짜</th>
                                            <th>답변여부</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    	<c:forEach var="questions" items="${questionList}">
											<tr>
                                    			<td>${questions.questionId}</td>
                                    			<td>${questions.questionCategory}</td>
                                    			<td>${questions.questionTitle}</td>
                                    			<td>${questions.questionDate}</td>
                                    			<td>
									                <c:choose>
									                    <c:when test="${fn:length(questions.questionAnswer) == 0}">
									                        대기중
									                    </c:when>
									                    <c:otherwise>
									                        답변완료
									                    </c:otherwise>
									                </c:choose>
									            </td>
									            <td>
									                <c:choose>
									                    <c:when test="${fn:length(questions.questionAnswer) == 0}">
									                        <button id="insertBtn" type="button" class="btn btn-success" onclick="readDetail(${questions.questionId})" style="height: 40px; width: 58px;">답변</button>
									                    </c:when>
									                    <c:otherwise>
									                        <button id="insertBtn" type="button" class="btn btn-secondary" disabled style="height: 40px; width: 58px;">답변</button>
									                    </c:otherwise>
									                </c:choose>
									            </td>
									            <td><button id="deleteBtn" type="button" class="btn btn-danger" onclick="questionDelete(${questions.userId})" style="height: 40px; width: 58px;">삭제</button></td>
									        </tr>
                                    	</c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>                                      
                    <hr style="border: solid 1px;">
                    <div id="insertForm" style="display: none;">
                    	<div style="border: 1px solid lightgrey; width: 71%; padding: 20px 20px 0px 20px; border-radius: 10px; margin: 20px 0px 20px 20px;">
	                    	┏ 제목 ┓<p id="questionTitle"></p>
	                    	┌ 내용 ┐<p id="questionContent"></p>
                    	</div>
                    	<div style="display: inline-flex; flex-direction: column; align-items: flex-end;">
	                    	<div>
		                    	<button id="updateBtn" class="btn btn-success">답변완료</button>
		                    	<button id="closeBtn" class="btn btn-secondary" style="margin-left: 15px; margin-right: 30px; ">닫기</button>
	                    	</div>
	                    	<div style="margin: 15px; width: 1200px"><jsp:include page="/WEB-INF/views/editor/editor-question-form.jsp"/></div>
                    	</div>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; saeromteo 2024</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/static/js/admin/datatables-simple-demo.js"></script>
<script>
	function readDetail(questionId) {
	    $.ajax({
	        url: "../question/readDetail/" + questionId,
	        type: "GET",
	        success: function(response) {
	            // 요청이 성공하면 실행될 코드
	            console.log('데이터 읽기 성공:', response);
	            // response에서 questionTitle과 questionContent 가져오기
	            var questionTitle = response.questionTitle;
	            var questionContent = response.questionContent;
	
	            // HTML 요소에 값 설정
	            $("#questionTitle").text(questionTitle);
	            $("#questionContent").text(questionContent);
	
	            // 폼을 슬라이드 다운하고 포커스 및 스크롤 적용
	            $("#insertForm").slideDown(400, function() {
	                editor.focus();
	                window.scrollTo({ top: document.body.scrollHeight, behavior: 'auto' });
	            });
	         	// questionId를 전역 변수로 설정
                window.currentQuestionId = questionId;
	        },
	        error: function(xhr, status, error) {
	            // 요청이 실패하면 실행될 코드
	            console.error('데이터 읽기 실패:', error);
	        }
	    });
	}
	
	$(document).ready(function() {
	    $("#closeBtn").click(function() {
	        $("#insertForm").slideUp(400);
	    });
	});
</script>
</body>
</html>