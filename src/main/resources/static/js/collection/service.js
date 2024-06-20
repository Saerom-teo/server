function sendRegistData(formData) {
    $.ajax({
        url: '../api/collection/registration',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(formData),
        success: function(response) {
            window.location.href = 'regist-complete';
        },
        error: function(xhr, status, error) {
            alert('신청 중 오류가 발생했습니다. 다시 시도해 주세요.');
        }
    });
}

function sendRequestData(formData) {
    $.ajax({
        url: 'http://localhost:9090/app/api/collection/request',
        type: 'POST',
        data: formData,
        contentType: false,  // 변경된 부분
        processData: false,  // 변경된 부분
        success: function(response) {
            window.location.href = 'regist-complete.html';
        },
        error: function(xhr, status, error) {
            alert('신청 중 오류가 발생했습니다. 다시 시도해 주세요.');
        }
    });
}