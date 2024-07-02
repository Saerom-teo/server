$(document).ready(function() {
    $('#submitBtn').on('click', function(event) {
        event.preventDefault();
        var confirmPassword = $('#confirmPassword').val();
        $.ajax({
            type: 'POST',
            url:  baseUrl + '/auth/registration/password-check',
            contentType: 'application/json',
            data: JSON.stringify({
                confirmPassword: confirmPassword
            }),
            success: function(response) {
                if (response.status === 'success') {
                    alert(response.message);
                    window.location.href = baseUrl + '/auth/login';
                } else if((response.status === 'error')) {
                    alert(response.message);
                }
            },
            error: function(xhr, status, error) {
                if (xhr.status === 400) {
                    alert('비밀번호가 일치하지 않습니다.');
                } else if (xhr.status === 500) {
                    alert('서버 오류가 발생했습니다. 다시 시도해 주세요.');
                } else {
                    alert(xhr.responseText); // 서버에서 내려온 상세 오류 메시지 출력
                }
            }
        });
    });
});