$(document).ready(function() {

    $('#agreementForm').attr('action', baseUrl + '/auth/registration/emailInput');

    const $submitBtn = $('#agreementForm button[type="submit"]');
    const $requiredCheckboxes = $('input[name="serviceTOS"], input[name="personalTOS"]');

    // 초기 상태에서 체크 여부에 따라 버튼 상태 설정
    toggleButtonState();

    // 체크박스 변경 시 버튼 상태 업데이트
    $requiredCheckboxes.on('change', toggleButtonState);

    // 체크박스 상태에 따라 버튼 활성화/비활성화
    function toggleButtonState() {
        // 모든 필수 체크박스가 체크된 경우
        if ($requiredCheckboxes.filter(':checked').length === $requiredCheckboxes.length) {
            console.log("button enabled");
            $submitBtn.addClass('active').prop('disabled', false); // 버튼 활성화
        } else {
            console.log("button disabled");
            $submitBtn.removeClass('active').prop('disabled', true); // 버튼 비활성화
        }
    }
    // 폼 제출 시 필수 체크박스 체크 여부 확인
    $('#agreementForm').on('submit', function(event) {
        if ($requiredCheckboxes.filter(':checked').length !== $requiredCheckboxes.length) {
            event.preventDefault(); // 제출 막기
            alert("동의하지 않으면 회원가입이 불가능합니다."); // 경고 메시지
        }
    });
});