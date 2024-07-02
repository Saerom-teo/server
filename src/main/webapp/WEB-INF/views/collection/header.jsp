<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
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
			<div id="icons">
			
			</div>
        </div>
    </div>
    <%-- 
    mypage toggle box
    <div class="mypage-toggle-box">
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
    
    notification toggle box
    <div class="noti-toggle-box">
    	<header class="noti-title">알림</header>
    	<div class="noti-content">
    		<li class="noti-chart">
    			<div class="noti-chart-head">
	    			<span class="noti-type">알림</span>
	    			<p class="noti-time">8시간전</p>
    			</div>
    			<div class="noti-chart-content">
    				<div>
	    				<p>포인트 지급 되었습니다</p>
    					<div class="noti-chart-point"><p style="color: var(--primary);">1,000</p><p style="margin-left: 2px;">P</p></div>
    				</div>
    				<img src="${pageContext.request.contextPath}/static/icon/mypage-toggle/right.svg">
    			</div>
    		</li>
    		<li class="noti-chart">
    			<div class="noti-chart-head">
    				<span class="noti-type">알림</span>
    				<p class="noti-time">하루전</p>
   				</div>
    			<div class="noti-chart-content">
    				<p>수거완료 되었습니다</p>
    				<img src="${pageContext.request.contextPath}/static/icon/mypage-toggle/right.svg">
    			</div>
    		</li>
    		<li class="noti-chart">
    			<div class="noti-chart-head">
    				<span class="noti-type">알림</span>
    				<p class="noti-time">1주일전</p>
   				</div>
    			<div class="noti-chart-content">
    				<p>올레픽신청이 승인되었습니다</p>
    				<img src="${pageContext.request.contextPath}/static/icon/mypage-toggle/right.svg">
    			</div>
    		</li>
    		<li class="noti-chart">
    			<div class="noti-chart-head">
    				<span class="noti-type">알림</span>
    				<p class="noti-time">3달전</p>
    			</div>	
    			<div class="noti-chart-content">
    				<p>검사완료 되었습니다</p>
    				<img src="${pageContext.request.contextPath}/static/icon/mypage-toggle/right.svg">
    			</div>
    		</li>
    		<li class="noti-chart">
    			<div class="noti-chart-head">	
    				<span class="noti-type">알림</span>
    				<p class="noti-time">4달전</p>
    			</div>
    			<div class="noti-chart-content">
    				<p>수거신청이 완료 되었습니다</p>
    				<img src="${pageContext.request.contextPath}/static/icon/mypage-toggle/right.svg">
    			</div>
    		</li>
    	</div>
    </div> --%>

    <script>
	    function getCookie(name) {
	        let matches = document.cookie.match(new RegExp(
	            "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
	        ));
	        return matches ? decodeURIComponent(matches[1]) : undefined;
	    }

        window.onload = function() {
        	console.log(getCookie('jwtToken'));
        	
        	let cookieData = document.cookie;
        	console.log(cookieData);
        	
            const iconsDiv = document.getElementById('icons');
            while (iconsDiv.firstChild) {
                iconsDiv.removeChild(iconsDiv.firstChild);
            }
            if (getCookie('jwtToken')) {
                const icons = [
                    '<div class="icon-item"><img src="${pageContext.request.contextPath}/static/icon/zzim.svg"></div>',
                    '<div class="icon-item"><img src="${pageContext.request.contextPath}/static/icon/basket.svg"></div>',
                    '<div class="icon-item"><img src="${pageContext.request.contextPath}/static/icon/notice.svg"></div>',
                    '<div class="icon-item"><img id="user-icon" src="${pageContext.request.contextPath}/static/icon/user.svg"></div>'
                ];
                iconsDiv.innerHTML = icons.join('');
            } else {
                const blankButton = document.createElement('p');
                const loginButton = document.createElement('a');
                loginButton.href = "${pageContext.request.contextPath}/auth/login";
                loginButton.textContent = "로그인";
                loginButton.classList.add('login-button');

                const signupButton = document.createElement('a');
                signupButton.href = "${pageContext.request.contextPath}/auth/registration";
                signupButton.textContent = "회원가입";
                signupButton.classList.add('signup-button');

                iconsDiv.appendChild(blankButton);
                iconsDiv.appendChild(loginButton);
                iconsDiv.appendChild(signupButton);

            }
        }
    </script>
</body>

</html>