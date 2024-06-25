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
                localStorage.setItem('jwtToken', data);
                setCookie('jwtToken', data,1); 
                alert('로그인 성공');
                window.location.href = baseUrl + '/test/main';
            },
            error: function(xhr) {
                if (xhr.status === 401) {
                    alert(xhr.responseText); // Display the exception message
                } else {
                    alert('error 로그인 실패');
                    alert(xhr.data);
                }
            }
        });
    }

    $('#loginForm').submit(function(event) {
        event.preventDefault(); // 폼의 기본 제출 동작 막기
        login(); // 로그인 함수 호출
    });

       // 쿠키 설정 함수
    function setCookie(name, value, days) {
        var expires = "";
        if (days) {
            var date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            expires = "; expires=" + date.toUTCString();
        }
        document.cookie = name + "=" + (value || "") + expires + "; path=/";
    }


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
