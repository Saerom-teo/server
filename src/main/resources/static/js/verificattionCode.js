document.getElementById('verificationForm').addEventListener('submit', function(event) {
    const codeInput = document.getElementById('code');
    const codeValue = codeInput.value;

    if (codeValue.length !== 6 || isNaN(codeValue)) {
        event.preventDefault();
        alert("유효한 인증번호를 입력해 주세요.");
    }
});

const codeInput = document.getElementById('code');
const submitBtn = document.getElementById('submitBtn');
const timerElement = document.getElementById('timer');
const resendElement = document.getElementById('resend');

codeInput.addEventListener('input', function() {
    if (codeInput.value.length === 6 && !isNaN(codeInput.value)) {
        submitBtn.classList.add('active');
    } else {
        submitBtn.classList.remove('active');
    }
});

// 타이머 설정
let time = 176; // 남은 시간 (초)

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

updateTimer();

// 재전송 버튼 클릭 시 이벤트
resendElement.addEventListener('click', function() {
    if (time === 0) {
        // 재전송 로직 추가
        alert("인증번호를 재전송했습니다.");
        time = 176;
        resendElement.style.color = '#B9B7B7';
        resendElement.style.cursor = 'default';
        updateTimer();
    }
});
