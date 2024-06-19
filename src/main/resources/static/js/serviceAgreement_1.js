$(document).ready(function() {
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

    // 모달 열기 함수
    window.openModal = function(contentType) {
        const $modal = $('#modal');
        const $modalText = $('#modal-text');

        let url = '';
        // contentType에 따라 요청할 URL 설정
        switch (contentType) {
            case 'serviceTOS':
                url = 'TOS/serviceTOS';
                break;
            case 'personalTOS':
                url = 'TOS/personalTOS';
                break;
            case 'marketingTOS':
                url = 'TOS/marketingTOS';
                break;
            case 'thirdPartyTOS':
                url = 'TOS/thirdPartyTOS';
                break;
        }

        // AJAX 요청으로 URL의 내용을 모달에 표시
        $.get(url, function(data) {
            $modalText.html(data); // 모달 텍스트 업데이트
            $modal.css('display', 'flex'); // 모달 표시
        }).fail(function() {
            console.error('Error fetching modal content'); // 에러 처리
        });
    }

    // 모달 닫기 함수
    window.closeModal = function() {
        $('#modal').css('display', 'none'); // 모달 숨기기
    }

    // 모달 바깥을 클릭하면 모달 닫기
    $(window).on('click', function(event) {
        if (event.target.id === 'modal') {
            closeModal();
        }
    });

    // 폼 제출 시 필수 체크박스 체크 여부 확인
    $('#agreementForm').on('submit', function(event) {
        if ($requiredCheckboxes.filter(':checked').length !== $requiredCheckboxes.length) {
            event.preventDefault(); // 제출 막기
            alert("동의하지 않으면 회원가입이 불가능합니다."); // 경고 메시지
        }
    });
});