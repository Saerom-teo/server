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
	<title>Cart</title>

	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">

	<style>
		body {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}
		.wrapper {
			margin-top: var(--header-size);
			width: 70%;
		}
		.collection-content {
		}
	</style>
</head>

<body>
	<%@ include file="/WEB-INF/views/collection/header.jsp" %>
	<div class="wrapper">
		<div style="display: flex;">
			
				<%@ include file="/WEB-INF/views/common/mypage-nav.jsp" %>
			
				<div id="collection-content">수거</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/collection/footer.jsp"%>
</body>

</html>