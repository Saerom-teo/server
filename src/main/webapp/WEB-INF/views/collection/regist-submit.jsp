<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/collection.css">
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/collection/address.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/collection/submit.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/collection/service.js"></script>
    
    <title>Document</title>
</head>

<body>
    <div class="modal-background">
        <div class="submit-container" id="regist-container">
            <h3>올레픽 신청하기</h3>
            <p id="info">플라스틱 수거를 위해 성함과 전화번호, 주소를 입력해 주세요.
                또한 지정 수거함을 지급해 드리기 위해 보증금을 결제해 주세요.</p>

            <div>
                <p>이름</p>
                <input id="name" type="text" placeholder="이름을 입력해 주세요" autocomplete='off'><br>
                <a>본인 이름을 입력해주세요.</a>
            </div>
            <div>
                <p>휴대전화 번호</p>
                <input id="phone" type="text" placeholder="휴대전화 번호를 입력해주세요" maxlength="13" autocomplete='off'><br>
                <a>휴대전화 번호는 숫자로만 입력해주세요.</a>
            </div>
            <div>
                <p>주소</p>
                <div id="address-input-1">
                    <input type="text" id="address" placeholder="주소를 입력해 주세요" autocomplete='off'>
                    <button id="open-modal-btn" class="btn-green">주소입력</button>
                </div>
                <input type="text" id="detailAddress" placeholder="상세주소를 입력해 주세요" autocomplete='off'>
            </div>
            <div id="payment">
                <p>보증금 결제</p>
                <div>
                    <button>카카오페이로 결제</button>
                    <button>일반결제</button>
                </div>
                <a>수거함을 받으시려면 보증금이 필요합니다. 추후 수거함 반납 시 돌려드립니다.</a>
            </div>

            <button id="regist-btn" class="btn-green" disabled>신청하기</button>
        </div>
    </div>

    <!-- address modal -->
    <div id="address-modal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>주소 입력</h2>
            <div id="wrap"></div>
        </div>
    </div>

</body>

</html>
