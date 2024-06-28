$(document).ready(function() {
    const codeInput = $('#code');
    const submitBtn = $('#submitBtn');
    const timerElement = $('#timer');
    const resendElement = $('#resend');
    
    let time = 180; // 초기 남은 시간 (초)
    
    // 타이머 업데이트 함수
    function updateTimer() {
        const minutes = Math.floor(time / 60);
        const seconds = time % 60;
        timerElement.text(`남은시간 ${minutes}:${seconds < 10 ? '0' : ''}${seconds}`);

        if (time > 0) {
            time--;
            setTimeout(updateTimer, 1000);
        } else {
            resendElement.addClass('active');
        }
    }

    // 초기 타이머 시작
    updateTimer();

    // 재전송 버튼 클릭 이벤트
    resendElement.click(function() {
        if (time === 0) {
            // 재전송 로직 추가
            $.ajax({
                url: '<%=request.getContextPath()%>/registration/reSend',
                type: 'GET',
                success: function(response) {
                    if (response.success) {
                        alert("인증번호를 재전송했습니다.");
                        time = 176; // 타이머 시간 초기화
                        resendElement.removeClass('active');
                        updateTimer(); // 타이머 재시작
                    } else {
                        alert("인증번호 재전송에 실패했습니다.");
                    }
                },
                error: function() {
                    alert("인증번호 재전송 중 오류가 발생했습니다.");
                }
            });
        }
    });

    // 인증번호 입력 필드 설정
    codeInput.attr("maxlength", "6");
    codeInput.attr("inputmode", "numeric");

    // 인증번호 입력 이벤트 처리
    codeInput.on('input', function() {
        const codeValue = codeInput.val().trim();

        if (codeValue.length === 6 && /^\d+$/.test(codeValue)) {
            submitBtn.addClass('active').prop('disabled', false);
        } else {
            submitBtn.removeClass('active').prop('disabled', true);
        }
    });

    // 폼 제출 이벤트 처리
    $('#verificationForm').submit(function(event) {
        event.preventDefault(); // 기본 폼 제출을 막음
        const codeValue = codeInput.val().trim();

        if (codeValue.length !== 6 || !/^\d+$/.test(codeValue)) {
            alert("유효한 인증번호를 입력해 주세요.");
            return;
        }

        // 서버로 인증번호를 제출
        $.ajax({
            url: 'verification-process',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ code: codeValue }),
            success: function(response) {
                if (response.success) {
                    // 인증 성공 시 다음 페이지로 이동
                    $('<form action="passwordInput" method="post">' +
                    '<input type="hidden" name="verificationCode" value="' + codeValue + '">' +
                    '</form>').appendTo('body').submit();
                } else {
                    alert('인증번호가 올바르지 않습니다. 다시 시도해 주세요.');
                }
            },
            error: function() {
                alert('서버와의 통신 중 오류가 발생했습니다.');
            }
        });
    });

    // 초기 로딩 상태에서 버튼 초기화
    submitBtn.prop('disabled', true);
});