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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	function search() {
		var keyword = $(".searchbar").val();
		location.href = "${pageContext.request.contextPath}/products/readByKeyword/" + keyword;
	}
	
	function showSearch(e) {
		if(e.keyCode == 13) {
			search();
		}
	}
	
	function getCookie(name) {
        let matches = document.cookie.match(new RegExp(
            "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
        ));
        return matches ? decodeURIComponent(matches[1]) : undefined;
    }
  
            
	
    $(document).ready(function(){
   
            

        $("#user-icon").click(function(){
            $(".mypage-toggle-box").toggle();
            $(".noti-toggle-box").hide();
        });

        $("#noti-icon").click(function(){
            $(".mypage-toggle-box").hide();
            $(".noti-toggle-box").toggle();
        });
        
        var nowPath = window.location.pathname;
        
        $(".headers").removeClass("current-page-header");
        
        if(nowPath.includes('collection')) {
        	$(".headerCollection").addClass("current-page-header");
        }
        else if(nowPath.includes('products')) {
        	$(".headerProducts").addClass("current-page-header");
        }
        else if(nowPath.includes('dashboard') || nowPath.includes('news') || nowPath.includes('quiz') || nowPath.includes('envdata')  ) {
        	$(".headerDashboard").addClass("current-page-header");
        }
        
        console.log(getCookie('jwtToken'));
        
        let cookieData = document.cookie;
        console.log(cookieData);
        
        const iconsDiv = document.getElementById('icons');
        while (iconsDiv.firstChild) {
            iconsDiv.removeChild(iconsDiv.firstChild);
        }
        if (getCookie('jwtToken')) {
            const icons = [
                    '<a href="${pageContext.request.contextPath}/mypage/wishlist"><div class="icon-item"><img src="${pageContext.request.contextPath}/static/icon/zzim.svg"></div></a>',
                    '<a href="${pageContext.request.contextPath}/mypage/basket"><div class="icon-item"><img src="${pageContext.request.contextPath}/static/icon/basket.svg"></div></a>',
                    '<div class="icon-item"><img id="noti-icon" src="${pageContext.request.contextPath}/static/icon/notice.svg"></div>',
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

        $("#user-icon").click(function(event){
            event.stopPropagation(); // 이벤트 전파 방지
            $(".mypage-toggle-box").toggle();
            $(".noti-toggle-box").hide();
        });

        $("#noti-icon").click(function(event){
            event.stopPropagation(); // 이벤트 전파 방지
            $(".mypage-toggle-box").hide();
            $(".noti-toggle-box").toggle();
        });

        // 화면의 다른 곳을 클릭하면 토글 닫기
        $(document).click(function(){
            $(".mypage-toggle-box").hide();
            $(".noti-toggle-box").hide();
        });

        // 토글 박스를 클릭할 때 이벤트 전파 방지
        $(".mypage-toggle-box, .noti-toggle-box").click(function(event){
            event.stopPropagation();
        });
        loadNoti();
    });
    
    function loadNoti() {
    	$.ajax({
    		url: "${pageContext.request.contextPath}/notification/read-by-user",
    		method: "GET",
    		success: function(notificationList) {
    			var resHtml = "";
    			var nowPoint = 0;
    			$.each(notificationList, function(index, noti) {
    				 createdAt = new Date(noti.createdAt.replace(' ', 'T')); // 문자열을 Date 객체로 변환
    		         timeAgo = getTimeAgo(createdAt);
    				 
    				
    				if(noti.notificationTitle == "포인트") {
	    				resHtml += `<a href="${pageContext.request.contextPath}/mypage/point">`
    				} else if(noti.notificationTitle == "수거") {
	    				resHtml += `<a href="${pageContext.request.contextPath}/mypage/collection">`
    				} else if(noti.notificationTitle == "주문") {
	    				resHtml += `<a href="${pageContext.request.contextPath}/mypage/order">`
    				}
    				else {
    					resHtml += `<a href="">`
    				}
    				resHtml += 
    					`
    				<li class="noti-chart">
        			<div class="noti-chart-head">
    	    			<span class="noti-type">`+noti.notificationTitle+`</span>
    	    			<p class="noti-time">`+timeAgo+`</p>
        			</div>
        			<div class="noti-chart-content">
        				<div>
    	    				<p>`+noti.notificationBody+`</p>`;
    	    		
    	    		if(noti.notificationTitle == "포인트") {
    	    			$.ajax({
    	    				url: "${pageContext.request.contextPath}/api/point/readById/" + noti.relatedPointId,
    	    				method: "GET",
    	    				async: false,
    	    				success: function(pointEntity) {
    	    					nowPoint = pointEntity.amount;
    	    				},
    	    				error: function(e) {
    	    					console.log(e);
    	    				}
    	    			});
    	    			resHtml+=`<div class="noti-chart-point"><p style="color: var(--primary);">`+nowPoint+`</p><p style="margin-left: 2px;">P</p></div>`;
    	    		}
    	    		
        			resHtml += `</div>
        				<img src="${pageContext.request.contextPath}/static/icon/mypage-toggle/right.svg">
        			</div>
        			</li></a>`;
    			});
    			$(".noti-content").html(resHtml);
    		},
    		error: function(e) {
    			console.log(e);
    		}
    	});
    }
    
    function getTimeAgo(date) {
        const now = new Date();
        const diff = now - date; // 차이 계산 (밀리초 단위)
        const minutes = Math.floor(diff / (1000 * 60));
        const hours = Math.floor(diff / (1000 * 60 * 60));
        const days = Math.floor(diff / (1000 * 60 * 60 * 24));

        if (minutes < 60) {
            return minutes + "분 전";
        } else if (hours < 24) {
            return hours + "시간 전";
        } else {
            return days + "일 전";
        }
    }
</script>
<style>
	.header a {
		text-decoration: none;
		color: black;
	}
	.header a:link { color: black; text-decoration: none;} 
	.header a:visited { color: black; text-decoration: none;} 
	.header a:hover { color: black; text-decoration: none;}
    #icons {
        padding: 1px 0;
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        width: 20%;
    }
    #icons a{
		text-decoration: none;
	    font-weight: bold;
/* 	    padding: 0 25px; */
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
    	border: 2.3px solid var(--primary); 
		color: var(--primary) !important;
    }
    
    .current-page-header {
    	color: var(--black) !important;
	}
	a {
		text-decoration: none;
	}
	P {
		color: var(--black);
	}
