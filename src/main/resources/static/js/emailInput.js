$(document).ready(function() {
    $('#userEmail').on('input', function(event) {
        const emailInput = $(this);
        const emailValue = emailInput.val();
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const emailFormatText = $('#emailFormatText');
        const emailCheckIcon = $('#emailCheckIcon');
        const submitBtn = $('#submitBtn');

        if (emailPattern.test(emailValue)) {
            emailFormatText.addClass('valid');
            emailCheckIcon.addClass('valid');
            submitBtn.addClass('active');
            submitBtn.prop('disabled', false);
        } else {
            emailFormatText.removeClass('valid');
            emailCheckIcon.removeClass('valid');
            submitBtn.removeClass('active');
            submitBtn.prop('disabled', true);
        }
    });

    $('#emailForm').on('submit', function(event) {
        event.preventDefault(); // 기본 폼 제출 막기

        const emailInput = $('#userEmail');
        const emailValue = emailInput.val();
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!emailPattern.test(emailValue)) {
            alert("유효한 이메일 형식을 입력해 주세요.");
            return;
        }

        $.ajax({
            url: 'checkEmailDuplicate',
            type: 'POST',
            data: { userEmail: emailValue },
            success: function(response) {
                if (response === 'existing_user') {
                    alert("이미 존재하는 이메일입니다. 로그인 페이지로 이동합니다.");
                    $('<form>', {
                        "method": "get",
                        "action": baseURL + '/auth/login'
                    }).appendTo(document.body).submit();
                } else if (response === 'new_user') {
                    $('<form>', {
                        "method": "post",
                        "action": 'verification'
                    }).append($('<input>', {
                        "type": "hidden",
                        "name": "userEmail",
                        "value": emailValue
                    })).appendTo(document.body).submit();
                } else {
                    alert("잘못된 접근입니다.");
                    $('<form>', {
                        "method": "get",
                        "action": baseURL + '/auth/login'
                    }).appendTo(document.body).submit();
                }
            },
            error: function(xhr, status, error) {
                console.log(xhr.responseText); // 디버깅을 위한 로그
                alert("서버와 통신 중 오류가 발생했습니다.");
            }
        });
    });
});
