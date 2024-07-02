$(document).ready(function() {

    const form = document.getElementById("passwordForm");

    // 폼 제출 이벤트 리스너 추가
    form.addEventListener("submit", function(event) {
        // 폼 데이터 가져오기
        var password = document.getElementById("userPassword").value;

        // 폼의 action 속성 변경
        form.action = baseUrl + '/auth/reset-password-reinput';

        // 폼 제출
        form.submit();
    });

    $('#userPassword').on('input', function() {
        var password = $(this).val();
        var lengthRegex = /.{8,16}/;
        var characterRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{1,}$/;

        var isLengthValid = lengthRegex.test(password);
        var isComplexityValid = characterRegex.test(password);

        // Check password length
        if (isLengthValid) {
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
        if (isLengthValid && complexityCount >= 2) {
            $('#submitBtn').addClass('active').removeAttr('disabled');
        } else {
            $('#submitBtn').removeClass('active').attr('disabled', 'disabled');
        }
    });
});