</style>



<body>
    <div class="header">
        <div class="header-container">
        	<a href="${pageContext.request.contextPath}/">
            	<img id="logo" src="${pageContext.request.contextPath}/static/icon/logo.svg">
            </a>
    
            <div id="header-collection">
                <a class="headers headerCollection"  href="${pageContext.request.contextPath}/collection/intro">플라스틱<br>수거</a>
            </div>
            <div id="header-shop">
                <a class="headers headerProducts" href="${pageContext.request.contextPath}/products">친환경<br>장터</a>
            </div>
            <div id="header-community">
                <a class="headers headerDashboard" href="${pageContext.request.contextPath}/dashboard">친환경<br>커뮤니티</a>
            </div>
            <div class="search">
                <input type="text" class="searchbar" onkeypress="showSearch(event)">
                <img src="${pageContext.request.contextPath}/static/icon/search.svg" onclick="search()" style="cursor:pointer">
            </div>
			<div id="icons">
				
			</div>
        </div>
    </div>
    
    <%-- mypage toggle box --%>
    <div class="mypage-toggle-box">
    	<div class="mypage-head">
	        <img class="mypage-image" src="${pageContext.request.contextPath}/static/icon/mypage-profile.svg">
	        <div class="mypage-info">
		        <div class="mypage-info-set">
		        	<a style="display: flex;" href="${pageContext.request.contextPath}/mypage/profile"><p class="mypage-info-nickname">닉네임</p><img src="${pageContext.request.contextPath}/static/icon/mypage-toggle/chevron-right.svg"></a>
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
	        <a href="${pageContext.request.contextPath}/mypage/order"><div class="mypage-menu"><img class="mypage-menu-image" src="${pageContext.request.contextPath}/static/icon/mypage-toggle/credit-card.svg"><p>주문조회</p></div></a>
	        <a href="${pageContext.request.contextPath}/mypage/review"><div class="mypage-menu"><img class="mypage-menu-image" src="${pageContext.request.contextPath}/static/icon/mypage-toggle/receipt.svg"><p>구매후기</p></div></a>
	        <a href="${pageContext.request.contextPath}/mypage/collection"><div class="mypage-menu"><img class="mypage-menu-image" src="${pageContext.request.contextPath}/static/icon/mypage-toggle/truck.svg"><p>수거내역</p></div></a>
	        <a href="${pageContext.request.contextPath}/mypage/point"><div class="mypage-menu"><img class="mypage-menu-image" src="${pageContext.request.contextPath}/static/icon/mypage-toggle/point.svg"><p>포인트내역</p></div></a>
		</div>
		<p class="mypage-logout"><a style="color: var(--black);" href="${pageContext.request.contextPath}/logout">로그아웃</a></p>
	</div>
    
    <%-- notification toggle box--%>
    <div class="noti-toggle-box">
    	<header class="noti-title">알림</header>
    	<div class="noti-content">
    	</div>
    </div>

	    
</body>
</html>
