document.addEventListener("DOMContentLoaded", function() {
    const codeInput = document.getElementById('code');
    const submitBtn = document.getElementById('submitBtn');
    const timerElement = document.getElementById('timer');
    const resendElement = document.getElementById('resend');
    let time = 176; // 남은 시간 (초)

    // 폼 제출 이벤트
    document.getElementById('verificationForm').addEventListener('submit', function(event) {
        const codeValue = codeInput.value;

        if (codeValue.length !== 6 || isNaN(codeValue)) {
            event.preventDefault();
            alert("유효한 인증번호를 입력해 주세요.");
        }
    });

    // 인증번호 입력 필드 설정
    codeInput.setAttribute("maxlength", "6");
    codeInput.setAttribute("inputmode", "numeric");
    codeInput.addEventListener('input', function() {
        if (codeInput.value.length === 6 && !isNaN(codeInput.value)) {
            submitBtn.classList.add('active');
            submitBtn.removeAttribute("disabled");
        } else {
            submitBtn.classList.remove('active');
            submitBtn.setAttribute("disabled", "disabled");
        }
    });

    // 타이머 업데이트 함수
    function updateTimer() {
        const minutes = Math.floor(time / 60);
        const seconds = time % 60;
        timerElement.textContent = `남은시간 ${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;

        if (time > 0) {
            time--;
            setTimeout(updateTimer, 1000);
        } else {
            resendElement.style.color = '#499268';
            resendElement.style.cursor = 'pointer';
        }
    }

    // 초기 타이머 시작
    updateTimer();

    // 재전송 버튼 클릭 이벤트
    resendElement.addEventListener('click', function() {
        if (time === 0) {
            // 재전송 로직 추가
            fetch('/registration/reSend', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                },
                credentials: 'include' // 세션 정보를 포함하여 서버에 요청
            })
            .then(response => {
                if (response.ok) {
                    alert("인증번호를 재전송했습니다.");
                    time = 176;
                    resendElement.style.color = '#B9B7B7';
                    resendElement.style.cursor = 'default';
                    updateTimer();
                } else {
                    alert("인증번호 재전송에 실패했습니다.");
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("인증번호 재전송 중 오류가 발생했습니다.");
            });
        }
    });
});
