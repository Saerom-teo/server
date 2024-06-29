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
	href="${pageContext.request.contextPath}/static/css/product-detail-review.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<title>Product-detail-review</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<%@ include file="/WEB-INF/views/common/shopnav.jsp"%>
	<div class="shop-detail">
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
			<div class="review_section">
				<div class="review_t">상품 리뷰</div>
				<div class="width_line"></div>
				<div class="review_block">
					<div>
						<div class="review_block_text">사용자 총 평점</div>
						<div class="review_block_num">
							<div class="review_block_num1">4.23</div>
							<div class="review_block_num2">/&nbsp;5</div>
						</div>

					</div>
					<div>
						<div class="review_block_text">전체 리뷰수</div>
						<div class="review_review_num">6</div>
					</div>
				</div>
			</div>
			
			
			<c:forEach  var="review" items="${reviewList}">
			<div class="item">
				<div class="user_date">
					<div style="display: flex;">
						<img
							src="${pageContext.request.contextPath}/static/img/User_cicrle_light.svg">
						<div class="user_name">${review.userCode}</div>
					</div>
					<div class="add_date">후기 등록 날짜 ${review.writeDate}</div>
				</div>
				<div class="score">
					<div>평점</div>
					<div class="star">
						<c:forEach begin="0" end="${review.reviewScore-1}">
							<img src="${pageContext.request.contextPath}/static/img/star.svg">
						</c:forEach>
						<c:forEach begin="0" end="${5 - review.reviewScore-1}">
							<img src="${pageContext.request.contextPath}/static/img/star2.svg">
						</c:forEach>
					</div>
				</div>
				<div class="small_review">
					<img
						src="${pageContext.request.contextPath}/static/img/product-img.png">
					<div>${review.reviewContent}</div>
				</div>
				<div class="width_line2"></div>
			</div>
			</c:forEach>

			

			
		</div>
		
	</div>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>