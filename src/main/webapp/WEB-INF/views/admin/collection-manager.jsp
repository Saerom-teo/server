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
        <script>
            function sendApprovalRequest(collectionId) {
                console.log(collectionId);
                const url = pageContext.request.contextPath + "/api/collection/approve?collectionId=" + collectionId;
                window.location.href = url;
            }
    
            function checkApprovedDate(approvedDate, collectionId, inspectionResult) {
                console.log(collectionId);
                if (!approvedDate) {
                    if (inspectionResult === 'deny') {
                        return '<button type="button" class="btn btn-success" disabled>승인</button>';
                    }
                    return '<button type="button" class="btn btn-success" onclick="sendApprovalRequest(\'' + collectionId + '\')">승인</button>';
                }
                return approvedDate;
            }
    
            function checkCompletedDate(completedDate) {
                if (!completedDate) {
                    return '';
                }
                return completedDate;
            }
    
            function checkWeight(weight, completedDate, approvedDate) {
                if (!completedDate) {
                    if (!approvedDate) {
                        return '<button type="button" class="btn btn-primary" disabled>입력</button>';
                    }
                    return '<button type="button" class="btn btn-primary" onclick="showInputField(this)">입력</button>';
                }
                return weight;
            }
    
            function showInputField(button) {
                const cell = button.parentNode;
                const collectionId = cell.parentNode.querySelector('td:nth-child(1)').textContent.trim();
                cell.innerHTML = '<input type="number" class="form-control" min="0" step="1" onkeyup="handleKeyUp(event, this, \'' + collectionId + '\')" />';
            }
    
            function handleKeyUp(event, input, collectionId) {
                if (event.key === 'Enter' && input.value.trim() !== '') {
                    const weight = input.value.trim();
                    if (confirm(weight + ' kg을 입력하시겠습니까?')) {
                        const url = pageContext.request.contextPath + "/api/collection/complete?collectionId=" + collectionId + "&weight=" + weight;
                        window.location.href = url;
                    }
                }
            }

            function showModal(images) {
                document.getElementById('modalImage1').src = images[0];
                document.getElementById('modalImage2').src = images[1];
                document.getElementById('modalImage3').src = images[2];
                document.getElementById('modalImage4').src = images[3];
                new bootstrap.Modal(document.getElementById('imageModal')).show();
            }
    
            document.addEventListener('DOMContentLoaded', function() {
                const rows = document.querySelectorAll('#datatablesSimple tbody tr');
                
                rows.forEach(row => {
                    const approvedDate = row.querySelector('td:nth-child(3)').textContent.trim();
                    const collectionId = row.querySelector('td:nth-child(1)').textContent.trim();
                    const inspectionResult = row.querySelector('td:nth-child(6)').textContent.trim();
                    row.querySelector('td:nth-child(3)').innerHTML = checkApprovedDate(approvedDate, collectionId, inspectionResult);
    
                    const completedDate = row.querySelector('td:nth-child(4)').textContent.trim();
                    row.querySelector('td:nth-child(4)').innerHTML = checkCompletedDate(completedDate);
    
                    const weight = row.querySelector('td:nth-child(5)').textContent.trim();
                    row.querySelector('td:nth-child(5)').innerHTML = checkWeight(weight, completedDate, approvedDate);
                });
            });
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
                                            <th>collectionId</th>
                                            <th>requestedDate</th>
                                            <th>approvedDate</th>
                                            <th>completedDate</th>
                                            <th>weight</th>
                                            <th>inspectionResult</th>
                                            <th>image</th>
                                            <th>resultImage</th>
                                            <th>userRealName</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>collectionId</th>
                                            <th>requestedDate</th>
                                            <th>approvedDate</th>
                                            <th>completedDate</th>
                                            <th>weight</th>
                                            <th>inspectionResult</th>
                                            <th>image</th>
                                            <th>resultImage</th>
                                            <th>userRealName</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <c:forEach var="collection" items="${collectionList}">
                                            <tr>
                                                <td>${collection.collectionId}</td>
                                                <td>${collection.requestedDate}</td>
                                                <td>${collection.approvedDate}</td>
                                                <td>${collection.completedDate}</td>
                                                <td>${collection.weight} kg</td>
                                                <td>${collection.inspectionResult}</td>
                                                <td>
                                                    <button type="button" class="btn btn-light" onclick="showModal(['${collection.image1}', '${collection.image2}', '${collection.image3}', '${collection.image4}'])">입력 이미지 보기</button>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-light" onclick="showModal(['${collection.resultImage1}', '${collection.resultImage2}', '${collection.resultImage3}', '${collection.resultImage4}'])">결과 이미지 보기</button>
                                                </td>
                                                <td>${collection.userRealName}</td>
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

        <!-- 모달 -->
        <div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="imageModalLabel">이미지 보기</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-6">
                                <img id="modalImage1" src="" class="img-fluid" />
                            </div>
                            <div class="col-6">
                                <img id="modalImage2" src="" class="img-fluid" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-6">
                                <img id="modalImage3" src="" class="img-fluid" />
                            </div>
                            <div class="col-6">
                                <img id="modalImage4" src="" class="img-fluid" />
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/static/js/admin/datatables-simple-demo.js"></script>
    </body>
</html>
