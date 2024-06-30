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
    <title>Dashboard - SB Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
     <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.2.3/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/admin/datatables-simple-demo.js"></script>
    <link href="${pageContext.request.contextPath}/static/css/admin-styles.css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/static/js/admin/scripts.js"></script>
    <style></style>
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
                    <ol class="breadcrumb mb=4">
                        <li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active">Tables</li>
                    </ol>
                    <div class="card mb-4">
                        <div class="card-body">상품 관리 관리자 페이지.</div>
                    </div>
                    <button class="btn btn-success" style="margin-bottom: 10px; margin-left: 1000px;">상품 추가</button>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i> 상품 관리
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
                                            <td>${product.productCode}</td>
                                            <td>${product.productName}</td>
                                            <td>${product.productPrice}</td>
                                            <td>${product.stockQuantity}</td>
                                            <td>${product.registrationDate}</td>
                                            <td>${product.envMark}</td>
                                            <td>${product.thumbnail}</td>
                                            <td>${product.detailImage}</td>
                                            <td>${product.categoryNumber}</td>
                                            <td>${product.discountCode}</td>
                                            <td><button type="button" class="btn btn-primary updateBtn" style="height: 40px; width: 58px;" data-product-code="${product.productCode}">수정</button></td>
                                            <td><button type="button" class="btn btn-danger deleteBtn" style="height: 40px; width: 58px;" data-product-code="${product.productCode}">삭제</button></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- 상품 수정 모달창 -->
                    <div id="editModal" class="modal fade" tabindex="-1" role="dialog">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                   <h5 class="modal-title">상품 수정</h5>
                                   <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form id="editForm">
                                        <div class="form-group">
                                            <label for="editProductCode">상품번호</label>
                                            <input type="text" class="form-control" id="editProductCode" readonly>
                                        </div>
                                        <div class="form-group">
                                            <label for="editProductName">상품명</label>
                                            <input type="text" class="form-control" id="editProductName">
                                        </div>
                                        <div class="form-group">
                                            <label for="editProductPrice">가격</label>
                                            <input type="text" class="form-control" id="editProductPrice">
                                        </div>
                                        <div class="form-group">
                                            <label for="editStockQuantity">재고수량</label>
                                            <input type="text" class="form-control" id="editStockQuantity">
                                        </div>
                                        <div class="form-group">
                                            <label for="editRegistrationDate">등록날짜</label>
                                            <input type="text" class="form-control" id="editRegistrationDate">
                                        </div>
                                        <div class="form-group">
                                            <label for="editEnvMark">환경인증마크</label>
                                            <input type="text" class="form-control" id="editEnvMark">
                                        </div>
                                        <div class="form-group">
                                            <label for="editThumbnail">썸네일이미지</label>
                                            <input type="text" class="form-control" id="editThumbnail">
                                        </div>
                                        <div class="form-group">
                                            <label for="editDetailImage">상세이미지</label>
                                            <input type="text" class="form-control" id="editDetailImage">
                                        </div>
                                        <div class="form-group">
                                            <label for="editCategoryNumber">카테고리번호</label>
                                            <input type="text" class="form-control" id="editCategoryNumber">
                                        </div>
                                        <div class="form-group">
                                            <label for="editDiscountCode">할인코드</label>
                                            <input type="text" class="form-control" id="editDiscountCode">
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                   <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                                    <button type="button" class="btn btn-primary" id="saveChangesBtn">저장</button>
                                </div>
                            </div>
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
    <script>
        $(document).ready(function() {
            // 수정 버튼 클릭 시
            $(document).on('click', '.updateBtn', function() {
                var row = $(this).closest('tr');
                $('#editProductCode').val(row.find('td:eq(0)').text().trim());
                $('#editProductName').val(row.find('td:eq(1)').text().trim());
                $('#editProductPrice').val(row.find('td:eq(2)').text().trim());
                $('#editStockQuantity').val(row.find('td:eq(3)').text().trim());
                $('#editRegistrationDate').val(row.find('td:eq(4)').text().trim());
                $('#editEnvMark').val(row.find('td:eq(5)').text().trim());
                $('#editThumbnail').val(row.find('td:eq(6)').text().trim());
                $('#editDetailImage').val(row.find('td:eq(7)').text().trim());
                $('#editCategoryNumber').val(row.find('td:eq(8)').text().trim());
                $('#editDiscountCode').val(row.find('td:eq(9)').text().trim());
                $('#editModal').modal('show');
            });

            // 저장 버튼 클릭 시
            $('#saveChangesBtn').click(function() {
                var productData = {
                    productCode: $('#editProductCode').val().trim(),
                    productName: $('#editProductName').val().trim(),
                    productPrice: $('#editProductPrice').val().trim(),
                    stockQuantity: $('#editStockQuantity').val().trim(),
                    registrationDate: $('#editRegistrationDate').val().trim(),
                    envMark: $('#editEnvMark').val().trim(),
                    thumbnail: $('#editThumbnail').val().trim(),
                    detailImage: $('#editDetailImage').val().trim(),
                    categoryNumber: $('#editCategoryNumber').val().trim(),
                    discountCode: $('#editDiscountCode').val().trim()
                };

                $.ajax({
                    url: "${pageContext.request.contextPath}/products/updateProduct",
                    method: "PUT",
                    contentType: "application/json",
                    data: JSON.stringify(productData),
                    success: function(response) {
                        alert('상품 정보가 수정되었습니다.');
                        $('#editModal').modal('hide');
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX 호출 중 오류 발생:", status, error);
                    }
                });
            });
            
            // 삭제 버튼 클릭 시
            $(document).on('click', '.deleteBtn', function() {
                if (confirm('정말 삭제하시겠습니까?')) {
                    var productCode = $(this).data('product-code');
                    
                    $.ajax({
                        url: "${pageContext.request.contextPath}/products/deleteProduct/" + productCode,
                        method: "DELETE",
                        success: function(response) {
                            alert('상품이 삭제되었습니다.');
                            window.location.href = "/app/admin/product-manager"
                        },
                        error: function(xhr, status, error) {
                            console.error("AJAX 호출 중 오류 발생:", status, error);
                        }
                    });
                }
            });

            // 모달 닫기 버튼 
            $('#editModal').on('hidden.bs.modal', function () {
                // 폼을 초기화하거나 기타 필요한 작업 수행
                $('#editForm')[0].reset();
            });
        });
    </script>
</body>
</html>
