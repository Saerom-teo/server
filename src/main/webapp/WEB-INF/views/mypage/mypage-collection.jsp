<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/mypage-collection.css">

</head>

<body>
    <%@ include file="/WEB-INF/views/collection/header.jsp" %>
    <div class="wrapper">
        <%@ include file="/WEB-INF/views/common/mypage-nav.jsp" %>
        <div class="collection-content">
            <div class="collection-name">
                <h1>수거신청</h1>
            </div>
            <div id="collection-list">
                <h3>수거 신청 내역</h3>
                <div id="collection-table">
                    <table>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>신청일</th>
                                <th>무게</th>
                                <th>지급 포인트</th>
                                <th>수거현황</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Rows will be dynamically generated by JavaScript -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Structure -->
    <div id="resultModal" class="modal">
        <div class="modal-content">
        	<div>
	            <span class="close">&times;</span>
        	</div>
        	<hr>
            <div class="result-images">
                <img id="resultImage1" src="" alt="Result Image 1">
                <img id="resultImage2" src="" alt="Result Image 2">
                <img id="resultImage3" src="" alt="Result Image 3">
                <img id="resultImage4" src="" alt="Result Image 4">
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/collection/footer.jsp"%>
</body>
</html>
