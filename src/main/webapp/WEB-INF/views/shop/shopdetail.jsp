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
	href="${pageContext.request.contextPath}/static/css/shopdetail.css">
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
	<div class="shop-detail">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<%@ include file="/WEB-INF/views/common/shopnav.jsp"%>
		<div class="body">
			<div class="first">
				<img class="_1-15487"
					src="${pageContext.request.contextPath}/static/img/product-img.png" />
				<div class="explanation">
					<div class="ex-title">
						<div class="div">오르가닉 손수건</div>
						<div class="_5000-7000">
							<span> <span class="_5000-7000-span">5000원</span> <span
								class="_5000-7000-span2">7000원</span> <span
								class="_5000-7000-span3"></span>
							</span>
						</div>
					</div>
					<div class="ex-body-1">
						<div class="div2">
							***환경 인증 마크를 받은 제품입니다. <br /> 이 상품은 오르가닉 손수건으로 슬플 때 이걸로 눈물을 닦으면
							마법처럼 눈물이 사라지는 손수건입니다.
						</div>
						<div class="_3-000-50-000">
							<span> <span class="_3-000-50-000-span">원산지</span> <span
								class="_3-000-50-000-span2"> 대한민국 <br />
							</span> <span class="_3-000-50-000-span3">브랜드</span> <span
								class="_3-000-50-000-span4"> 새롬터 <br />
							</span> <span class="_3-000-50-000-span5">배송 방법</span> <span
								class="_3-000-50-000-span6"> 택배 <br />
							</span> <span class="_3-000-50-000-span7">배송비</span> <span
								class="_3-000-50-000-span8"> 3,000원 (50,000원 이상 무료배송) |
									도서산간 배송비 추가 </span>
							</span>
						</div>
						<div class="frame-114">
							<div class="div3">수량</div>
							<div class="frame-115">
								<div class="frame-116">
									<div class="frame-117">
										<div class="div4">-</div>
									</div>
									<div class="frame-118">
										<div class="_1">1</div>
									</div>
									<div class="frame-119">
										<div class="div4">+</div>
									</div>
								</div>
								<div class="_4000">4000원</div>
							</div>
						</div>
					</div>
					<div class="ex-body-2">
						<div class="_12">총 상품금액 (1개)</div>
						<div class="_40002">4000원</div>
					</div>
					<div class="ex-footer">
						<div class="frame-110">
							<div class="div5">구매하기</div>
						</div>
						<div class="frame-111">
							<div class="div6">장바구니</div>
						</div>
						<img class="frame-112"
							src="${pageContext.request.contextPath}/static/img/hart.svg" />
					</div>
				</div>
			</div>
			<div class="shop-detail-box">
				<div class="button-1">
					<div class="div7">상품 상세</div>
				</div>
				<div class="button-2">
					<div class="div8">상품 후기</div>
				</div>
			</div>
			<div class="detail-image">
				<img class="image-29"
					src="${pageContext.request.contextPath}/static/img/detail-img.png" />
			</div>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>

</body>
</html>