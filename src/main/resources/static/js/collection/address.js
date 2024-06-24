document.addEventListener('DOMContentLoaded', function () {
    // 주소 모달 초기화
    initAddressModal();

    // 주소 모달 열기
    document.getElementById('open-modal-btn').addEventListener('click', function () {
        openAddressModal();
    });

    // 주소 모달 닫기
    document.querySelector('.close').addEventListener('click', function () {
        closeAddressModal();
    });

    // 모달 외부 클릭 시 닫기
    window.addEventListener('click', function (event) {
        if (event.target.id === 'address-modal') {
            closeAddressModal();
        }
    });
});

// 주소 모달 초기화 함수
function initAddressModal() {
    var element_wrap = document.getElementById('wrap');

    // Daum 주소 API 실행 함수
    function execDaumPostcode() {
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function (data) {
                var addr = '';

                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }

                document.getElementById("address").value = addr;
                document.getElementById("detailAddress").focus();

                element_wrap.style.display = 'none';
                document.getElementById('address-modal').style.display = 'none';

                document.body.scrollTop = currentScroll;
            },
            onresize: function (size) {
                element_wrap.style.height = size.height + 'px';
            },
            width: '100%',
            height: '100%'
        }).embed(element_wrap);

        element_wrap.style.display = 'block';
    }

    // 전역 함수로 노출
    window.execDaumPostcode = execDaumPostcode;
}

// 주소 모달 열기 함수
function openAddressModal() {
    document.getElementById('address-modal').style.display = 'block';
    window.execDaumPostcode();
}

// 주소 모달 닫기 함수
function closeAddressModal() {
    document.getElementById('address-modal').style.display = 'none';
}
