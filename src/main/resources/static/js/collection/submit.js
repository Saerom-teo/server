document.addEventListener('DOMContentLoaded', function () {
    // 입력 검증 초기화
    initInputValidation();

    // 전화번호 입력 시 하이픈 추가 및 검증
    document.getElementById('phone').addEventListener('input', function () {
        formatPhoneNumber(this);
    });

    // 신청하기 버튼 클릭 시
    document.getElementById('regist-btn').addEventListener('click', function () {
        collectFormData();
    });
});

// 입력 검증 초기화 함수
function initInputValidation() {
    const inputs = document.querySelectorAll('#name, #phone, #address, #detailAddress');

    inputs.forEach(input => {
        input.addEventListener('input', checkInput);
    });
}

// 입력값 검증 함수
function checkInput() {
    const name = document.getElementById('name').value.trim();
    const phone = document.getElementById('phone').value.trim();
    const address = document.getElementById('address').value.trim();
    const detailAddress = document.getElementById('detailAddress').value.trim();
    const registBtn = document.getElementById('regist-btn');

    // 모든 입력 필드가 채워졌는지 확인
    if (name && phone && address && detailAddress) {
        registBtn.disabled = false;
    } else {
        registBtn.disabled = true;
    }
}

// 전화번호 형식 추가 및 입력값 검증 함수
function formatPhoneNumber(target) {
    target.value = target.value
        .replace(/[^0-9]/g, '') // 숫자만 남기기
        .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`); // 형식에 맞게 하이픈 추가
    checkInput(); // 전화번호 입력 후 전체 입력값 검증
}

// 폼 데이터 수집 함수
function collectFormData() {
    const name = document.getElementById('name').value.trim();
    const phone = document.getElementById('phone').value.trim();
    const address = document.getElementById('address').value.trim();
    const detailAddress = document.getElementById('detailAddress').value.trim();

    const formData = {
        name: name,
        phone: phone,
        address: address,
        detailAddress: detailAddress
    };

    // service.js의 함수 호출하여 데이터 전송
    sendFormData(formData);
}
