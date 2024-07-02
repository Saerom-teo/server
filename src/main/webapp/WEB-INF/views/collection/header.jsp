<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
<script src="${pageContext.request.contextPath}/static/js/style.js"></script>

<style>
    #icons {
        padding: 1px 0;
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        width: 20%;
    }
    #icons a {
		text-decoration: none;
	    font-weight: bold;
	    padding: 0 25px;
	    height: 100%;
	    text-align: center;
	    align-content: center;
	    font-size: 14px;
	    border-radius: 5px;
    }
    .signup-button {
    	background-color: var(--primary);
    	color: #fff !important;
    }
    .signup-button:hover {
    	background-color: var(--primary-dark);    	
    }
    
    .login-button {
    	border: 1px solid var(--gray);
    }
    .login-button:hover {
    	background-color: var(--tertiary);    	
    }
</style>

<body>
    <div class="header">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}">
                <img id="logo" src="${pageContext.request.contextPath}/static/icon/logo.svg">
            </a>
    
            <div id="header-collection">
                <a href="${pageContext.request.contextPath}/collection/intro">플라스틱<br>수거</a>
            </div>
            <div id="header-shop">
                <a href="${pageContext.request.contextPath}/products">친환경<br>장터</a>
            </div>
            <div id="header-community">
                <a href="${pageContext.request.contextPath}/dashboard">친환경<br>커뮤니티</a>
            </div>
            <div class="search">
                <input type="text">
                <img src="${pageContext.request.contextPath}/static/icon/search.svg">
            </div>
            <div id="icons">
            </div>
        </div>
    </div>
    
    <!-- 토글 박스 -->
    <div class="toggle-box">
        <!-- 여기에 원하는 내용을 추가하세요 -->
        <img src="${pageContext.request.contextPath}/static/icon/mypage-profile.svg">
        <div>
            <p>닉네임</p>
            <p>사과</p><img src="${pageContext.request.contextPath}/static/icon/apple.svg">
        </div>
        <div>
            <p>포인트</p><span>0P</span>
        </div>
        <p>마이페이지</p>
        <p>주문조회</p>
        <p>구매후기</p>
        <p>수거내역</p>
        <p>장바구니</p>
        <p>위시리스트</p>
        <p>내정보 수정</p>
        <p>로그아웃</p>
    </div>

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
