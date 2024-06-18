<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/address_input.js"></script>
    <style>
        .upload-container {
            width: 300px;
            height: 200px;
            border: 2px dashed #ccc;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            margin: 20px auto;
            position: relative;
            flex-direction: column;
            overflow: hidden;
        }

        .upload-container.dragover {
            border-color: #333;
        }

        .upload-container .placeholder {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 16px;
            color: #ccc;
        }

        .image-preview-container {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            overflow-x: auto;
            width: 100%;
            height: 100%;
        }

        .image-preview-container img {
            max-width: 100px;
            max-height: 100px;
            margin: 5px;
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', (event) => {
            const uploadContainer = document.getElementById('uploadContainer');
            const placeholder = uploadContainer.querySelector('.placeholder');
            const imagePreviewContainer = document.getElementById('imagePreviewContainer');
            const form = document.querySelector('form');
            let uploadedFiles = [];

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
                        uploadedFiles.push(file);
                    } else {
                        alert('Please drop a valid image file.');
                    }
                });
                placeholder.style.display = 'none';
            }

            form.addEventListener('submit', (e) => {
                e.preventDefault();
                const formData = new FormData(form);

                uploadedFiles.forEach((file, index) => {
                    formData.append('images', file);
                });

                fetch(form.action, {
                    method: 'POST',
                    body: formData
                }).then(response => response.text())
                .then(data => {
                    alert('Submission successful');
                    console.log(data);
                }).catch(error => {
                    alert('Submission failed');
                    console.error(error);
                });
            });
        });
    </script>
</head>

<body>
    <h1>올레픽 수거 요청하기</h1>
    <form action="../api/collection/request" method="post" enctype="multipart/form-data">
        <input type="text" id="name" name="name" placeholder="이름" value="홍길동"><br>
        <input type="text" id="phone" name="phone" placeholder="번호" value="010-1234-5678"><br>
        <input type="text" id="address" name="address" placeholder="주소" disabled value="서울시 강남구">
        <input type="button" onclick="execDaumPostcode()" value="주소입력"><br>
        <input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" value="아파트 101동 202호"><br>
        <!-- <input type="file" name="images" multiple><br> -->
        <input type="submit" value="제출">
    </form>

    <div class="upload-container" id="uploadContainer">
        <div class="placeholder">Drag & Drop Images Here</div>
        <div class="image-preview-container" id="imagePreviewContainer"></div>
    </div>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</html>
