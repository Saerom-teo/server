<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                        <h1 class="mt-4">공지 관리</h1>
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
                                공지 사항
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>공지사항 번호</th>
                                            <th>공지사항 카테고리</th>
                                            <th>공지사항 제목</th>
                                            <th>공지사항 내용</th>
                                            <th>공지사항 등록날짜</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>공지사항 번호</th>
                                            <th>공지사항 카테고리</th>
                                            <th>공지사항 제목</th>
                                            <th>공지사항 내용</th>
                                            <th>공지사항 등록날짜</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    	<c:forEach var="notice" items="${noticeList}">
											<tr>
                                    			<td>${notice.noticeId}</td>
                                    			<td>${notice.noticeCategory}</td>
                                    			<td>${notice.noticeTitle}</td>
                                    			<td>${notice.noticeContent}</td>
                                    			<td>${notice.noticeDate}</td>
                                    			<td><button id="updateBtn" type="button" class="btn btn-primary" style="height: 40px; width: 58px;">수정</button></td>
                                    			<td><button id="deleteBtn" type="button" class="btn btn-secondary" onclick="function(delete)" style="height: 40px; width: 58px;">삭제</button></td>
                                    		</tr>
                                    	</c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <hr style="border: solid 1px;">
                    <div id="editForm" style="display: none;">
                    	<select id="category" class="form-select form-select-sm" aria-label=".form-select-sm example" style="width: 120px;">
						  	<option selected>카테고리</option>
						  	<option value="공지사항">공지사항</option>
						  	<option value="이벤트">이벤트</option>
						  	<option value="일반">일반</option>
						</select>
						<div class="mb-3" style="display: flex; justify-content: space-between; align-items: flex-end;">
					  		<input type="text" class="form-control" id="title" placeholder="제목을 입력해 주세요." style="width: 500px;  height: 33px; margin-top: 10px;">
					  		<button id="editSubmitBtn" type="button" class="btn btn-primary">수정 완료</button>
					  		<button id="submitBoardBtn" type="submit" class="btn btn-success">등록</button>
						</div>
                    <%@include file="/WEB-INF/views/editor/editor-form.jsp" %>
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
	        $(document).ready(function() {
	            // 수정 버튼 클릭 이벤트 핸들러
	            $(document).on('click', '#updateBtn', function() {
	                var row = $(this).closest("tr");
	                var noticeId = row.find("td:eq(0)").text(); // 공지사항 번호
	                var category = row.find("td:eq(1)").text(); // 공지사항 카테고리
	                var title = row.find("td:eq(2)").text();     // 공지사항 제목
	                var content = row.find("td:eq(3)").text();   // 공지사항 내용
	                
	                console.log("공지사항 번호:", noticeId);
	                console.log("공지사항 카테고리:", category);
	                console.log("공지사항 제목:", title);
	                console.log("공지사항 내용:", content);
	                
	                // 수정 폼에 값 설정
	                $("#category").val(category);
	                $("#title").val(title);
	                setEditorContent(content);
	                
	                // 수정 폼 보이기
	                $("#editForm").slideDown();
	
	                // 수정 완료 버튼 클릭 이벤트 핸들러
	                $("#editSubmitBtn").off().click(function() {
	                    var editedCategory = $("#category").val();
	                    var editedTitle = $("#title").val();
						var editedContent = editor.getHTML();
	                    
	                    // AJAX를 통한 데이터 업데이트 요청
	                    $.ajax({
	                        url: "${pageContext.request.contextPath}/api/admin/updateNotice",
	                        type: "post",
	                        data: {
	                            "noticeId": noticeId,
	                            "noticeCategory": editedCategory,
	                            "noticeTitle": editedTitle,
	                            "noticeContent" : editedContent
	                            // 필요시 noticeContent 등 추가
	                        },
	                        success: function (data) {
	                            if (data == "ok") {
	                                // 수정 완료 후 테이블 새로고침 등의 처리
	                                location.reload();
	                            }
	                        }
	                    });
	                });
	            });
	        });

            
	        $(document).ready(function() {
	            // 삭제 버튼 클릭 이벤트 핸들러
	            $(document).on('click', '#deleteBtn', function() {
	                var row = $(this).closest("tr");
	                var noticeId = row.find("td:eq(0)").text(); // 공지사항 번호

	                // 사용자에게 삭제 여부 확인 대화상자 표시
	                if (confirm("정말로 삭제하시겠습니까?")) {
	                    // AJAX를 통한 데이터 삭제 요청
	                    $.ajax({
	                        url: "${pageContext.request.contextPath}/api/admin/deleteNotice",
	                        type: "post",
	                        data: {
	                            "noticeId": noticeId
	                        },
	                        success: function (data) {
	                            if (data == "ok") {
	                                // 삭제 완료 후 테이블 새로고침 등의 처리
	                                location.reload();
	                            }
	                        }
	                    });
	                }
	            });
	        });
        </script>
    </body>
</html>
    