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
	href="${pageContext.request.contextPath}/static/css/mypage-orderlist.css">
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
</style>
<title>Document</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="mypage-orderlist">
		
		<div class="body">
		<%@ include file="/WEB-INF/views/common/mypage-nav.jsp"%>
			<div class="frame-8881">
				<div class="head">
					<div class="div">주문조회</div>
				</div>
				<div class="option">
					<div class="frame-8920">
						<div class="_1">최근 1년</div>
					</div>
					<div class="frame-8921">
						<div class="_12">1주일</div>
					</div>
					<div class="frame-8922">
						<div class="_12">1개월</div>
					</div>
					<div class="frame-8923">
						<div class="_12">3개월</div>
					</div>
					<div class="frame-8924">
						<div class="_13">날짜form</div>
					</div>
					<div class="frame-8925">
						<div class="_14">날짜 form</div>
					</div>
					<div class="frame-8926">
						<div class="_15">조회하기</div>
					</div>
				</div>
				<div class="bodylist">
					<div class="box-1">
						<div class="div2">주문상세 &gt;</div>
						<div class="frame-8903">
							<div class="div3">결제완료</div>
							<div class="frame-89032">
								<div class="div4">주문 취소</div>
							</div>
						</div>
						<div class="frame-8902">
							<img class="_1-15489"
								src="${pageContext.request.contextPath}/static/css/mypage-image1.css" />
							<div class="frame-8901">
								<div class="_2024-02-12-12-08-25">
									<span> <span class="_2024-02-12-12-08-25-span">
											2024.02.12. 12:08:25 결제 </span> <span
										class="_2024-02-12-12-08-25-span2"></span> <span
										class="_2024-02-12-12-08-25-span3"></span> <span
										class="_2024-02-12-12-08-25-span4"></span> <span
										class="_2024-02-12-12-08-25-span5"></span>
									</span>
								</div>
								<div class="div5">
									<span> <span class="div-5-span">[소락] 오가닉 코튼 자수
											손수건</span> <span class="div-5-span2"></span>
									</span>
								</div>
								<div class="_5000">
									<span> <span class="_5000-span">5000원</span> <span
										class="_5000-span2"></span> <span class="_5000-span3"></span>
									</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>

</body>
</html>