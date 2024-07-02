<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 재입력</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/auth/emailInput.css">
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
		<%@ include file="/WEB-INF/views/auth/auth-footer.jsp"%>
</div>
</body>
</html>
