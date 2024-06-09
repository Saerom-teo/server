$(document).ready(function() {
    
    function login() {
        var email = $('input[name="userEmail"]').val();
        var password = $('input[name="userPassword"]').val();
		console.log(password);
        $.ajax({
            url: 'login',
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
    
    
    function googleLogin(){
    
    }
    
    function kakaoLogin(){
    
    }
    function signUp(){
    
    }
    
    function findUserInfo(){
    
    }
    
    
});
