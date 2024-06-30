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
    <title>Dashboard - SB Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

    <script src="${pageContext.request.contextPath}/static/js/admin/datatables-simple-demo.js"></script>

    <link href="${pageContext.request.contextPath}/static/css/admin-styles.css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/static/js/admin/scripts.js"></script>
    
    <style>
    
    
    </style>
    <script>
    
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
                    <h1 class="mt-4">상품 관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
						<li class="breadcrumb-item active">Tables</li>
					</ol>
					<div class="card mb-4">
                            <div class="card-body">
                                상품 관리 관리자 페이지.
                            </div>
                    </div>
                      <button class="btn btn-success" style="margin-bottom: 10px; margin-bottom: 10px; margin-left:1000px;">
                     상품 추가</button>
                    <div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i>
							상품 관리 
						</div>
						
						<div class="card-body">
						
                            <table id="datatablesSimple">
                           
                                <thead>
                                    <tr>
                                    	<th>상품번호</th>
                                        <th>상품명</th>
                                        <th>가격</th>
                                        <th>재고수량</th>
                                        <th>등록날짜</th>
                                        <th>환경인증마크</th>
                                        <th>썸네일이미지</th>
                                        <th>상세이미지</th>
                                        <th>카테고리번호</th>
                                        <th>할인코드</th>
										<th></th>
										<th></th>
									</tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                    	<th>상품번호</th>
                                        <th>상품명</th>
                                        <th>가격</th>
                                        <th>재고수량</th>
                                        <th>등록날짜</th>
                                        <th>환경인증마크</th>
                                        <th>썸네일이미지</th>
                                        <th>상세이미지</th>
                                        <th>카테고리번호</th>
                                        <th>할인코드</th>
										<th></th>
										<th></th>
									</tr>
                                </tfoot>
                                <tbody>
                                <c:forEach var="product" items="${productList}">
                                    <tr>
                                    	<th>${product.productCode}</th>
                                       	<th>${product.productName}</th>
                                        <th>${product.productPrice}</th>
                                        <th>${product.stockQuantity}</th>
                                        <th>${product.registrationDate}</th>
                                        <th>${product.envMark}</th>
                                        <th>${product.thumbnail}</th>
                                        <th>${product.detailImage}</th>
                                        <th>${product.categoryNumber}</th>
                                        <th>${product.discountCode}</th>
                                        <td><button id="updateBtn" type="button" class="btn btn-primary" style="height: 40px; width: 58px;">수정</button></td>
                                    	<td><button id="deleteBtn" type="button" class="btn btn-danger" onclick="" style="height: 40px; width: 58px;">삭제</button></td>
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