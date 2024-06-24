document.addEventListener('DOMContentLoaded', function () {
    // 초기화 함수 호출
    initImageUpload();

    // 입력값 검증 초기화
    initInputValidation();

    document.getElementById('regist-btn').addEventListener('click', function () {
        collectFormData();
    });
});

// 이미지 업로드 초기화 함수
function initImageUpload() {
    const uploadContainer = document.getElementById('uploadContainer');
    const placeholder = uploadContainer.querySelector('.placeholder');
    const imagePreviewContainer = document.getElementById('imagePreviewContainer');
    const fileInput = document.getElementById('fileInput');
    let imageCount = 0;

    // 드래그 오버 이벤트 처리
    uploadContainer.addEventListener('dragover', function (e) {
        e.preventDefault();
        uploadContainer.classList.add('dragover');
    });

    // 드래그 리브 이벤트 처리
    uploadContainer.addEventListener('dragleave', function () {
        uploadContainer.classList.remove('dragover');
    });

    // 드랍 이벤트 처리
    uploadContainer.addEventListener('drop', function (e) {
        e.preventDefault();
        uploadContainer.classList.remove('dragover');
        handleFiles(e.dataTransfer.files);
    });

    // 클릭 이벤트 처리
    uploadContainer.addEventListener('click', function () {
        fileInput.click();
    });

    // 파일 선택 이벤트 처리
    fileInput.addEventListener('change', function (e) {
        handleFiles(e.target.files);
    });

    // 파일 처리 함수
    function handleFiles(files) {
        const filesArray = Array.from(files);
        const remainingSlots = 4 - imageCount;

        if (filesArray.length > remainingSlots) {
            alert(`이미지 파일을 ${remainingSlots}개만 더 업로드할 수 있습니다.`);
        }

        filesArray.slice(0, remainingSlots).forEach(file => {
            if (file.type.startsWith('image/')) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    createImagePreview(e.target.result, file);
                    imageCount++;
                    checkInput(); // 이미지 추가 후 입력값 검증
                };
                reader.readAsDataURL(file);
            } else {
                alert('유효한 이미지 파일을 선택해주세요.');
            }
        });

        if (imageCount >= 4) {
            placeholder.style.display = 'none';
        }
    }

    // 이미지 미리보기 생성 함수
    function createImagePreview(imageSrc, file) {
        const img = document.createElement('img');
        img.src = imageSrc;
        img.classList.add('preview-image');
        img.dataset.fileName = file.name; // 파일 이름 저장

        const imgContainer = document.createElement('div');
        imgContainer.classList.add('image-container');
        imgContainer.appendChild(img);

        imagePreviewContainer.appendChild(imgContainer);
    }
}

// 입력값 검증 초기화 함수
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
    const imageCount = document.querySelectorAll('.preview-image').length;

    // 모든 입력 필드와 이미지 파일이 채워졌는지 확인
    if (name && phone && address && detailAddress && imageCount === 4) {
        registBtn.disabled = false;
    } else {
        registBtn.disabled = true;
    }
}

// 폼 데이터 수집 함수
function collectFormData() {
    const name = document.getElementById('name').value.trim();
    const phone = document.getElementById('phone').value.trim();
    const address = document.getElementById('address').value.trim();
    const detailAddress = document.getElementById('detailAddress').value.trim();
    const imageElements = document.querySelectorAll('.preview-image');

    const formData = new FormData();
    formData.append('name', name);
    formData.append('phone', phone);
    formData.append('address', address);
    formData.append('detailAddress', detailAddress);

    imageElements.forEach((img, index) => {
        const file = dataURLtoFile(img.src, img.dataset.fileName);
        formData.append('images', file); // 'images'라는 이름으로 파일 추가
    });

    // service.js의 함수 호출하여 데이터 전송
    sendRequestData(formData);
}

// dataURL을 파일 객체로 변환하는 함수
function dataURLtoFile(dataurl, filename) {
    var arr = dataurl.split(','), mime = arr[0].match(/:(.*?);/)[1], bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
    while (n--) {
        u8arr[n] = bstr.charCodeAt(n);
    }
    return new File([u8arr], filename, {type: mime});
}
