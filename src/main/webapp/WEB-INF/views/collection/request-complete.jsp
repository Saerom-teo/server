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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/collection.css">
    <script src="page-load.js"></script>

    <title>Document</title>
</head>

<body>
    <%@ include file="/WEB-INF/views/collection/header.jsp"%>

    <div class="submit-complete">
        <div class="message">
            <h2>접수가 완료되었어요!<br>
                수거 진행현황은 마이페이지에서 확인해주세요</h2>
        </div>
        <div>
            <button id="requst-btn">메인 메뉴로 돌아가기</button>
        </div>
    </div>

    <!-- <div id="footer"></div> -->

</body>

</html>