<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/collection.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
    <script src="${pageContext.request.contextPath}/static/js/collection/collection.js"></script>
    
    <title>Document</title>
</head>

<body category-no="0">
    <%@ include file="/WEB-INF/views/collection/header.jsp"%>
    <div id="semi-header">
    	<%@ include file="/WEB-INF/views/collection/collection-nav.jsp"%>
    </div>

    <div id="intro">
        <div id="intro-title">
            <h1>올레픽</h1>
            <p>새롬터의 플라스틱 수거 서비스</p>
        </div>
        <div id="intro-no01" class="container">
            <h3>01</h3>
            <h2>새롬터의 플라스틱 수거 서비스 올레픽</h2>
            <p>새롬터의 플라스틱 수거 서비스를 통해 순환경제 생태계에 참여하세요!</p>
            <a class="gray">*올레픽(Olepic)이란 플라스틱의 원료인 올레핀(Olefin)과 수거를 뜻하는 Pick up의 합성어입니다.</a>
        </div>
        <div id="intro-no01-1" class="container">
            <h3>순환경제란?</h3>
            <p>순환경제(Circular Economy)는 자원을 사용 후 폐기하는 선형경제(Linear Economy)와 대비하여<br>
                자원을 최대한 효율적으로 활용하고 폐기물과 오염을 최소화하는 경제 모델입니다.<br>
                플라스틱 재활용을 통한 순환경제 구축은 자원 및 에너지 절약을 통해 온실가스를 감축하고<br>
                쓰레기 처리 및 매립으로 인한 환경 오염 문제도 동시에 해결할 수 있기 때문에 지속가능한 사회를 위해 반드시 필요합니다.</p>
            <img src="${pageContext.request.contextPath}/static/img/collection/eco-cycle.png">
        </div>
        <div id="intro-no02" class="container">
            <h3>02</h3>
            <h2>수거 품목</h2>
            <img src="${pageContext.request.contextPath}/static/img/collection/collection-items.png">
            <p>재활용이 불가능한 PVC, OTHER(3번, 7번)를 제외한 모든 플라스틱을 수거합니다.</p>
        </div>
        <div id="intro-no03" class="container">
            <h3>03</h3>
            <h2>서비스 가능 지역</h2>
            <img src="${pageContext.request.contextPath}/static/img/collection/map.png">
            <p>올레픽은 서울 전지역에서 이용 가능합니다.</p>
            <a class="gray">서울 이외 지역은 추후에 확장할 예정입니다.</a>
        </div>
        <div id="intro-no04" class="container">
            <h3>04</h3>
            <h2>참여 방법</h2>
            <img src="${pageContext.request.contextPath}/static/img/collection/join.png">
        </div>
        <div id="intro-no05" class="container">
            <h3>05</h3>
            <h2>서비스 신청</h2>
            <button class="green-btn btn-primary" onclick="window.location.href='regist'">서비스 신청하러 가기</button>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/collection/footer.jsp"%>
</body>

</html>