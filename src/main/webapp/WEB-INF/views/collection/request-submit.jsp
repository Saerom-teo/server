<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/collection.css">
    <script src="${pageContext.request.contextPath}/static/js/image_upload.js"></script>
    <title>Document</title>
</head>

<body>
    <div class="modal-background">
        <div class="submit-container" id="request-container">
            <h3>올레픽 요청하기</h3>
            <p id="info">신청인 정보가 올바른지 확인해주세요. 수거함 사진을 등록하시면 수거 요청이 완료되고 승인될 때 알림을 드려요.</p>

            <div>
                <p>신청인</p>
                <input id="name" type="text" placeholder="이름를 입력해 주세요" autocomplete='off'><br>
            </div>
            <div>
                <p>휴대전화 번호</p>
                <input id="phone" type="text" placeholder="휴대전화 번호를 입력해주세요" autocomplete='off'><br>
            </div>
            <div>
                <p>주소</p>
                
                <input type="text" id="address" placeholder="주소를 입력해 주세요" autocomplete='off'>
                <input type="text" id="detailAddress" placeholder="상제주소를 입력해 주세요" autocomplete='off'>
                <a>잘못된 정보가 있나요? <a id="edit-info">수정하기</a></a>
            </div>
            <div id="image-input">
                <p>수거함 사진 등록</p>
                <div class="upload-container" id="uploadContainer">
                    <div class="placeholder">파일을 선택하거나 여기에 드래그 앤 드롭하세요</div>
                    <input type="file" id="fileInput" multiple style="display:none;">
                    <div class="image-preview-container" id="imagePreviewContainer"></div>
                </div>
                <div id="submit-note">
                    <p>※수거함 AI검사</p>
                    <a>수거함의 4면당 1장씩 총 4장의 사진을 등록해주세요. AI가 적합한 물품만 들어가 있는지 판별합니다.</a>
                </div>
            </div>

            <button id="regist-btn" class="btn-green" onclick="window.location.href='request-complete'" disabled>제출하기</button>
        </div>
    </div>

</body>

</html>
