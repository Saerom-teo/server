<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

	<div class="div">
	  <div class="frame-8928">
	    <img class="tree1" src="${path}/static/img/tree1.png" />
	    <img class="tree2" src="${path}/static/img/tree1.png" />
	    <div class="div2">
	      결제에 실패했습니다.
	      <br />
	      다시 주문을 진행해주세요.
	    </div>
	  </div>
	  <div class="button-bar">
	    <div class="button-1">
	      <button class="main">메인 메뉴로 돌아가기</div>
	    </div>
	    <div class="button-2">
	      <div class=keep-shopping>계속 쇼핑하기</div>
	    </div>
	  </div>
	</div>

</body>
</html>