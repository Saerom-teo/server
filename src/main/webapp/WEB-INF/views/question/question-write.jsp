<%@page import="java.util.ArrayList"%>
<%@page import="com.saeromteo.app.model.question.QuestionDTO.QuestionResponse"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/question.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        a, button, input, select, h1, h2, h3, h4, h5, * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            border: none;
            text-decoration: none;
            background: none;
            -webkit-font-smoothing: antialiased;
        }

        menu, ol, ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }
        #editor {
            width: 100%;
        }
    </style>
    <script src="${pageContext.request.contextPath}/static/js/question.js"></script>
    <title>Document</title>
</head>
<body>
<div class="notice">
    <%@ include file="/WEB-INF/views/collection/header.jsp"%>
    <div class="body">
        <div class="nav">
            <div class="frame-8914">
                <img class="image-26" src="${pageContext.request.contextPath}/static/img/notice-img.png" />
                <div class="div">고객 센터</div>
            </div>
            <a href="../notice/readAll"><div class="div2">공지사항</div></a>
            <a href="../faq/read"><div class="div3">자주 묻는 질문</div></a>
            <a href="../question/readAll"><div class="div4">문의사항</div></a>
        </div>
	    <!-- 에디터를 적용할 요소 (컨테이너) -->
	    <div class="moveEditor">
	        <form>
	            <div style="  margin: 86px 0 10px 0;">
	                <select class="category">
					  	<option value="" selected>카테고리</option>
					  	<option value="결제">결제</option>
					  	<option value="배송">배송</option>
					  	<option value="수거">수거</option>
					  	<option value="기타">기타</option>
					</select><br>
					제목<input class="inputbox2" type="text" id="title" placeholder="제목을 입력 해 주세요.">
		            <div id="btnDiv">
		                <label for="publication">공개 여부</label>
		        		<select id="publication" class="category" name="visibility">
		            		<option value="0">공개</option>
		            		<option value="1">비공개</option>
		            	</select>
		                <a href="../question/readAll" class="btns_back">뒤로가기</a>
		           	</div>
	            </div>
	                <button type="submit" id="submitBoardBtn" class="btns save" onclick="function()">작성완료</button>
	            <div id="editor"></div>
	        </form>
	    </div>
    </div>
    <%@ include file="/WEB-INF/views/collection/footer.jsp"%>
</div>
<!-- TUI 에디터 JS CDN -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script>
    const editor = new toastui.Editor({
        el: document.querySelector('#editor'), // 에디터를 적용할 요소 (컨테이너)
        height: '500px',                        // 에디터 영역의 높이 값 (OOOpx || auto)
        initialEditType: 'markdown',            // 최초로 보여줄 에디터 타입 (markdown || wysiwyg)
        placeholder: '내용을 입력해 주세요.',     // 내용의 초기 값으로, 반드시 마크다운 문자열 형태여야 함
        previewStyle: 'tab',                // 마크다운 프리뷰 스타일 (tab || vertical)
        hooks: {
            async addImageBlobHook(blob, callback) { // 이미지 업로드 로직 커스텀
                try {
                    /*
                     * 1. 에디터에 업로드한 이미지를 FormData 객체에 저장
                     *    (이때, 컨트롤러 uploadEditorImage 메서드의 파라미터인 'image'와 formData에 append 하는 key('image')값은 동일해야 함)
                     */
                    const formData = new FormData();
                    formData.append('image', blob);

                    // 2. FileApiController - uploadEditorImage 메서드 호출
                    const response = await fetch('../api/editor/image-upload', {
                        method : 'POST',
                        body : formData,
                    });

                    // 3. 컨트롤러에서 전달받은 디스크에 저장된 파일명
                    /* var filename = await response.text();
                    filename = filename.slice(1,-1);
                    console.log('서버에 저장된 파일명 : ', filename); */
					
                    var imageUrl = await response.text();
                    imageUrl = imageUrl.slice(1,-1);
                    console.log('서버에 저장된 파일 URL : ', imageUrl);
                    
                    // 4. addImageBlobHook의 callback 함수를 통해, 디스크에 저장된 이미지를 에디터에 렌더링
                    /* const imageUrl = `${pageContext.request.contextPath}/api/question/image-print?filename=` + filename; */
                    callback(imageUrl, 'image alt attribute');

                } catch (error) {
                    console.error('업로드 실패 : ', error);
                }
            }
        }
        /* end of hooks */
    });

 	// 저장 버튼 클릭 이벤트 핸들러
    $("#submitBoardBtn").click(function () {
    event.preventDefault(); // 기본 동작 방지
    
    var category = $(".category option:selected").val();
    var title = $("#title").val() || "";
    var content = editor.getHTML() || "";
    var publication = $("#publication").val() || "";
    var userId = ${userId};
    
    console.log(userId);
    // 기본 에디터 내용 확인
    if (category === "") {
        alert('카테고리를 선택해 주세요.');
        $("#category").focus();
        return;
    }
    
    if (title.trim().length === 0) {
        alert('제목을 입력해 주세요.');
        $("#title").focus();
        return;
    }
    
    var trimmedContent = content.trim();
    if (trimmedContent === "" || trimmedContent === "<p><br></p>") {
        alert('내용을 입력해 주세요.');
        editor.focus();
        return;
    }
    
    // 게시물 데이터를 서버로 전송
    $.ajax({
        url: "insertQuestion",
        type: "post",
        data: {
            "questionCategory": category,
            "questionTitle": title,
            "questionContent": content,
            "questionPublic": publication,
            "userId": userId // 사용자 ID 추가
        },
        success: function (data) {
            console.log('서버 응답:', data); // 응답 데이터 로그 출력
            if (data.trim() === "ok") { // 응답 데이터가 정확히 "ok"와 일치하는지 확인
                alert('작성완료');
                location.href = "${pageContext.request.contextPath}/question/readAll";
            } else {
                console.log('응답 데이터가 "ok"가 아닙니다.');
            }
        },
        error: function(xhr, status, error) {
            console.error('데이터 전송 실패:', error);
        }
    });
});
</script>
</body>
</html>
