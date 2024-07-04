$(document).ready(function() {
    var approvePendingCount = 0;
    var completePendingCount = 0;
    var weightInputPendingCount = 0;

    function createRow(item) {
        var inspectionResultText = item.inspectionResult ? 
            (item.inspectionResult === 'clear' ? '통과' : (item.inspectionResult === 'deny' ? '거부' : item.inspectionResult)) : '검사중';
        var inspectionResultStyle = (item.inspectionResult === 'clear') ? 'color: green;' : (item.inspectionResult === 'deny') ? 'color: red;' : '';

        var approvedText = item.approvedDate ? '<button class="btn btn-light btn-sm" disabled>승인됨</button>' : 
            (item.inspectionResult === 'clear' && item.collectionStatus) ? '<button class="btn btn-success btn-sm approve-btn" data-id="' + item.collectionId + '" data-name="' + item.userRealName + '">승인</button>' : '';

        if (!item.approvedDate && item.inspectionResult === 'clear' && item.collectionStatus) {
            approvePendingCount++;
        }

        // 수거 완료 버튼을 승인 상태에 따라 조건부로 표시
        var completedText = item.approvedDate ? 
            (item.completedDate ? '<button class="btn btn-light btn-sm" disabled>완료됨</button>' : '<button class="btn btn-primary btn-sm complete-btn" data-id="' + item.collectionId + '">완료</button>') 
            : '';

        if (item.approvedDate && !item.completedDate) {
            completePendingCount++;
        }

        // 무게 입력란을 완료 상태에 따라 조건부로 표시
        var weightInput = item.completedDate ? 
            (item.weight ? item.weight : '<input type="number" class="form-control form-control-sm weight-input" data-id="' + item.collectionId + '" placeholder="무게 입력" />')
            : '';

        if (item.completedDate && !item.weight) {
            weightInputPendingCount++;
        }

        var collectionStatusText = item.collectionStatus ? '' : '<span class="status-cancelled">취소</span>';

        return '<tr>' +
            '<td>' + item.collectionId + '</td>' +
            '<td>' + item.userRealName + '</td>' +
            '<td>' + new Date(item.requestedDate).toLocaleDateString() + '</td>' +
            '<td>' + '<a style="' + inspectionResultStyle + '">' + inspectionResultText + '</a>' + '</td>' +
            '<td>' + collectionStatusText + '</td>' +
            '<td>' + approvedText + '</td>' +
            '<td>' + completedText + '</td>' +
            '<td>' + weightInput + '</td>' +
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

        // 승인 대기, 완료 대기, 무게 입력 대기 개수 업데이트
        $('#approvePendingCount').text(approvePendingCount);
        $('#completePendingCount').text(completePendingCount);
        $('#weightInputPendingCount').text(weightInputPendingCount);
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
        var userName = $(this).data('name');
        var currentTime = new Date().toLocaleString();
        
        // 승인 여부를 확인하는 알림 창
        var confirmApproval = confirm(userName + '님의 요청을 승인하시겠습니까?');

        if (confirmApproval) {
            // 승인 처리 AJAX 요청
            $.ajax({
                url: '../api/collection/approve',
                method: 'GET',
                data: { collectionId: collectionId },
                success: function(response) {
                    // 승인 후 알림 창을 표시
                    alert(userName + '님의 요청이 ' + currentTime + '에 승인되었습니다.');

                    // 페이지 새로고침
                    location.reload();
                },
                error: function(xhr, status, error) {
                    console.error('Error approving collection:', error);
                    alert('승인 처리 중 오류가 발생했습니다.');
                }
            });
        }
    });

    // 완료 버튼 클릭 이벤트 핸들러
    $(document).on('click', '.complete-btn', function() {
        var collectionId = $(this).data('id');
        var userName = $(this).data('name');
        var currentTime = new Date().toLocaleString();
        
        // 완료 여부를 확인하는 알림 창
        var confirmCompletion = confirm('수거를 완료하시겠습니까?');

        if (confirmCompletion) {
            // 완료 처리 AJAX 요청
            $.ajax({
                url: '../api/collection/complete',
                method: 'GET',
                data: { collectionId: collectionId },
                success: function(response) {
                    // 완료 후 알림 창을 표시
                    alert('수거가 ' + currentTime + '에 완료되었습니다.');

                    // 페이지 새로고침
                    location.reload();
                },
                error: function(xhr, status, error) {
                    console.error('Error completing collection:', error);
                    alert('완료 처리 중 오류가 발생했습니다.');
                }
            });
        }
    });

    // 무게 입력 이벤트 핸들러
    $(document).on('keypress', '.weight-input', function(e) {
        if (e.which === 13) { // Enter 키를 누를 때
            e.preventDefault();
            var collectionId = $(this).data('id');
            var weight = $(this).val();
            
            // 무게 확인 여부를 묻는 알림 창
            var confirmWeight = confirm(weight + ' kg를 입력하시겠습니까?');

            if (confirmWeight) {
                // 무게 저장 AJAX 요청
                $.ajax({
                    url: '../api/collection/input-weight',
                    method: 'GET',
                    data: { collectionId: collectionId, weight: weight },
                    success: function(response) {
                        // 무게 저장 후 페이지 새로고침
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        console.error('Error saving weight:', error);
                        alert('무게 저장 중 오류가 발생했습니다.');
                    }
                });
            }
        }
    });
});
