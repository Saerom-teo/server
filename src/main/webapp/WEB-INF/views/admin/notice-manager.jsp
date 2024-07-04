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
    <style>
    	.notice-content{
    		overflow: hidden;
  			text-overflow: ellipsis;
  			white-space:nowrap;
  			height: 60px;
    	}
    </style>
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
                            </div>
                        </div>
                        <button class="btn btn-success" style="margin-bottom: 10px;">공지 작성</button>
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
                                    			<td id="notice-content" style="overflow: hidden !important; text-overflow: ellipsis !important; white-space: nowrap !important; height: 60px !important;">${notice.noticeContent}</td>
                                    			<td>${notice.noticeDate}</td>
                                    			<td><button id="updateBtn" type="button" class="btn btn-primary" style="height: 40px; width: 58px;">수정</button></td>
                                    			<td><button id="deleteBtn" type="button" class="btn btn-danger" onclick="noticeDelete(${notice.noticeId})" style="height: 40px; width: 58px;">삭제</button></td>
                                    		</tr>
                                    	</c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <hr style="border: solid 1px;">
                    <div id="editForm" style="display: none; margin-left: 20px; margin-right: 20px;">
                    	<select id="category" class="form-select form-select-sm" aria-label=".form-select-sm example" style="width: 120px;">
						  	<option value="" selected>카테고리</option>
						  	<option value="공지사항">공지사항</option>
						  	<option value="이벤트">이벤트</option>
						  	<option value="일반">일반</option>
						</select>
						<div class="mb-3" style="display: flex; justify-content: space-between; align-items: flex-end;">
					  		<input type="text" class="form-control" id="title" placeholder="제목을 입력해 주세요." style="width: 500px;  height: 33px; margin-top: 10px;">
					  		<button id="editSubmitBtn" type="button" class="btn btn-primary">수정 완료</button>					  	
						</div>
                    <div><%@include file="/WEB-INF/views/editor/editor-notice-form.jsp" %></div>
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
    // 공지 작성 버튼 클릭 이벤트 핸들러
    $(".btn-success").click(function() {
        // 폼 초기화
        $("#category").val("");
        $("#title").val("");
        editor.setHTML("");
        
        // 버튼 텍스트 변경
        $("#editSubmitBtn").text("등록");

        // 폼 보이기
        $("#editForm").slideDown();

        // 등록 버튼 클릭 이벤트 핸들러
        $("#editSubmitBtn").off().click(function() {
            var newCategory = $("#category").val();
            var newTitle = $("#title").val();
            var newContent = editor.getHTML();
            
            if (newCategory === "") {
                alert('카테고리를 선택해 주세요.');
                $("#category").focus();
                return;
            }

            if (newTitle.trim().length === 0) {
                alert('제목을 입력해 주세요.');
                $("#title").focus();
                return;
            }

            var trimmedContent = newContent.trim();
            if (trimmedContent === "" || trimmedContent === "<p><br></p>") {
                alert('내용을 입력해 주세요.');
                editor.focus();
                return;
            }
            
            // AJAX를 통한 데이터 생성 요청
            $.ajax({
                url: "/app/notice/insertNotice",
                type: "POST",
                data: {
                    "noticeCategory": newCategory,
                    "noticeTitle": newTitle,
                    "noticeContent": newContent,
                },
                success: function(response) {
                    if (response === "1건 등록되었습니다.") {
                        alert("1건 등록이 완료되었습니다.");
                        // 등록 완료 후 테이블 새로고침 등의 처리
                        location.reload();
                    } else {
                        alert("등록에 실패했습니다.");
                    }
                },
                error: function(xhr, status, error) {
                    console.log("오류 발생:", error);
                    alert("등록 중 오류가 발생했습니다.");
                }
            });
        });
    });

    // 수정 버튼 클릭 이벤트 핸들러
    $(document).on('click', '#updateBtn', function() {
        var row = $(this).closest("tr");
        var noticeId = row.find("td:eq(0)").text(); // 공지사항 번호
        var category = row.find("td:eq(1)").text(); // 공지사항 카테고리
        var title = row.find("td:eq(2)").text();     // 공지사항 제목
        var content = row.find("td:eq(3)").html();   // 공지사항 내용
        
        /* console.log("공지사항 번호:", noticeId);
        console.log("공지사항 카테고리:", category);
        console.log("공지사항 제목:", title);
        console.log("공지사항 내용:", content); */
        
        // 수정 폼에 값 설정
        $("#category").val(category);
        $("#title").val(title);
        editor.setHTML(content);
     	// 버튼 텍스트 변경
        $("#editSubmitBtn").text("수정완료");
        // 수정 폼 보이기
        $("#editForm").slideDown();

        // 수정 완료 버튼 클릭 이벤트 핸들러
        $("#editSubmitBtn").off().click(function() {
            var editedCategory = $("#category").val();
            var editedTitle = $("#title").val();
            var editedContent = editor.getHTML();
             
             // AJAX를 통한 데이터 업데이트 요청
             $.ajax({
                 url: "/app/notice/updateNotice",
                 type: "PUT",
                 contentType: "application/json",
                 data: JSON.stringify({
                     "noticeId": parseInt(noticeId),
                     "noticeCategory": editedCategory,
                     "noticeTitle": editedTitle,
                     "noticeContent": editedContent,
                     "noticeDate": null
                 }),
                 success: function(response) {
                     if (response === "1건 수정되었습니다.") {
                         alert("수정이 완료되었습니다.");
                         // 수정 완료 후 테이블 새로고침 등의 처리
                         location.reload();
                     } else {
                         alert("수정에 실패했습니다.");
                     }
                 },
                 error: function(xhr, status, error) {
                     console.log("오류 발생:", error);
                     alert("수정 중 오류가 발생했습니다.");
                 }
             });
         });
     });

function noticeDelete(noticeId) {
    if(confirm(noticeId + "번 공지를 삭제하시겠습니까?")) {
        $.ajax({
            url: '/app/notice/deleteNotice/' + noticeId,
            type: 'DELETE',
            success: function(response) {
                alert("삭제가 완료되었습니다.");
                location.reload();
            },
            error: function(xhr, status, error) {
                alert("삭제 실패");
                location.reload();
            }
        });
    }
}

</script>
</body>
</html>