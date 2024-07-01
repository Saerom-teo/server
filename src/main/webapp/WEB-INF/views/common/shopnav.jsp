<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/shopnav.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<title>Document</title>
</head>
<body>
	<div id="menu-wrapper">
		<ul class="nav">
			<c:forEach items="${major}" var="category_major">
				<!-- 카테고리 대분류 -->
				<li><a href="#">${category_major}</a>
					<div>
						<div class="nav-column">
							<ul style="display: flex;">
								<c:forEach items="${middle}" var="category_middle">
									<c:if test="${category_middle.majorCategory == category_major}">
										<!-- 카테고리 중분류 -->
										<li class="middle_name"><a class="middle" href="#">${category_middle.middleCategory}</a>
											<ul>
												<c:forEach items="${category}" var="categoryVO">
													<c:if
														test="${categoryVO.majorCategory == category_major && categoryVO.middleCategory == category_middle.middleCategory}">
														<!-- 카테고리 소분류 -->
														<li><a class="small" href="#">${categoryVO.smallCategory}</a></li>
													</c:if>
												</c:forEach>
											</ul></li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</div></li>
			</c:forEach>
			<li><a href="">전체</a></li>
		</ul>
	</div>
</body>
</html>