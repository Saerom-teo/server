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
                        <h1 class="mt-4">뉴스 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
                            <li class="breadcrumb-item active">뉴스 관리</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                수거 현황
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>newsId</th>
                                            <th>requestedDate</th>
                                            <th>approvedDate</th>
                                            <th>completedDate</th>
                                            <th>weight</th>
                                            <th>image1</th>
                                            <th>image2</th>
                                            <th>image3</th>
                                            <th>image4</th>
                                            <th>userId</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>collectionId</th>
                                            <th>requestedDate</th>
                                            <th>approvedDate</th>
                                            <th>completedDate</th>
                                            <th>weight</th>
                                            <th>image1</th>
                                            <th>image2</th>
                                            <th>image3</th>
                                            <th>image4</th>
                                            <th>userId</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    	<c:forEach var="collection" items="${collectionList}">
<tr>
                                    			<td>${collection.getCollectionId()}</td>
                                    			<td>${collection.getRequestedDate()}</td>
                                    			<td>
                                                    <c:choose>
                                                        <c:when test="${empty collection.getApprovedDate()}">
                                                            <button type="button" class="btn btn-success" onclick="sendApprovalRequest('${collection.getCollectionId()}')">승인</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${collection.getApprovedDate()}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                    			<td>
                                                    <c:choose>
                                                        <c:when test="${empty collection.getCompletedDate()}">
                                                            <button type="button" class="btn btn-primary">완료</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${collection.getCompletedDate()}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                    			<td>${collection.getWeight()}</td>
                                    			<td><img src="${collection.getImage1()}"></td>
                                    			<td><img src="${collection.getImage2()}"></td>
                                    			<td><img src="${collection.getImage3()}"></td>
                                    			<td><img src="${collection.getImage4()}"></td>
                                    			<td>${collection.getUserId()}</td>
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
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2023</div>
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
    