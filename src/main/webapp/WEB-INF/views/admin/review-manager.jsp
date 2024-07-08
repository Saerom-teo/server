<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath }"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>후기관리 | 새롬터</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
     <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.2.3/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/admin/datatables-simple-demo.js"></script>
    <link href="${pageContext.request.contextPath}/static/css/admin-styles.css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/static/js/admin/scripts.js"></script>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
    <style>
    	#addProductBtn{
    		margin-left: 1080px;
    	}
    	img {
    		width: 100px;
    	}
    </style>
    <script>
	function reviewDelete(reviewId) {
		if(confirm(reviewId + "번 리뷰를 삭제하시겠습니까?")) {
			$.ajax({
		        url: '${pageContext.request.contextPath}/review/deleteReview/' + reviewId,
		        type: 'DELETE',
		        success: function(response) {
		        	alert("삭제가 완료되었습니다.");
		        	location.href = "${pageContext.request.contextPath}/admin/review-manager";
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
                    <h1 class="mt-4">리뷰 관리</h1>
                    <ol class="breadcrumb mb=4">
                        <li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active">Tables</li>
                    </ol>
                    <div class="card mb-4">
                        <div class="card-body">리뷰 관리 페이지입니다.</div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i> 리뷰 관리
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                    <tr>
                                        <th>리뷰번호</th>
                                        <th>상품번호</th>
                                        <th>상품명</th>
                                        <th>내용</th>
                                        <th>점수</th>
                                        <th>작성날짜</th>
                                        <th>리뷰이미지</th>
                                        <th>작성인번호</th>
                                        <th>작성인이름</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>리뷰번호</th>
                                        <th>상품번호</th>
                                        <th>상품명</th>
                                        <th>내용</th>
                                        <th>점수</th>
                                        <th>작성날짜</th>
                                        <th>리뷰이미지</th>
                                        <th>작성인번호</th>
                                        <th>작성인이름</th>
                                        <th></th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <c:forEach var="review" items="${reviewList}">
                                        <tr>
                                        	<td>${review.reviewId }</td>
                                        	<td>${review.productCode }</td>
                                        	<td>${review.productName }</td>
                                        	<td>${review.reviewContent }</td>
                                        	<td>${review.reviewScore }</td>
                                        	<td>${review.writeDate }</td>
                                        	<c:if test="${review.reviewImage==null}"><td></td></c:if>
                                        	<c:if test="${review.reviewImage!=null}"><td><img src="${review.reviewImage }"></td></c:if>
                                        	<td>${review.userCode }</td>
                                        	<td>${review.userName}</td>
                                            <td><button type="button" class="btn btn-danger deleteBtn"  onclick="reviewDelete(${review.reviewId})">삭제</button></td>
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
                            <a href="#">Privacy Policy</a> &middot; <a href="#">Terms &amp; Conditions</a>
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
