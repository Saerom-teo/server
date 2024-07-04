<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/css/refund.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">

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
		<div style="display: flex;">
			<div>
				<%@ include file="/WEB-INF/views/common/mypage-nav.jsp"%>
			</div>

			<div class="order-inquiry">
				<div class="order-inquiry-head">
					<div class="div">반품 및 교환 신청</div>
				</div>
				<div class="order-inquiry-option">
					<div class="order-date-board">
						<span> <span class="order-date-text">주문일자</span> <span
							class="order-date-data"></span>
						</span>
					</div>
					<div class="order-code-board">
						<span> <span class="order-code-text">주문번호</span> <span
							class="order-code-data"></span>
						</span>
					</div>
				</div>
				<div class="order-inquiry-list">
					<div class="order-choice">
						<div class="div2">반품 / 교환 요청 상품 선택</div>
						<div class="choice">
							<div>
								<input type="checkbox" name="all" id="selectAllCheckbox">
								<label for="all" class="checkbox-label">전체 선택</label>
							</div>

						</div>
						<div class="item-container" id="item-container">
							<c:forEach var="item" items="${basketList}">
								<div class="item">
									<div class="item-checkbox">
										<input type="checkbox" class="item-select"
											data-index="${item.productCode}"
											data-user-id="${item.userId}">
									</div>
									<img
										src="${pageContext.request.contextPath}/static/img/product-img.png"
										class="item-image">
									<div class="item-details">
										<p>${item.product.productName}</p>
										<div class="price-container">
											<span class="order-price">${item.product.discountedPrice}원</span>

										</div>
									</div>
									<div class="v-line"></div>
									<div class="quantity-container">
										<span>수량</span>
										<div class="quantity-control">
											<!-- 수량 감소 버튼 -->
											<button class="decrement-btn"
												data-product-code="${item.productCode}">-</button>
											<span id="quantity-${item.productCode}">${item.productQuantity}</span>
											<!-- 수량 증가 버튼 -->
											<button class="increment-btn"
												data-product-code="${item.productCode}">+</button>
										</div>
									</div>
									<div class="v-line"></div>
									<div class="item-price">
										<span>상품금액</span>
										<p id="price-${item.productCode}"
											data-discounted-price="${item.product.discountedPrice}">${item.product.discountedPrice * item.productQuantity}원</p>
									</div>
									<div class="v-line"></div>

								</div>
							</c:forEach>
						</div>


					</div>
					<div class="order-insert">
						<div class="div2">반품 / 교환 수거 정보 입력</div>
						<div class="order-list2">
							<div class="select-option">
								<label> <input type="radio" name="option" value="return"
									class="radio-button" /> <span class="div-6-span">반품</span>
								</label> <label> <input type="radio" name="option"
									value="exchange" class="radio-button" /> <span
									class="div-7-span">교환</span>
								</label>
							</div>

							<div class="reason-refund-board">

								<select class="reason-select">
									<option value="" disabled selected>반품 사유를 선택하세요</option>
									<option value="damaged">상품이 손상됨</option>
									<option value="wrong-item">잘못된 상품 배송</option>
									<option value="not-satisfied">상품이 마음에 들지 않음</option>
									<option value="other">기타</option>
								</select>
							</div>
							<div class="detail-reason">
								<input type="text" class="detail-reason-input"
									placeholder="상세 사유 입력(선택 사항)">
							</div>

							<div class="div10">
								<span> <span class="div-10-span">반품 주소</span> <span
									class="div-10-span2"></span>
								</span>
							</div>
							
						</div>
					</div>
					<div class="order-info">
						<div class="div2">환불 정보</div>
						<div class="order-list3">
							<div class="_15000">
								<span> <span class="_15000-span"> 취소 상품 총 금액 합계 <br />
								</span> <span class="_15000-span2"> <br />
								</span> <span class="_15000-span3 price">15000원</span>
								</span>
							</div>
							<div class="div12">+</div>
							<div class="_3000">
								<span> <span class="_3000-span">반품 시 추가 배송비</span> <span
									class="_3000-span2"> <br /> <br />
								</span> <span class="_3000-span3 price">6000원</span>
								</span>
							</div>
							<div class="div12">=</div>
							<div class="_150002">
								<span> <span class="_150002-span"> 환불 예정 금액 <br />
								</span> <span class="_150002-span2"> <br />
								</span> <span class="_150002-span3 price">21000원</span>
								</span>
							</div>
						</div>
					</div>
					<div class="order-cancel">
						<div class="div13">반품 / 교환 신청</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<script>
		$(document).ready(
				function() {
					// 세션 스토리지에서 orderDetailInquiry 정보 가져오기
					let orderDetailInquiry = JSON.parse(sessionStorage
							.getItem('orderDetailInquiry'));

					if (orderDetailInquiry) {
			           
			            $('.order-date-data').text(orderDetailInquiry[0].orderDate);
			            $('.order-code-data').text(orderDetailInquiry[0].orderCode);

			            if (orderDetailInquiry[0].products && Array.isArray(orderDetailInquiry[0].products)) {
			            	
			         
			                let itemContainer = $('#item-container');
			                orderDetailInquiry[0].products.forEach(function(product) {
			              
			                	let productHtml = `
			                	    <div class="item">
			                	        <div class="item-checkbox">
			                	            <input type="checkbox" class="item-select" data-index="${product.productCode}" data-user-id="${orderDetailInquiry[0].recipient}">
			                	        </div>
			                	        <img src="${pageContext.request.contextPath}/static/img/product-img.png" class="item-image">
			                	        <div class="item-details">
			                	            <p>\${product.productName}</p>
			                	            <div class="price-container">
			                	                <span class="order-price price">\${product.productPrice}원</span>`;
			                	                
			                	

			                	productHtml += `
			                	            </div>
			                	        </div>
			                	        <div class="v-line"></div>
			                	        <div class="quantity-container">
			                	            <span>수량</span>
			                	            <div class="quantity-control">
			                	                <button class="decrement-btn" data-product-code="\${product.productCode}">-</button>
			                	                <span id="quantity-\${product.productCode}">\${product.orderQuantity}</span>
			                	                <button class="increment-btn" data-product-code="\${product.productCode}">+</button>
			                	            </div>
			                	        </div>
			                	        <div class="v-line"></div>
			                	        <div class="item-price">
			                	            <span>상품금액</span>
			                	            <p class="products price",id="price-\${product.productCode}" data-discounted-price="\${product.productPrice}">\${product.productPrice * product.orderQuantity}원</p>
			                	        </div>
			                	        <div class="v-line"></div>
			                	
			                	    </div>`;

			                    itemContainer.append(productHtml);
			                });
			                
			                itemContainer.on('click', '.decrement-btn', function() {
			                    let productCode = $(this).data('product-code');
			                    console.log("-productCode",productCode);
			                    let quantitySpan = $(`#quantity-${productCode}`);
			                    console.log("quantitySpan",quantitySpan);
			                    let currentQuantity = parseInt(quantitySpan.text());
								
								
			                    if (currentQuantity > 1) {
			                        currentQuantity--;
			                        quantitySpan.text(currentQuantity);
			                        updatePrice(productCode, currentQuantity);
			                    } else {
			                        alert('수량은 0보다 작을 수 없습니다.');
			                    }
			                });

			                itemContainer.on('click', '.increment-btn', function() {
			                	console.log("+currentQuantity",currentQuantity);
			                    let productCode = $(this).data('product-code');
			                    let quantitySpan = $(`#quantity-${productCode}`);
			                    let currentQuantity = parseInt(quantitySpan.text());
			                    
			                    let product = orderDetailInquiry[0].products.find(product => product.productCode === productCode);

			                    if (product && currentQuantity < product.orderQuantity) {
			                        currentQuantity++;
			                        quantitySpan.text(currentQuantity);
			                        updatePrice(productCode, currentQuantity);
			                    } else {
			                        alert('주문 수량보다 클 수 없습니다.');
			                    }
			                });

			                function updatePrice(productCode, quantity) {
			                    let productPrice = parseInt($(`#price-${productCode}`).data('discounted-price'));
			                    let newPrice = productPrice * quantity;
			                    $(`#price-${productCode}`).text(`${newPrice}원`);
			                }
			                
			            } else {
			                console.error('제품 목록이 없습니다.');
			            }
			        } else {
			            alert('주문 정보가 존재하지 않습니다.');
			        }
			    });
		
		function updateTotalPrice() {
	        let totalPrice = 0;
	        let totalItems = 0;
	        let selectedItems = document.querySelectorAll('.item-select:checked');

	        selectedItems.forEach(checkbox => {
	            let parentItem = checkbox.closest('.item');
	            let priceText = parentItem.querySelector('.item-price p').textContent.replace('원', '').trim();
	            let productPrice = parseFloat(priceText.replace(/,/g, ''));
	            totalPrice += productPrice;
	            
	            let quantityElement = parentItem.querySelector('.quantity-control span');
	            if (quantityElement) {
	                let quantity = parseInt(quantityElement.textContent);
	                totalItems += quantity; // 각 선택된 상품의 수량을 총 수량에 더함
	            }
	        });

	        let shippingFee = totalPrice >= 50000 ? 0 : 3000;

	        document.querySelector('.order-subtotal').textContent = totalPrice + '원';
	        document.querySelector('.shipping-price').textContent = shippingFee + '원';
	        document.querySelector('.order-total').textContent = (totalPrice + shippingFee) + '원';
	        
	        document.querySelector('.order-count').textContent = totalItems; // 총 수량 업데이트
	    }

	    function selectAll(selectAllCheckbox) {
	        let checkboxes = document.querySelectorAll('.item-select');
	        checkboxes.forEach(checkbox => {
	            checkbox.checked = selectAllCheckbox.checked;
	        });
	        updateTotalPrice();
	    }

	    

	    /* document.addEventListener('DOMContentLoaded', () => {
	        document.querySelector('#selectAllCheckbox').addEventListener('change', function() {
	            selectAll(this);
	        });
	        document.addEventListener('change', event => {
	            if (event.target.classList.contains('item-select')) {
	                updateTotalPrice();
	            }
	        });
	      
	        
	       
	    }); */
	    
	    document.addEventListener("DOMContentLoaded", function() {
	        // 가격에 쉼표 추가
	        const priceElements = document.querySelectorAll(".price");
	        priceElements.forEach(element => {
	            const priceText = element.textContent.replace(/원/g, '').replace(/,/g, '').trim();
	            const price = parseInt(priceText, 10);
	            if (!isNaN(price)) {
	                element.textContent = formatNumberWithCommas(price) + "원";
	            }
	        });

	        // 'selectAllCheckbox' 체크박스 변경 이벤트 처리
	        document.querySelector('#selectAllCheckbox').addEventListener('change', function() {
	            selectAll(this);
	        });

	        // 'item-select' 클래스를 가진 요소의 변경 이벤트 처리
	        document.addEventListener('change', event => {
	            if (event.target.classList.contains('item-select')) {
	                updateTotalPrice();
	            }
	        });
	    });

	    function formatNumberWithCommas(number) {
	        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }


	  
	    
	   
	</script>
</body>
</html>