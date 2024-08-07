<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/mypage-nav.css">
<style>
.rank {
	letter-spacing: -0.15em;
}
.rank-icon {
	width: 25px;
}
</style>

<body>
    <div class="nav">
        <div class="myinfo">
            <img class="user-profile" src="${profileImg}" />
            <p>${nickname} 님</p>
        </div>
        <div class="pointinfo">
            <div>
                <p>포인트</p>
                <p>${point} P</p>
            </div>
            <div>
                <p>등급 안내</p>
                <span>
                    <p class="rank">${rank}</p>
                    <img class="rank-icon" src="${pageContext.request.contextPath}/${rankImg}"/>
                </span>
            </div>
        </div>
        <div class="navlist">
            <a class="nav-li" id="order" href="${pageContext.request.contextPath}/mypage/order">주문 조회</a>
            <a class="nav-li" id="review" href="${pageContext.request.contextPath}/mypage/review">구매 후기</a>
            <a class="nav-li" id="collection" href="${pageContext.request.contextPath}/mypage/collection">수거 내역</a>
            <a class="nav-li" id="cart" href="${pageContext.request.contextPath}/mypage/basket">장바구니</a>
            <a class="nav-li" id="wishlist" href="${pageContext.request.contextPath}/mypage/wishlist">위시리스트</a>
            <a class="nav-li" id="point" href="${pageContext.request.contextPath}/mypage/point">포인트</a>
            <a class="nav-li" id="profile" href="${pageContext.request.contextPath}/mypage/profile">회원 정보 수정</a>
        </div>
    </div>

</body>

</html>
