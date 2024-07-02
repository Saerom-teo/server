$(document).ready(function() {
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
