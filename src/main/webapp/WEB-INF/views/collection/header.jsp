<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/js/regular.min.js"/>
<script src="https://kit.fontawesome.com/5c80af90fe.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/static/js/style.js"></script>
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
                <img id="user-icon" src="${pageContext.request.contextPath}/static/icon/user.svg">
            </div>
        </div>
    </div>
    
    <!-- 토글 박스 -->
    <div class="toggle-box">
        <!-- 여기에 원하는 내용을 추가하세요 -->
    	<div class="mypage-head">
	        <img class="mypage-image" src="${pageContext.request.contextPath}/static/icon/mypage-profile.svg">
	        <div class="mypage-info">
		        <div class="mypage-info-set">
		        	<p class="mypage-info-nickname">닉네임</p><img src="${pageContext.request.contextPath}/static/icon/mypage-toggle/chevron-right.svg">
		        </div>
	    	    <div class="mypage-rank"><p style="margin-right: 5px;">사과</p><img src="${pageContext.request.contextPath}/static/icon/apple.svg"></div>
	        </div>
    	</div>
        <div class="mypage-point">
        	<p>포인트</p>
        	<div class="mypage-point-detail">
        		<p style="color: var(--primary);">0</p><p style="margin-left: 2px;">P</p>
        	</div>
        </div>
        <p style="  margin-left: 5px;">마이페이지</p>
        <div class="mypage-option">
	        <div class="mypage-menu"><img class="mypage-menu-image" src="${pageContext.request.contextPath}/static/icon/mypage-toggle/credit-card.svg"><p>주문조회</p></div>
	        <div class="mypage-menu"><img class="mypage-menu-image" src="${pageContext.request.contextPath}/static/icon/mypage-toggle/receipt.svg"><p>구매후기</p></div>
	        <div class="mypage-menu"><img class="mypage-menu-image" src="${pageContext.request.contextPath}/static/icon/mypage-toggle/truck.svg"><p>수거내역</p></div>
	        <div class="mypage-menu"><img class="mypage-menu-image" src="${pageContext.request.contextPath}/static/icon/mypage-toggle/point.svg"><p>포인트내역</p></div>
        </div>
        <div class="mypage-logout"><p>로그아웃</p><img id="mypage-menu-update" class="mypage-menu-image" src="${pageContext.request.contextPath}/static/icon/mypage-toggle/gear.svg"></div>
    </div>
</body>

</html>