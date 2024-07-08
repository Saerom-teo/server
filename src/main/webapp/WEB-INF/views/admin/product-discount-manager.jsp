<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>할인관리 | 새롬터</title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<script
	src="${pageContext.request.contextPath}/static/js/admin/datatables-simple-demo.js"></script>

<link
	href="${pageContext.request.contextPath}/static/css/admin-styles.css"
	rel="stylesheet" />
<script
	src="${pageContext.request.contextPath}/static/js/admin/scripts.js"></script>
<style>
#addDiscountBtn {
	margin-left: 1050px;
}
</style>
</head>

<body class="sb-nav-fixed">
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-primary"
		id="nav-bar">
		<%@ include file="/WEB-INF/views/admin/nav.jsp"%>
	</nav>
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<%@ include file="/WEB-INF/views/admin/side-nav.jsp"%>
		</div>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">상품 할인 관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
						<li class="breadcrumb-item active">Tables</li>
					</ol>
					<div class="card mb-4">
						<div class="card-body">상품 할인 관리 페이지입니다.</div>
					</div>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i> 할인 관리
							<button class="btn btn-success" id="addDiscountBtn">할인 정보 추가</button>
						</div>

						<div class="card-body">

							<table id="datatablesSimple">

								<thead>
									<tr>
										<th>할인번호</th>
										<th>할인율</th>
										<th>할인시작일</th>
										<th>할인종료일</th>
										<th>할인명</th>
										<th></th>
										<th></th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<th>할인번호</th>
										<th>할인율</th>
										<th>할인시작일</th>
										<th>할인종료일</th>
										<th>할인명</th>
										<th></th>
										<th></th>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach var="discount" items="${discountList}">
										<tr>
											<th>${discount.discountCode}</th>
											<th>${discount.discountRate}</th>
											<th>${discount.discountStart}</th>
											<th>${discount.discountEnd}</th>
											<th>${discount.discountName}</th>
											 <td><button type="button" class="btn btn-primary updateBtn" data-discount-code="${discount.discountCode}">수정</button></td>
                                            <td><button type="button" class="btn btn-danger deleteBtn" data-discount-code="${discount.discountCode}">삭제</button></td>
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
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; Your Website 2023</div>
						<div>
							<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
								&amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>
	<!-- 수정 모달창 -->
	 <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">할인 수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editForm">
                        <div class="mb-3">
                            <label for="editDiscountCode" class="form-label">할인번호</label>
                            <input type="text" class="form-control" id="editDiscountCode" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="editDiscountRate" class="form-label">할인율</label>
                            <input type="text" class="form-control" id="editDiscountRate">
                        </div>
                        <div class="mb-3">
                            <label for="editDiscountStart" class="form-label">할인시작일</label>
                            <input type="date" class="form-control" id="editDiscountStart">
                        </div>
                        <div class="mb-3">
                            <label for="editDiscountEnd" class="form-label">할인종료일</label>
                            <input type="date" class="form-control" id="editDiscountEnd">
                        </div>
                        <div class="mb-3">
                            <label for="editDiscountName" class="form-label">할인명</label>
                            <input type="text" class="form-control" id="editDiscountName">
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
    
      <!-- 추가 모달창 -->
    <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addModalLabel">할인 추가</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addForm">
                        <div class="mb-3">
                            <label for="addDiscountRate" class="form-label">할인율</label>
                            <input type="text" class="form-control" id="addDiscountRate">
                        </div>
                        <div class="mb-3">
                            <label for="addDiscountStart" class="form-label">할인시작일</label>
                            <input type="date" class="form-control" id="addDiscountStart">
                        </div>
                        <div class="mb-3">
                            <label for="addDiscountEnd" class="form-label">할인종료일</label>
                            <input type="date" class="form-control" id="addDiscountEnd">
                        </div>
                        <div class="mb-3">
                            <label for="addDiscountName" class="form-label">할인명</label>
                            <input type="text" class="form-control" id="addDiscountName">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" id="addSaveBtn">추가</button>
                </div>
            </div>
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
	 <script>
        $(document).ready(function() {
            // 수정 버튼 클릭 시
            $(document).on('click', '.updateBtn', function() {
                var row = $(this).closest('tr');
                $('#editDiscountCode').val(row.find('td:eq(0)').text().trim());
                $('#editDiscountRate').val(row.find('td:eq(1)').text().trim());
                $('#editDiscountStart').val(row.find('td:eq(2)').text().trim());
                $('#editDiscountEnd').val(row.find('td:eq(3)').text().trim());
                $('#editDiscountName').val(row.find('td:eq(4)').text().trim());
                $('#editModal').modal('show');
            });

            // 저장 버튼 클릭 시
            $('#saveChangesBtn').click(function() {
                var discountData = {
                    discountCode: $('#editDiscountCode').val().trim(),
                    discountRate: $('#editDiscountRate').val().trim(),
                    discountStart: $('#editDiscountStart').val().trim(),
                    discountEnd: $('#editDiscountEnd').val().trim(),
                    discountName: $('#editDiscountName').val().trim()
                };

                $.ajax({
                    url: "${pageContext.request.contextPath}/discount/updateDiscount",
                    method: "PUT",
                    contentType: "application/json",
                    data: JSON.stringify(discountData),
                    success: function(response) {
                        alert('할인 정보가 수정되었습니다.');
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
                var discountCode = $(this).data('discount-code');
                if (confirm('정말 삭제하시겠습니까?')) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/discount/deleteDiscount/" + discountCode,
                        method: "DELETE",
                        success: function(response) {
                            alert('할인이 삭제되었습니다.');
                            location.reload();
                        },
                        error: function(xhr, status, error) {
                            console.error("AJAX 호출 중 오류 발생:", status, error);
                            alert('할인 삭제 중 오류가 발생했습니다.');
                        }
                    });
                }
            });
            
         	// 추가 버튼 클릭 시 모달 표시
            $('#addDiscountBtn').click(function() {
                $('#addModal').modal('show');
            });

            // 추가 모달에서 저장 버튼 클릭 시
            $('#addSaveBtn').click(function() {
                var newDiscountData = {
                    discountRate: $('#addDiscountRate').val().trim(),
                    discountStart: $('#addDiscountStart').val().trim(),
                    discountEnd: $('#addDiscountEnd').val().trim(),
                    discountName: $('#addDiscountName').val().trim()
                };

                $.ajax({
                    url: "${pageContext.request.contextPath}/discount/insertDiscount",
                    method: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(newDiscountData),
                    success: function(response) {
                        alert('할인 항목이 추가되었습니다.');
                        $('#addModal').modal('hide');
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX 호출 중 오류 발생:", status, error);
                    }
                });
            });
            

        });
    </script>
</body>

</html>