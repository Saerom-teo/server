$(document).ready(function() {
    $('#emailForm').on('submit', function(event) {
        event.preventDefault(); // 폼의 기본 제출 동작을 막음
        var userEmail = $('#userEmail').val();
        $.ajax({
            type: 'POST',
            url: baseUrl + '/auth/userVerificationProcess',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({ userEmail: userEmail }),
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    alert(response.message); // 성공 메시지
                    var postForm = $('<form>', {
                        'action': baseUrl + '/auth/reset-email-verification',
                        'method': 'POST'
                    }).append($('<input>', {
                        'type': 'hidden',
                        'name': 'userEmail',
                        'value': userEmail
                    }));

                    // 폼을 현재 문서에 추가하고 제출
                    postForm.appendTo('body').submit();
                } else {
                    alert(response.message); // 에러 메시지
                }
            },
            error: function(xhr, status, error) {
                if (xhr.status === 400) {
                    alert('가입된 이메일이 없습니다.');
                }else{
                    alert('서버 오류가 발생했습니다. 다시 시도해 주세요.');
                }
            }
        });
    });

    $('#userEmail').on('input', function() {
        var email = $(this).val();
        const emailFormatText = $('#emailFormatText');
        const emailCheckIcon = $('#check-icon');
        var emailFormat = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // 간단한 이메일 형식 체크
        const submitBtn = $('#submitBtn');
        if (emailFormat.test(email)) {
            $('#emailFormatText').text('올바른 이메일 형식입니다.');
            emailFormatText.addClass('valid');
            emailCheckIcon.addClass('valid');
            submitBtn.removeClass('disabled').addClass('active').prop('disabled', false);
        } else {
            $('#emailFormatText').text('이메일 형식이 올바르지 않습니다.');
            emailFormatText.removeClass('valid');
            emailCheckIcon.removeClass('valid');
            submitBtn.removeClass('active').addClass('disabled').prop('disabled', true);
        }
    });
});