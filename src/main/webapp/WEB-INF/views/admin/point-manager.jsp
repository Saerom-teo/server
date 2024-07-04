<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        .status-cancelled {
            color: red;
        }
        .card-custom {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .card-custom .card-body {
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        .card-custom .card-body .text {
            font-size: 1rem;
            margin-right: 10px;
        }
        .card-custom .card-body .count {
            font-size: 1.5rem;
            font-weight: bold;
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
                    <h1 class="mt-4">포인트 관리</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active">Tables</li>
                    </ol>
                    <div class="card mb-4">
                        <div class="card-body">
                            포인트 관리 페이지 입니다.
                        </div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            전체 포인트 내역
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>이름</th>
                                        <th>일자</th>
                                        <th>타입</th>
                                        <th>포인트</th>
                                        <th>경로</th>
                                        <th>코멘트</th>
                                        <th>액션</th>
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

    <!-- 부트스트랩 모달 -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">포인트 수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editForm">
                        <input type="hidden" id="editPointId">
                        <div class="mb-3">
                            <label for="editUserRealName" class="form-label">이름</label>
                            <input type="text" class="form-control" id="editUserRealName" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="editDateIssued" class="form-label">일자</label>
                            <input type="text" class="form-control" id="editDateIssued" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="editType" class="form-label">타입</label>
                            <input type="text" class="form-control" id="editType" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="editAmount" class="form-label">포인트</label>
                            <input type="number" class="form-control" id="editAmount">
                        </div>
                        <div class="mb-3">
                            <label for="editSource" class="form-label">경로</label>
                            <input type="text" class="form-control" id="editSource">
                        </div>
                        <div class="mb-3">
                            <label for="editComment" class="form-label">코멘트</label>
                            <input type="text" class="form-control" id="editComment">
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>

    <script>
        $(document).ready(function() {
            // 데이터 불러오기
            $.ajax({
                url: '../api/point/read-all',
                type: 'GET',
                success: function(data) {
                    // 데이터 가공 및 테이블에 추가
                    const tableBody = $('#datatablesSimple tbody');
                    data.forEach(point => {
                        const date = new Date(point.dateIssued).toLocaleDateString();
                        const type = point.type === 'earned' ? '획득' : '사용';
                        const amount = point.type === 'spent' ? '-' + point.amount : point.amount;
                        const source = point.earningSource ? point.earningSource : point.spendingSource;
                        const comment = point.comment ? point.comment : '';

                        const row = `<tr>
                            <td>\${point.pointId}</td>
                            <td>\${point.userRealName}</td>
                            <td>\${date}</td>
                            <td>\${type}</td>
                            <td>\${amount}</td>
                            <td>\${source}</td>
                            <td>\${comment}</td>
                            <td>
                                <button class="btn btn-primary btn-sm edit-btn" data-id="\${point.pointId}">수정</button>
                                <button class="btn btn-danger btn-sm delete-btn" data-id="\${point.pointId}">삭제</button>
                            </td>
                        </tr>`;
                        
                        tableBody.append(row);
                    });

                    // DataTable 초기화
                    new simpleDatatables.DataTable("#datatablesSimple");

                    // 수정 버튼 클릭 이벤트 핸들러
                    $('.edit-btn').click(function() {
                        const id = $(this).data('id');
                        const point = data.find(p => p.pointId == id);
                        \$('#editPointId').val(point.pointId);
                        \$('#editUserRealName').val(point.userRealName);
                        \$('#editDateIssued').val(new Date(point.dateIssued).toLocaleDateString());
                        \$('#editType').val(point.type === 'earned' ? '획득' : '사용');
                        \$('#editAmount').val(point.amount);
                        \$('#editSource').val(point.earningSource ? point.earningSource : point.spendingSource);
                        \$('#editComment').val(point.comment ? point.comment : '');

                        $('#editModal').modal('show');
                    });

                    // 삭제 버튼 클릭 이벤트 핸들러
                    $('.delete-btn').click(function() {
                        const id = $(this).data('id');
                        if(confirm('정말로 삭제하시겠습니까?')) {
                            $.ajax({
                                url: '../api/point/delete/' + id,
                                type: 'DELETE',
                                success: function(response) {
                                    alert(response);
                                    location.reload();
                                },
                                error: function(error) {
                                    console.error('Error deleting point:', error);
                                    alert('삭제 중 오류가 발생했습니다.');
                                }
                            });
                        }
                    });

                    // 저장 버튼 클릭 이벤트 핸들러
                    $('#saveChangesBtn').click(function() {
                        const id = \$('#editPointId').val();
                        const updatedPoint = {
                            pointId: id,
                            amount: \$('#editAmount').val(),
                            source: \$('#editSource').val(),
                            comment: \$('#editComment').val()
                        };
                        
                        $.ajax({
                            url: '../api/point/update',
                            type: 'PUT',
                            contentType: 'application/json',
                            data: JSON.stringify(updatedPoint),
                            success: function(response) {
                                alert('수정이 완료되었습니다.');
                                location.reload();
                            },
                            error: function(error) {
                                console.error('Error updating point:', error);
                                alert('수정 중 오류가 발생했습니다.');
                            }
                        });

                        \$('#editModal').modal('hide');
                    });
                },
                error: function(error) {
                    console.error("Error fetching data:", error);
                }
            });
        });
    </script>
</body>
</html>
