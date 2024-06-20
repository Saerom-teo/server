<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/mypage-nav.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  
  
  
  <style>
   a,
   button,
   input,
   select,
   h1,
   h2,
   h3,
   h4,
   h5,
   * {
       box-sizing: border-box;
       margin: 0;
       padding: 0;
       border: none;
       text-decoration: none;
       background: none;
   
       -webkit-font-smoothing: antialiased;
   }
   
   menu, ol, ul {
       list-style-type: none;
       margin: 0;
       padding: 0;
   }
   </style>
  <title>Document</title>
</head>
<body>
  <div class="nav">
    <div class="myinfo">
      <img class="user-profile" src="${pageContext.request.contextPath}/static/img/mypage-profile.svg" />
      <div class="user">user 님</div>
    </div>
    <div class="pointinfo">
      <div class="frame-8904">
        <div class="nav-div">포인트</div>
        <div class="_800-p">800 P</div>
      </div>
      <div class="frame-8905">
        <div class="nav-div">등급 안내</div>
        <div class="frame-176">
          <div class="nav-div2">씨앗</div>
          <img class="group-8795" src="${pageContext.request.contextPath}/static/img/apple.svg"/>
        </div>
      </div>
    </div>
    <div class="navlist">
      <div class="frame-8892">
        <div class="nav-div3">주문 조회</div>
      </div>
      <div class="frame-8893">
        <div class="nav-div4">구매 후기</div>
      </div>
      <div class="frame-8894">
        <div class="nav-div4">수거 신청</div>
      </div>
      <div class="frame-8895">
        <div class="nav-div4">장바구니</div>
      </div>
      <div class="frame-8896">
        <div class="nav-div4">위시리스트</div>
      </div>
      <div class="frame-8897">
        <div class="nav-div4">포인트</div>
      </div>
      <div class="frame-8898">
        <div class="nav-div4">회원 정보 수정</div>
      </div>
      <div class="frame-8899">
        <div class="nav-div4">회원 탈퇴</div>
      </div>
    </div>
  </div>
  
</body>
</html>