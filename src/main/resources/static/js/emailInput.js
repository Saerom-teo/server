// 폼 제출 시 이메일 형식 확인
document.getElementById('email').addEventListener('input', function(event) {
    const emailInput = event.target;
    const emailValue = emailInput.value;
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const emailFormatText = document.getElementById('emailFormatText');
    const emailCheckIcon = document.getElementById('emailCheckIcon');
    const submitBtn = document.getElementById('submitBtn');

    if (emailPattern.test(emailValue)) {
        emailFormatText.classList.add('valid');
        emailCheckIcon.classList.add('valid');
        submitBtn.classList.add('active');
        submitBtn.disabled = false;
    } else {
        emailFormatText.classList.remove('valid');
        emailCheckIcon.classList.remove('valid');
        submitBtn.classList.remove('active');
        submitBtn.disabled = true;
    }
});

document.getElementById('emailForm').addEventListener('submit', function(event) {
    const emailInput = document.getElementById('email');
    const emailValue = emailInput.value;

    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(emailValue)) {
        event.preventDefault();
        alert("유효한 이메일 형식을 입력해 주세요.");
    }
});
