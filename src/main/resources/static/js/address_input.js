function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = '';

            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우
                addr = data.jibunAddress;
            }

            // 주소 정보를 해당 필드에 입력합니다.
            document.getElementById("address").value = addr + ' (' + data.zonecode + ')';
            
            // 상세 주소 필드로 포커스를 이동합니다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}