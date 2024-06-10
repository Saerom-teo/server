<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout Page</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <h1>주문/결제</h1>
    </header>
    <main>
        <section class="delivery">
            <h2>배송지</h2>
            <div class="address">
                <p>성명지</p>
                <p>010-1234-5678</p>
                <p>서울특별시 강남구 영동대로 123 (청담동, 현대홈타운) 105-501 (105741)</p>
                <button>변경하기</button>
            </div>
        </section>
        <section class="order">
            <h2>주문상품</h2>
            <div class="product">
                <img src="product-image.jpg" alt="상품 이미지">
                <div class="product-info">
                    <p>포트리스 유산균</p>
                    <p>수량: 1개</p>
                    <p>단일 가격: 10,000원</p>
                </div>
            </div>
            <div class="total-price">
                <p>총 주문금액</p>
                <p>10,000원</p>
            </div>
        </section>
        <section class="payment">
            <div class="payment-details">
                <h2>결제상세</h2>
                <p>일반 결제: 9,000원</p>
                <p>사용한 포인트: 1,000P</p>
            </div>
            <button class="pay-button">8,000원 결제하기</button>
        </section>
        <section class="shipping-fee">
            <h2>배송비</h2>
            <p>3,000원 (50,000원 이상 구매 시 무료)</p>
        </section>
        <section class="points">
            <h2>포인트</h2>
            <input type="text" placeholder="포인트 입력">
            <button>적용하기</button>
        </section>
        <section class="payment-method">
            <h2>결제수단</h2>
            <label>
                <input type="radio" name="payment" value="카카오페이 결제"> 카카오페이 결제
            </label>
            <label>
                <input type="radio" name="payment" value="일반결제"> 일반결제
            </label>
        </section>
    </main>
    <footer>
        <div class="footer-links">
            <p>이용약관</p>
            <p>개인정보 처리 방침</p>
            <p>전자금융거래약관</p>
        </div>
        <div class="footer-info">
            <p>상호명: (주)포트리스클라우드 | 주소: 서울특별시 강남구 영동대로 123 (청담동) 현대홈타운 105-501</p>
            <p>전화번호: 02-1234-5678 | 이메일: support@example.com</p>
        </div>
        <div class="footer-social">
            <img src="facebook-icon.png" alt="Facebook">
            <img src="instagram-icon.png" alt="Instagram">
            <img src="twitter-icon.png" alt="Twitter">
        </div>
    </footer>
</body>
</html>
