$(document).ready(function() {
    $('#userPassword').on('input', function() {
        var password = $(this).val();
        var lengthRegex = /.{8,16}/;
        var characterRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{1,}$/;

        // Check password length
        if (lengthRegex.test(password)) {
            $('.emailFormatText').addClass('valid');
            $('.check-icon').addClass('valid');
        } else {
            $('.emailFormatText').removeClass('valid');
            $('.check-icon').removeClass('valid');
        }

        // Check password complexity
        var complexityCount = 0;
        if (/[a-z]/.test(password)) complexityCount++;
        if (/[A-Z]/.test(password)) complexityCount++;
        if (/\d/.test(password)) complexityCount++;
        if (/[!@#$%^&*()\-_=+{};:,<.>]/.test(password)) complexityCount++;

        if (complexityCount >= 2) {
            $('.passwordFormatText').addClass('valid');
            $('.check-icon-password-CheckIcon').addClass('valid');
        } else {
            $('.passwordFormatText').removeClass('valid');
            $('.check-icon-password-CheckIcon').removeClass('valid');
        }

        // Check both conditions for enabling button
        if (lengthRegex.test(password) && complexityCount >= 2) {
            $('#submitBtn').addClass('active').attr('disabled', 'disabled');
        } else {
            $('#submitBtn').removeClass('active').removeAttr('disabled');
        }
    });

    $('#emailForm').on('submit', function(event) {
        event.preventDefault();
        var password = $('#userPassword').val();
        var lengthRegex = /.{8,16}/;
        var characterRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{1,}$/;

        if (lengthRegex.test(password) && characterRegex.test(password)) {
            // 유효한 비밀번호 처리
            alert('유효한 비밀번호입니다. 다음 페이지로 이동합니다.');
            window.location.href = '<%=request.getContextPath()%>/registration/passwordInput';
        } else {
            alert('비밀번호 형식이 올바르지 않습니다.');
        }
    });
});