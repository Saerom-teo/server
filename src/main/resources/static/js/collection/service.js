// 폼 데이터를 서버로 전송하는 함수
function sendFormData(formData) {
    $.ajax({
        url: '../api/collection/registration', // 서버 엔드포인트 URL
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(formData),
        success: function(response) {
            window.location.href = 'regist-complete';
        },
        error: function(xhr, status, error) {
            alert('신청 중 오류가 발생했습니다. 다시 시도해 주세요.');
            // 오류 시 처리 로직
        }
    });
}
