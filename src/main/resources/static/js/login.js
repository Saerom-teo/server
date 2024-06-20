$(document).ready(function() {
    
    function login() {
        var email = $('input[name="userEmail"]').val();
        var password = $('input[name="userPassword"]').val();
        $.ajax({
            url: 'loginProcess',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ userEmail: email, userPassword: password }),
            success: function(data) {
                if (data.token) {
                    localStorage.setItem('jwtToken', data.token);
                    alert('로그인 성공');
                } else {
                    alert('로그인 실패');
                }
            },
            error: function(xhr) {
                if (xhr.status === 401) {
                    alert(xhr.responseText); // Display the exception message
                } else {
                    alert('로그인 실패');
                }
            }
        });
    }

    $('#loginForm').submit(function(event) {
        event.preventDefault(); // 폼의 기본 제출 동작 막기
        login(); // 로그인 함수 호출
    });

    const borderColor = '#499268'; // 지정된 색상 정의

    function validateEmail(email) {
        const re = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return re.test(String(email).toLowerCase());
    }

    function checkEmail($element) {
        const errorMessage = $('#emailError');
        if (validateEmail($element.val())) {
            $element.addClass('valid-email').css('borderColor', borderColor);
            errorMessage.hide();
        } else {
            $element.removeClass('valid-email').css('borderColor', '#ddd');
            errorMessage.show();
        }
    }

    function checkInput($element) {
        const errorMessage = $('#passwordError');
        if ($element.val().trim() !== '') {
            $element.css('borderColor', borderColor);
            errorMessage.hide();
        } else {
            $element.css('borderColor', '#ddd');
            errorMessage.show();
        }
    }

    $('input[name="userEmail"]').on('input', function() {
        checkEmail($(this));
    });

    $('input[name="userPassword"]').on('input', function() {
        checkInput($(this));
    });
});
