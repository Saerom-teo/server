<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/product-detail-review.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>상품상세 | 새롬터</title>
<style>
    .shop-detail {
        margin-top: var(--header-size);
    }
</style>
</head>
<body>

    <%@ include file="/WEB-INF/views/collection/header.jsp" %>

    <div class="shop-detail">
        <div class ="cate">
            <!-- 카테고리 경로 표시 -->
            <c:if test="${not empty categoryList}">
                <c:forEach var="category" items="${categoryList}">
                    <div class="path">${category.majorCategory} > ${category.middleCategory} > <p style="color: #499268; font-weight: 500;">&nbsp;${category.smallCategory}</p></div>
                </c:forEach>
            </c:if>
            <div class="line"></div>
        </div>

        <div class="body">
            <div class="first">
                <img class="_1-15487" src="${pageContext.request.contextPath}/static/img/product-img.png" />
                <div class="explanation">
                    <div class="ex-title">
                        <div class="div">${product.productName}</div>
                        <div class="price-container">
                            <div>
                                <c:if test="${product.discountRate > 0}">
                                    <!-- 할인율 % 표시 -->
                                    <div class="percent">
                                        <c:set var="discountRateInt" value="${product.discountRate * 100}" />
                                        <c:out value="[${fn:substringBefore(discountRateInt, '.')}%]" />
                                    </div>
                                </c:if>
                                <div class="price-container-span">&nbsp;${product.discountedPrice}원</div>
                                <c:if test="${product.discountRate > 0}">
                                    <div class="price-container-span2">&nbsp;${product.productPrice}원</div>
                                </c:if>
                            </div>
                            <div class="sale_best">
                                <c:if test="${product.discountRate > 0}">
                                    <span class="sale">SALE</span>
                                </c:if>
                                <!-- wishCount가 1 이상인 경우에만 BEST 표시 -->
                                <c:if test="${product.wishCount > 0}">
                                    <span class="best">BEST</span>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="ex-body-1">
                        <!-- 환경 인증 마크가 있을 때만 출력 -->
                        <c:if test="${not empty product.envMark}">
                            <div class="div2">***${product.envMark}를 받은 제품입니다.</div>
                        </c:if>
                        <div class="_3-000-50-000">
                            <span>
                                <span class="_3-000-50-000-span">원산지</span> <span class="_3-000-50-000-span2"> 대한민국 <br /></span>
                                <span class="_3-000-50-000-span3">브랜드</span> <span class="_3-000-50-000-span4">${product.brand}<br /></span>
                                <span class="_3-000-50-000-span5">배송 방법</span> <span class="_3-000-50-000-span6"> 택배 <br /></span>
                                <span class="_3-000-50-000-span7">배송비</span> <span class="_3-000-50-000-span8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3,000원 (50,000원 이상 무료배송) | 도서산간 배송비 추가 </span>
                            </span>
                        </div>
                        <div class="frame-114">
                            <div class="div3">수량</div>
                            <div class="frame-115">
                                <div class="frame-116">
                                    <div class="frame-117" id="quantity-decrease">
                                        <div class="div4">-</div>
                                    </div>
                                    <div class="frame-118">
                                        <div class="_1" id="quantity">1</div>
                                    </div>
                                    <div class="frame-119" id="quantity-increase">
                                        <div class="div4">+</div>
                                    </div>
                                </div>
                                <div class="_4000" id="total-price">${product.discountedPrice}원</div>
                            </div>
                        </div>
                    </div>
                    <div class="ex-body-2">
                        <div class="_12">총 상품금액 (<span id="total-quantity">1</span>개)</div>
                        <div class="_40002" id="grand-total">${product.discountedPrice}원</div>
                    </div>
                    <div class="ex-footer">
                        <div class="frame-110" id="buy-now">
                            <div class="div5">주문하기</div>
                        </div>
                        <div class="frame-111" id="add-to-cart">
                            <div class="div6">장바구니</div>
                        </div>
                        <!-- 위시리스트 버튼 -->
                        <img class="frame-112" id="add-to-wish" src="${pageContext.request.contextPath}/static/img/hart.svg" />
                    </div>
                </div>
            </div>
            <div class="shop-detail-box">
                <div class="button-1">
                    <div class="div7" onclick="location.href='${pageContext.request.contextPath}/products/${product.productCode}'">상품 상세</div>
                </div>
                <div class="button-2" onclick="location.href='${pageContext.request.contextPath}/products/review/${product.productCode}'">
                    <div class="div8">상품 후기</div>
                </div>
            </div>
            <div class="detail-image">
                <img class="image-29" src="${pageContext.request.contextPath}/static/img/detail-img.png" />
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/collection/footer.jsp"%>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const quantityDecrease = document.getElementById('quantity-decrease');
            const quantityIncrease = document.getElementById('quantity-increase');
            const quantityDisplay = document.getElementById('quantity');
            const totalQuantityDisplay = document.getElementById('total-quantity');
            const totalPriceDisplay = document.getElementById('total-price');
            const grandTotalDisplay = document.getElementById('grand-total');
            const addToCartButton = document.getElementById('add-to-cart');
            const addToWishButton = document.getElementById('add-to-wish');
            const buyNowButton = document.getElementById('buy-now'); // 주문하기 버튼
            const productPrice = ${product.discountedPrice};
            const productCode = '${product.productCode}'; // productCode를 문자열로 수정
            let userId;
            
            let quantity = 1;
            
            // 사용자 ID 가져오기
            fetch('${pageContext.request.contextPath}/mypage/basket/getUserId', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                userId = data; // userId를 전역 변수에 설정
                loadWishState(); // 초기 상태 로드
            })
            .catch(error => {
                console.error('Error:', error);
            });

           

            quantityDecrease.addEventListener('click', function() {
                if (quantity > 1) {
                    quantity--;
                    updateQuantity();
                }
            });

            quantityIncrease.addEventListener('click', function() {
                quantity++;
                updateQuantity();
            });

            addToCartButton.addEventListener('click', function() {
                addToCart(productCode, userId, quantity); // productCode를 변수로 사용
            });

            addToWishButton.addEventListener('click', function() {
                toggleWishState();        
            });

            buyNowButton.addEventListener('click', function() {
                sendOrderData(); // 주문하기 버튼 클릭 시 데이터 전송
            });

            function updateQuantity() {
                quantityDisplay.textContent = quantity;
                totalQuantityDisplay.textContent = quantity;
                const totalPrice = productPrice * quantity;
                totalPriceDisplay.textContent = totalPrice.toLocaleString() + '원';
                grandTotalDisplay.textContent = totalPrice.toLocaleString() + '원';
            }
            
            /* 위시리스트 하트 버튼 toggle */
            function toggleWishState() {
                if (addToWishButton.src.includes('heart_btn.svg')) { 
                    deleteWishData(); // 하트 해제 시 삭제 요청
                    addToWishButton.src = `${pageContext.request.contextPath}/static/img/hart.svg`;
                } else {
                    addToWish(productCode, userId); // 하트 설정 시 추가 요청
                    addToWishButton.src = `${pageContext.request.contextPath}/static/img/heart_btn.svg`;
                }
            }

            /* 초기 로드 시 서버에서 위시리스트 상태 불러오기 */
            function loadWishState() {
            	
            	const url = '${pageContext.request.contextPath}/mypage/wishlist/check/' + productCode + '/' + userId; 
            	
                fetch('${pageContext.request.contextPath}/mypage/wishlist/check/' + productCode + '/' + userId, { 
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .then(response => response.text())
                .then(data => {
                	const exists = data === 'true';
                    if (exists) { // 서버에서 위시리스트 상태를 받아와 하트 이미지 설정
                        addToWishButton.src = `${pageContext.request.contextPath}/static/img/heart_btn.svg`;
                    } else {
                        addToWishButton.src = `${pageContext.request.contextPath}/static/img/hart.svg`;
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });  
            }
            
            /* 위시리스트에 해당 상품 추가 */
            function addToWish(productCode, userId) {
                const wishlistRequest = {
                    productCode: productCode,
                    userId: userId
                };
                fetch('${pageContext.request.contextPath}/mypage/wishlist/insertWishlist', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(wishlistRequest)
                })
                .then(response => {
                    if (response.ok) {
                        addToWishButton.src = `${pageContext.request.contextPath}/static/img/heart_btn.svg`; // 추가 후 하트 이미지 변경
                    } else if (response.status === 409) {
                        alert('위시리스트에 이미 존재하는 상품입니다.');
                    } else {
                        return response.text().then(text => {
                            console.error('Error:', text);
                            alert('위시리스트에 상품을 추가하는데 실패했습니다.');
                        });
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('위시리스트에 상품을 추가하는데 실패했습니다.');
                });
            }
            
            /* 위시리스트에서 해당 상품 삭제 */
            function deleteWishData() {
                const url = '${pageContext.request.contextPath}/mypage/wishlist/delete/' + productCode + '/' + userId;
                
                fetch(url, {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .then(response => {
                    if (response.ok) {
                        addToWishButton.src = `${pageContext.request.contextPath}/static/img/hart.svg`; // 삭제 후 하트 이미지 변경
                    } else {
                        return response.text().then(text => {
                            console.error('Error:', text);
                            alert('삭제 중 오류가 발생했습니다: ' + text);
                        });
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('삭제 중 오류가 발생했습니다: ' + error);
                });
            }
            
            /* 장바구니에 해당 상품 추가 */
            function addToCart(productCode, userId, quantity) {
                const basketRequest = {
                    productCode: productCode,
                    userId: userId,
                    productQuantity: quantity
                };
                
                console.log(basketRequest);
                fetch('${pageContext.request.contextPath}/mypage/basket/insertBasket', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(basketRequest)
                })
                .then(response => {
                    if (response.ok) {
                        window.location.href = '${pageContext.request.contextPath}/mypage/basket';
                    } else {
                        return response.text().then(text => {
                            console.error('Error:', text);
                            alert('장바구니에 상품을 추가하는데 실패했습니다.');
                        });
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('장바구니에 상품을 추가하는데 실패했습니다.');
                });
            }
            
            function loadCart(userId) {
                fetch(`${pageContext.request.contextPath}/basket/readByUserId/${userId}`, {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .then(response => response.json())
                .then(data => {
                    console.log('User Cart:', data);
                    // 불러온 장바구니 데이터를 이용 UI 업데이트 로직 추가
                })
                .catch(error => console.error('Error:', error));
            }
            
            /* 주문하기 -> 상품 데이터 전송 */
            function sendOrderData() {
                const orderItem = {
                    productCode: productCode,
                    productName: '${product.productName}',
                    orderQuantity: quantity,
                    productPrice: ${product.productPrice},
                    orderPrice: productPrice * quantity,
                    orderCode: null
                };

                const orderDetailRequest = {
                    products: [orderItem],
                    shippingPrice: productPrice * quantity >= 50000 ? 0 : 3000,
                    totalOrderPrice: productPrice * quantity >= 50000 ? productPrice * quantity : productPrice * quantity + 3000
                };

                console.log('Order Detail Request:', orderDetailRequest);

                fetch('${pageContext.request.contextPath}/order/createOrderAndProducts', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(orderDetailRequest)
                })
                .then(response => {
                    if (response.ok) {
                        window.location.href = '${pageContext.request.contextPath}/order/orderpage';
                    } else {
                        return response.json().then(errorData => {
                            console.error('Error:', errorData);
                        });
                    }
                })
                .catch(error => console.error('Error:', error));
            }
        });
    </script>
</body>
</html>
 