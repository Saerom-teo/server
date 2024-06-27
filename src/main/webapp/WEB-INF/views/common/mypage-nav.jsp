<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/mypage-nav.css">



<body>
    <div class="nav">
        <div class="myinfo">
            <img class="user-profile" src="${pageContext.request.contextPath}/static/icon/mypage-profile.svg" />
            <p>user 님</p>
        </div>
        <div class="pointinfo">
            <div>
                <p>포인트</p>
                <p>800 P</p>
            </div>
            <div>
                <p>등급 안내</p>
                <span>
                    <p>씨앗</p>
                    <img class="group-8795" src="${pageContext.request.contextPath}/static/img/apple.svg"/>
                </span>
            </div>
        </div>
        <div class="navlist">
            <div class="nav-li">
                <a>주문 조회</a>
            </div>
            <div class="nav-li current-page">
                <a>구매 후기</a>
            </div>
            <div class="nav-li">
                <a>수거 내역</a>
            </div>
            <div class="nav-li">
                <a>장바구니</a>
            </div>
            <div class="nav-li">
                <a>위시리스트</a>
            </div>
            <div class="nav-li">
                <a>회원 정보 수정</a>
            </div>
        </div>
    </div>

</body>

</html>