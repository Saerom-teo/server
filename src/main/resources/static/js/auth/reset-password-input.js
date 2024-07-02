$(document).ready(function() {
    $('#submitBtn').on('click', function(event) {
        event.preventDefault();

        var confirmPassword = $('#confirmPassword').val();
        var baseUrl = window.location.origin + '<%=request.getContextPath()%>';

        $.ajax({
            type: 'POST',
            url:  'password-check',
            contentType: 'application/json',
            data: JSON.stringify({
                confirmPassword: confirmPassword
            }),
            success: function(response) {
                if (response.status === 'success') {
                    alert(response.message);
                    window.location.href = baseUrl + '/auth/login';
                } else {
                    alert(response.message);
                }
            },
            error: function(xhr, status, error) {
                alert('서버 오류가 발생했습니다. 다시 시도해 주세요.');
            }
        });
    });
});