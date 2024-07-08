<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/css/orderAfter.css">

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/collection/header.jsp" %>
	<div class="wrapper">
    
	<c:set var="status" value="${param.status}" />
	<div class="div">
	  <div class="frame-8928">
	    <img class="tree1" src="${path}/static/img/tree1.png" />
	    <img class="tree2" src="${path}/static/img/tree1.png" />
	    <div class="div2">
	    <c:choose>
	        <c:when test="${status eq 'fail'}">
	            주문에 실패했습니다.
	            <br />
	            다시 주문을 진행해주세요.
	        </c:when>
	        <c:when test="${status eq 'cancel'}">
	            주문이 취소되었습니다.
	            <br />
	            다음에 또 이용해주세요.
	        </c:when>
	        <c:otherwise>
	            주문이 완료되었어요!
	            <br />
	            주문하신 상품은 금방 보내드릴게요.
	        </c:otherwise>
	    </c:choose>
			      
	    </div>
	  </div>
	  <div class="button-bar">
	   
	      <button class="button-1" onclick="location.href='${path}'">메인 메뉴로 돌아가기</button>
	       <button class="button-2" onclick="location.href='${path}/products'">계속 쇼핑하기</button>
	   </div>
	     
	 
	</div>
	</div>
	<%@ include file="/WEB-INF/views/collection/footer.jsp"%>
</body>
</html>
