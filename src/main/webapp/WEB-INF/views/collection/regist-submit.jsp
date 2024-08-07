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
    
    <script src="https://code.jquery.com/jquery-3.4.1.js" defer></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js" defer></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    
	<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
    <title>올레픽 신청하기 | 새롬터</title>
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
                    <button onclick="pay(this)">카카오페이로 결제</button>
                    <button onclick="pay(this)">일반결제</button>
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
    
    <script>
	    
    
    function requestPay(pg, payMethod, url,amount) {
  	 
    	const IMP = window.IMP;
    	IMP.init("imp22804754");

    	const today = new Date();
    	const hours = today.getHours(); // 시
    	const minutes = today.getMinutes(); // 분
    	const seconds = today.getSeconds(); // 초
    	const milliseconds = today.getMilliseconds();
    	const makeMerchantUid = hours + minutes + seconds + milliseconds;
    	
    	const name = $('#name').val();
        const phone = $('#phone').val();
        const address = $('#address').val();
        const detailAddress = $('#detailAddress').val();
        
	    IMP.request_pay({
	        pg : pg,
	        pay_method : payMethod,
	        merchant_uid: "IMP" + makeMerchantUid,
	        name : '올레픽 보증금 결제',
	        amount : amount,
	        buyer_email : 'iamport@siot.do',
	        buyer_name : name,
	        buyer_tel : phone,
	        buyer_addr : address + ' ' + detailAddress,
	        buyer_postcode : '123-456'
	    }, function(rsp) { 
				if(rsp.success){
					alert("결제 성공!");
				} else{
					var msg = '결제에 실패하였습니다.';
                    msg += rsp.error_msg;
                    alert(msg);
				}
	    });
	    
    }
        function checkFields() {
            const name = $('#name').val();
            const phone = $('#phone').val();
            const address = $('#address').val();
            const detailAddress = $('#detailAddress').val();

            if (name && phone && address && detailAddress) {
                $('#regist-btn').prop('disabled', false);
                return true;
            } else {
                $('#regist-btn').prop('disabled', true);
                return false;
            }
        }
        
        function pay(button) {
        	if (checkFields()){
        		const buttonText = button.innerText;
                if (buttonText === "카카오페이로 결제") {
                    requestPay('kakaopay.TC0ONETIME', 'kakaopay', '${path}/payments/kakaoPay', 5000);
                } else if (buttonText === "일반결제") {
                    requestPay('html5_inicis.INIpayTest', 'card', '${path}/payments/creditCard', 5000);
                } 
        	}
        	else{
        		alert("배송지 정보를 입력해주세요.");
        	}
        	
	    }
        

        $(document).ready(function() {
            $.ajax({
                url: '${pageContext.request.contextPath}/api/collection/read-user',
                type: 'GET',
                success: function(response) {
                    $('#name').val(response.userRealName).prop('readonly', false);
                    $('#phone').val(response.userPhone).prop('readonly', false);
                    $('#address').val(response.userAddress).prop('readonly', false);
                    $('#detailAddress').val(response.userDetailAddress).prop('readonly', false);
                    checkFields(); // 초기 값 체크
                },
                error: function(error) {
                    console.log('Error:', error);
                }
            });

            $('#name, #phone, #address, #detailAddress').on('input', checkFields);
        });
    </script>
</body>

</html>
