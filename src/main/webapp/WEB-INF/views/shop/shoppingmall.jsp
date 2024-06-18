<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/shoppingmall.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">


<style>
a, button, input, select, h1, h2, h3, h4, h5, * {
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

.header {
	position: fixed; 
	top: 0;
	width: 100% ;
	z-index: 1000;
}
</style>
<title>Document</title>
</head>
<body>
	<div class="shoppingmall">
	
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<%@ include file="/WEB-INF/views/common/shopnav.jsp"%>
		<div class="body">
		
			<div class="div">의류</div>
			<div class="category-div">
				<div class="category">
					<div class="div2">정렬 ▼</div>
				</div>
			</div>
			<div class="shopbody">
				<div class="stock-1">
					<div class="div3">
						<span> <span class="div-3-span">[소락] 오가닉 코튼 자수 손수건</span> <span
							class="div-3-span2"></span>
						</span>
					</div>
					<div class="_5000">
						<span> <span class="_5000-span">5000 원</span> <span
							class="_5000-span2"></span>
						</span>
					</div>
					<div class="frame-18">
						<div class="sale">SALE</div>
					</div>
					<img class="_1-15487"
						src="${pageContext.request.contextPath}/static/img/product-img.png" />
					<div class="frame-21">
						<div class="_7000">
							<span> <span class="_7000-span">7000 원</span> <span
								class="_7000-span2"></span> <span class="_7000-span3"></span> <span
								class="_7000-span4"></span>
							</span>
						</div>
						<div class="line-7"></div>
						<div class="frame-19">
							<div class="best">BEST</div>
						</div>
					</div>
				</div>
				<div class="stock-2">
					<div class="div3">
						<span> <span class="div-3-span3">[소락] 오가닉 코튼 자수 손수건</span>
							<span class="div-3-span4"></span>
						</span>
					</div>
					<div class="_5000">
						<span> <span class="_5000-span3">5000 원</span> <span
							class="_5000-span4"></span>
						</span>
					</div>
					<div class="frame-18">
						<div class="sale">SALE</div>
					</div>
					<img class="_1-15487"
						src="${pageContext.request.contextPath}/static/img/product-img.png" />
					<div class="frame-21">
						<div class="_7000">
							<span> <span class="_7000-span5">7000 원</span> <span
								class="_7000-span6"></span> <span class="_7000-span7"></span> <span
								class="_7000-span8"></span>
							</span>
						</div>
						<div class="line-7"></div>
						<div class="frame-19">
							<div class="best">BEST</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>

</body>
</html>