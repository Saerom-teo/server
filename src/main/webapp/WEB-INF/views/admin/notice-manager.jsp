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
        
        <style>
        	tr img {
        		max-width: 100px;
        	}
        	</style>
        	<script>
            function sendApprovalRequest(collectionId) {
            	console.log(collectionId);
                const url = `${pageContext.request.contextPath}/api/admin/collection/approve?collectionId=`+collectionId;
                window.location.href = url;
            }
        </script>
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
                                    			<td><button id="" type="button" class="btn btn-primary" onclick="function(update)" style="height: 40px; width: 58px;">수정</button></td>
                                    			<td><button id="" type="button" class="btn btn-secondary" onclick="function(delete)" style="height: 40px; width: 58px;">삭제</button></td>
                                    		</tr>
                                    	</c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <hr style="border: solid 1px;">
                    <div>
                    	<select id=category class="form-select form-select-sm" aria-label=".form-select-sm example" style="width: 120px;">
						  	<option selected>카테고리</option>
						  	<option value="공지사항">공지사항</option>
						  	<option value="이벤트">이벤트</option>
						  	<option value="일반">일반</option>
						</select>
							<div class="mb-3" style="display: flex; justify-content: space-between; align-items: flex-end;">
						  		<input type="text" class="form-control" id="title" placeholder="제목을 입력해 주세요." style="width: 500px;  height: 33px; margin-top: 10px;">
						  		<button id="submitBoardBtn" type="submit" class="btn btn-success">등록</button>
							</div>
                    </div>
                    <%@include file="/WEB-INF/views/editor/editor-form.jsp" %>
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
    </body>
</html>
    