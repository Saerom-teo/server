document.addEventListener('DOMContentLoaded', (event) => {
    const uploadContainer = document.getElementById('uploadContainer');
    const placeholder = uploadContainer.querySelector('.placeholder');
    const imagePreviewContainer = document.getElementById('imagePreviewContainer');

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

    function handleFiles(files) {
        [...files].forEach(file => {
            if (file.type.startsWith('image/')) {
                const reader = new FileReader();
                reader.onload = (e) => {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    imagePreviewContainer.appendChild(img);
                };
                reader.readAsDataURL(file);
            } else {
                alert('Please drop a valid image file.');
            }
        });
        placeholder.style.display = 'none';
    }
});
