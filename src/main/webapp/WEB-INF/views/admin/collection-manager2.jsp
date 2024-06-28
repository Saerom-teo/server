<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
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
            .image-container {
                display: flex;
            }
            tr button {
            	font-size: 0.875rem !important;
            }
        </style>
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
                        <h1 class="mt-4">수거 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
                            <li class="breadcrumb-item active">Tables</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                                올레픽 수거 서비스 관리 페이지입니다. 무게 입력은 입력 후 enter키를 눌러주세요.
                            </div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                수거 현황
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>이름</th>
                                            <th>요청일</th>
                                            <th>검사 결과</th>
                                            <th>승인</th>
                                            <th>수거 완료</th>
                                            <th>무게</th>
                                        </tr>
                                    </thead>
                                    <tbody>

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
		<script>
		    $(document).ready(function() {
		        function createRow(item) {
		            var inspectionResultText = (item.inspectionResult === 'clear') ? '통과' : (item.inspectionResult === 'deny') ? '거부' : item.inspectionResult;
		            var inspectionResultStyle = (item.inspectionResult === 'clear') ? 'color: green;' : (item.inspectionResult === 'deny') ? 'color: red;' : '';
		
		            var approvedText = item.approvedDate ? '<button class="btn btn-success btn-sm" disabled>승인됨</button>' : '<button class="btn btn-primary btn-sm approve-btn" data-id="' + item.collectionId + '">승인</button>';
		            var completedText = item.completedDate ? '<button class="btn btn-success btn-sm" disabled>완료됨</button>' : '<button class="btn btn-primary btn-sm complete-btn" data-id="' + item.collectionId + '">완료</button>';
		
		            return '<tr>' +
		                '<td>' + item.collectionId + '</td>' +
		                '<td>' + item.userRealName + '</td>' +
		                '<td>' + new Date(item.requestedDate).toLocaleDateString() + '</td>' +
		                '<td>' + '<a style="' + inspectionResultStyle + '">' + inspectionResultText + '</a>' + '</td>' +
		                '<td>' + approvedText + '</td>' +
		                '<td>' + completedText + '</td>' +
		                '<td>' + (item.weight ? item.weight : '') + '</td>' +
		                '</tr>';
		        }
		
		        function handleSuccess(data) {
		            console.log(data);
		            var tableBody = $('#datatablesSimple tbody');
		            data.forEach(function(item) {
		                var row = createRow(item);
		                tableBody.append(row);
		            });
		            // DataTable 초기화
		            var dataTable = new simpleDatatables.DataTable("#datatablesSimple");
		        }
		
		        $.ajax({
		            url: '../api/collection/read-all-collection',
		            method: 'GET',
		            success: handleSuccess,
		            error: function(xhr, status, error) {
		                console.error('Error fetching data:', error);
		            }
		        });
		
		        // 승인 버튼 클릭 이벤트 핸들러
		        $(document).on('click', '.approve-btn', function() {
		            var collectionId = $(this).data('id');
		            // 승인 처리 로직을 추가하세요 (예: Ajax 요청으로 승인 처리)
		            console.log('승인 버튼 클릭됨, collectionId:', collectionId);
		
		            // 승인 후 버튼을 "승인됨" 텍스트로 변경
		            $(this).closest('td').html('<button class="btn btn-success btn-sm" disabled>승인됨</button>');
		        });
		
		        // 완료 버튼 클릭 이벤트 핸들러
		        $(document).on('click', '.complete-btn', function() {
		            var collectionId = $(this).data('id');
		            // 완료 처리 로직을 추가하세요 (예: Ajax 요청으로 완료 처리)
		            console.log('완료 버튼 클릭됨, collectionId:', collectionId);
		
		            // 완료 후 버튼을 "완료됨" 텍스트로 변경
		            $(this).closest('td').html('<button class="btn btn-success btn-sm" disabled>완료됨</button>');
		        });
		    });
		</script>



    </body>
</html>
