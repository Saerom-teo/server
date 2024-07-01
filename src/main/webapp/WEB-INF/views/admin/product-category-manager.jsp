<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.2.3/js/bootstrap.bundle.min.js"></script>
    <link href="${pageContext.request.contextPath}/static/css/admin-styles.css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/static/js/admin/scripts.js"></script>
	<style>
	#addCategoryBtn {
		margin-left: 1000px;
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
                    <h1 class="mt-4">상품 카테고리 관리</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active">Tables</li>
                    </ol>
                    <div class="card mb-4">
                        <div class="card-body">상품 카테고리 관리 페이지입니다.</div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i> 카테고리 관리
                            <button class="btn btn-success" id="addCategoryBtn">카테고리 추가</button>
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                    <tr>
                                        <th>카테고리번호</th>
                                        <th>대분류</th>
                                        <th>중분류</th>
                                        <th>소분류</th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>카테고리번호</th>
                                        <th>대분류</th>
                                        <th>중분류</th>
                                        <th>소분류</th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <c:forEach var="category" items="${categoryList}">
                                        <tr>
                                            <td>${category.categoryNumber}</td>
                                            <td>${category.majorCategory}</td>
                                            <td>${category.middleCategory}</td>
                                            <td>${category.smallCategory}</td>
                                            <td><button type="button" class="btn btn-primary updateBtn" data-category-number="${category.categoryNumber}">수정</button></td>
                                            <td><button type="button" class="btn btn-danger deleteBtn"  data-category-number="${category.categoryNumber}">삭제</button></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- 카테고리 수정 모달창 -->
                    <div id="editModal" class="modal fade" tabindex="-1" role="dialog">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">카테고리 수정</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form id="editForm">
                                        <div class="form-group">
                                            <label for="editCategoryNumber">카테고리번호</label>
                                            <input type="text" class="form-control" id="editCategoryNumber" readonly>
                                        </div>
                                        <div class="form-group">
                                            <label for="editMajorCategory">대분류</label>
                                            <input type="text" class="form-control" id="editMajorCategory">
                                        </div>
                                        <div class="form-group">
                                            <label for="editMiddleCategory">중분류</label>
                                            <input type="text" class="form-control" id="editMiddleCategory">
                                        </div>
                                        <div class="form-group">
                                            <label for="editSmallCategory">소분류</label>
                                            <input type="text" class="form-control" id="editSmallCategory">
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
                    
                     <!-- 카테고리 추가 모달창 -->
                    <div id="addModal" class="modal fade" tabindex="-1" role="dialog">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">카테고리 추가</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form id="addForm">
                                        <div class="form-group">
                                            <label for="addMajorCategory">대분류</label>
                                            <input type="text" class="form-control" id="addMajorCategory">
                                        </div>
                                        <div class="form-group">
                                            <label for="addMiddleCategory">중분류</label>
                                            <input type="text" class="form-control" id="addMiddleCategory">
                                        </div>
                                        <div class="form-group">
                                            <label for="addSmallCategory">소분류</label>
                                            <input type="text" class="form-control" id="addSmallCategory">
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                                    <button type="button" class="btn btn-primary" id="addSaveBtn">저장</button>
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
                $('#editCategoryNumber').val(row.find('td:eq(0)').text().trim());
                $('#editMajorCategory').val(row.find('td:eq(1)').text().trim());
                $('#editMiddleCategory').val(row.find('td:eq(2)').text().trim());
                $('#editSmallCategory').val(row.find('td:eq(3)').text().trim());
                $('#editModal').modal('show');
            });

            // 저장 버튼 클릭 시
            $('#saveChangesBtn').click(function() {
                var categoryData = {
                    categoryNumber: $('#editCategoryNumber').val().trim(),
                    majorCategory: $('#editMajorCategory').val().trim(),
                    middleCategory: $('#editMiddleCategory').val().trim(),
                    smallCategory: $('#editSmallCategory').val().trim()
                };

                $.ajax({
                    url: "${pageContext.request.contextPath}/productcategory/updateCategory",
                    method: "PUT",
                    contentType: "application/json",
                    data: JSON.stringify(categoryData),
                    success: function(response) {
                        alert('카테고리 정보가 수정되었습니다.');
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
                var categoryNumber = $(this).data('category-number');

                if (confirm('정말 삭제하시겠습니까?')) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/productcategory/deleteCategory/" + categoryNumber,
                        method: "DELETE",
                        success: function(response) {
                            alert('카테고리가 삭제되었습니다.');
                            location.reload();
                        },
                        error: function(xhr, status, error) {
                            console.error("AJAX 호출 중 오류 발생:", status, error);
                            alert('카테고리 삭제 중 오류가 발생했습니다.');
                        }
                    });
                }
            });
            
            // 카테고리 추가 버튼 클릭 시
            $('#addCategoryBtn').click(function() {
                $('#addModal').modal('show');
            });

            // 추가 모달의 저장 버튼 클릭 시
            $('#addSaveBtn').click(function() {
                var newCategoryData = {
                    majorCategory: $('#addMajorCategory').val().trim(),
                    middleCategory: $('#addMiddleCategory').val().trim(),
                    smallCategory: $('#addSmallCategory').val().trim()
                };

                $.ajax({
                    url: "${pageContext.request.contextPath}/productcategory/insertCategory",
                    method: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(newCategoryData),
                    success: function(response) {
                        alert('새 카테고리가 추가되었습니다.');
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
