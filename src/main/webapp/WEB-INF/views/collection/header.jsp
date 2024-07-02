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
</script>

<body>
    <div class="header">
        <div class="header-container">
        	<a href="${pageContext.request.contextPath}">
            	<img id="logo" src="${pageContext.request.contextPath}/static/icon/logo.svg">
            </a>
    
            <div id="header-collection">
                <a id="headerCollection"  href="${pageContext.request.contextPath}/collection/intro">플라스틱<br>수거</a>
            </div>
            <div id="header-shop">
                <a id="headerProducts" href="${pageContext.request.contextPath}/products">친환경<br>장터</a>
            </div>
            <div id="header-community">
                <a id="headerDashboard" href="${pageContext.request.contextPath}/dashboard">친환경<br>커뮤니티</a>
            </div>
            <div class="search">
                <input type="text" class="searchbar" onkeypress="showSearch(event)">
                <img src="${pageContext.request.contextPath}/static/icon/search.svg" onclick="search()" style="cursor:pointer">
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
</body>

</html>