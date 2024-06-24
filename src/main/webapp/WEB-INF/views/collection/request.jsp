<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" page-category="collection" category-no="2">

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

<body category-no="2">
    <%@ include file="/WEB-INF/views/collection/header.jsp"%>
    <div id="semi-header">
    	<%@ include file="/WEB-INF/views/collection/collection-nav.jsp"%>
    </div>

    <div id="request">
        <h1>우리가함께한 오늘의 실천</h1>
        <p>우리가 가져온 플라스틱, 지금 얼마나 모였을까요?</p>
        <div id="collection-amoount">
            <p><span>24811</span>kg</p>
        </div>
        <a>(2024.05 기준 업데이트)</a><br>


        <button class="green-btn btn-primary" onclick="window.location.href='request-submit'">수거 요청하기</button>
    </div>

    <%@ include file="/WEB-INF/views/collection/footer.jsp"%>
</body>

</html>