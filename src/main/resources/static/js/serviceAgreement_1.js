function openModal(contentType) {
    const modal = document.getElementById("modal");
    const modalText = document.getElementById("modal-text");

    let url = "";
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

    fetch(url)
        .then(response => response.text())
        .then(data => {
            modalText.innerHTML = data;
            modal.style.display = "flex";
        })
        .catch(error => {
            console.error('Error fetching modal content:', error);
        });
}

function closeModal() {
    const modal = document.getElementById("modal");
    modal.style.display = "none";
}

// 모달을 클릭하면 닫히도록 설정
window.onclick = function(event) {
    const modal = document.getElementById("modal");
    if (event.target === modal) {
        closeModal();
    }
}

// 폼 제출 시 처리
document.getElementById('agreementForm').addEventListener('submit', function(event) {
    const serviceTOS = document.querySelector('input[name="serviceTOS"]');
    const personalTOS = document.querySelector('input[name="personalTOS"]');
    if (!serviceTOS.checked || !personalTOS.checked) {
        event.preventDefault();
        alert("동의하지 않으면 회원가입이 불가능합니다.");
    }
});
