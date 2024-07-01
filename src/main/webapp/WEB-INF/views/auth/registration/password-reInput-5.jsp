<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 재입력</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/emailInput.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
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
</script>
</head>
<body>
<div class="container">
    <div class="step-indicator">
        <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-1.svg">&nbsp;
        <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-2.svg">&nbsp;
        <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-3.svg">&nbsp;
        <img src="<%=request.getContextPath()%>/static/icon/registration-step/Gray-4.svg">&nbsp;
        <img src="<%=request.getContextPath()%>/static/icon/registration-step/Black-5.svg">&nbsp;
    </div>
    <div class="title">
        <h2>비밀번호 재입력(필수)</h2>
        <p>아래 칸에 입력하신 비밀번호를 입력 후 [다음] 버튼을 눌러주세요.</p>
    </div>
    <form id="passWordReInput">
        <div class="form-group">
            <label for="confirmPassword">비밀번호</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="비밀번호를 입력해 주세요">
        </div>
        <div class="btn-container">
            <button type="submit" class="btn actvie" id="submitBtn">다음</button>
        </div>
    </form>
    <div class="footer">
        <p>
            새롬터 | <a href="#">이용약관</a> | <a href="#">개인정보 처리 방침</a>
        </p>
        <p>SearomTae all rights reserved</p>
    </div>
</div>
</body>
</html>
