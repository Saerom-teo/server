document.addEventListener('DOMContentLoaded', (event) => {
    const uploadContainer = document.getElementById('uploadContainer');
    const placeholder = uploadContainer.querySelector('.placeholder');
    const imagePreviewContainer = document.getElementById('imagePreviewContainer');
    const fileInput = document.getElementById('fileInput');
    const registBtn = document.getElementById('regist-btn');
    let imageCount = 0;

    uploadContainer.addEventListener('dragover', (e) => {
        e.preventDefault();
        uploadContainer.classList.add('dragover');
    });

    uploadContainer.addEventListener('dragleave', () => {
        uploadContainer.classList.remove('dragover');
    });

    uploadContainer.addEventListener('drop', (e) => {
        e.preventDefault();
        uploadContainer.classList.remove('dragover');

        const files = e.dataTransfer.files;
        handleFiles(files);
    });

    uploadContainer.addEventListener('click', () => {
        fileInput.click();
    });

    fileInput.addEventListener('change', (e) => {
        const files = e.target.files;
        handleFiles(files);
    });

    function handleFiles(files) {
        const filesArray = [...files];
        const remainingSlots = 4 - imageCount;

        if (filesArray.length > remainingSlots) {
            alert(`이미지 파일을 ${remainingSlots}개만 더 업로드할 수 있습니다.`);
        }

        filesArray.slice(0, remainingSlots).forEach(file => {
            if (file.type.startsWith('image/')) {
                const reader = new FileReader();
                reader.onload = (e) => {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.classList.add('preview-image');

                    const imgContainer = document.createElement('div');
                    imgContainer.classList.add('image-container');
                    imgContainer.appendChild(img);

                    imagePreviewContainer.appendChild(imgContainer);
                    imageCount++;
                    checkInput(); // Check if all inputs are filled after adding an image
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

    function checkInput() {
        const name = document.getElementById('name').value.trim();
        const phone = document.getElementById('phone').value.trim();
        const address = document.getElementById('address').value.trim();
        const detailAddress = document.getElementById('detailAddress').value.trim();

        if (name && phone && address && detailAddress && imageCount === 4) {
            registBtn.disabled = false;
        } else {
            registBtn.disabled = true;
        }
    }

    document.getElementById('name').addEventListener('input', checkInput);
    document.getElementById('phone').addEventListener('input', checkInput);
    document.getElementById('address').addEventListener('input', checkInput);
    document.getElementById('detailAddress').addEventListener('input', checkInput);
});
