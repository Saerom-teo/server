<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">

<body>
    <div class="header">
        <div class="header-container">
        	<a href="../test/main">
            	<img id="logo" src="${pageContext.request.contextPath}/static/icon/logo.svg">
            </a>
    
            <div id="header-collection">
                <a  href="${pageContext.request.contextPath}/collection/intro">플라스틱<br>수거</a>
            </div>
            <div id="header-shop">
                <a  href="#">친환경<br>장터</a>
            </div>
            <div id="header-community">
                <a  href="#">친환경<br>커뮤니티</a>
            </div>
            <div class="search">
                <input type="text">
                <img src="${pageContext.request.contextPath}/static/icon/search.svg">
            </div>
            <div>
                <img src="${pageContext.request.contextPath}/static/icon/zzim.svg">
            </div>
            <div>
                <img src="${pageContext.request.contextPath}/static/icon/basket.svg">
            </div>
            <div>
                <img src="${pageContext.request.contextPath}/static/icon/notice.svg">
            </div>
            <div>
                <img src="${pageContext.request.contextPath}/static/icon/user.svg">
            </div>
        </div>
    </div>
</body>

</html>