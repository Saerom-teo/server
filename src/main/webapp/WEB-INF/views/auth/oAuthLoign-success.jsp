<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 성공</title>
</head>
<body>
    <h1>로그인 성공</h1>
    <script>
        // URL에서 쿼리 파라미터를 추출합니다.
        const urlParams = new URLSearchParams(window.location.search);
        const token = urlParams.get('token');

        if (token) {
            // JWT 토큰을 로컬 스토리지에 저장합니다.
            localStorage.setItem("jwtToken", token);
            console.log("JWT 토큰이 로컬 스토리지에 저장되었습니다.");
            // 토큰 저장 후 리다이렉션 또는 다른 로직을 수행합니다.
            window.location.href = "/home";
        } else {
            console.log("JWT 토큰이 응답에 포함되지 않았습니다.");
        }
    </script>
</body>
</html>
