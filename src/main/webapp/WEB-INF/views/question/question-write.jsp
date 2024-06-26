<%@page import="java.util.ArrayList"%>
<%@page import="com.saeromteo.app.dto.question.QuestionDTO.QuestionResponse"%>
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
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
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
    </div>

    <!-- 에디터를 적용할 요소 (컨테이너) -->
    <div class="moveEditor">
        <form>
            <table>
                <tr>
                    <td>카테고리</td>
                    <td><input type="text" id="category"></td>
                </tr>
                <tr>
                    <td>제목</td>
                    <td><input type="text" id="title"></td>
                </tr>
            </table>
            <div id="btnDiv">
                <button type="submit" id="submitBoardBtn" class="btns save" onclick="function()">저장하기</button>
                <a href="../question/readAll" class="btns back">뒤로 가기</a>
                <label for="publication">공개 여부:</label>
        		<select id="publication" name="visibility">
            		<option value="0">공개</option>
            		<option value="1">비공개</option>
            	</select>
           	</div>
            <div id="editor"></div>
        </form>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp"%>
</div>
<!-- TUI 에디터 JS CDN -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script>
    const editor = new toastui.Editor({
        el: document.querySelector('#editor'), // 에디터를 적용할 요소 (컨테이너)
        height: '500px',                        // 에디터 영역의 높이 값 (OOOpx || auto)
        initialEditType: 'markdown',            // 최초로 보여줄 에디터 타입 (markdown || wysiwyg)
        placeholder: '내용을 입력해 주세요.',     // 내용의 초기 값으로, 반드시 마크다운 문자열 형태여야 함
        previewStyle: 'tab'                // 마크다운 프리뷰 스타일 (tab || vertical)
    });

    $("#submitBoardBtn").click(function(){
    	var category = $("#category").val()
    	var title = $("#title").val()
    	var content = editor.getHTML()
    	var publication = $("#publication").val()
    	
    	if(content.trim().length < 1){
    		alert('내용을 입력해 주세요.');
    		$("#editor").focus();
    	}else if(title.trim().length < 1){
    		alert('제목을 입력해 주세요.');
    		$("#title").focus();
    	}else if(category.trim().length < 1){
    		alert('카테고리를 선택해 주세요.');
    		$("#category").focus();
    	}else{
    		$.ajax({
    			url : "insertQuestion",
    			type : "post",
    			//dataType : "application/json",
    			data : {
    				"questionCategory" : category,
    				"questionTitle" : title,
    				"questionContent" : content,
    				"questionPublic" : publication,
    				"userCode" : 100
    			},
    			success : function(data){
    				if(data=="ok"){
    					location.href = "readAll";
    				}
    			}
    		});
    	}
    });
    
    // 게시글 저장
   /*  async function savePost() {
        // 1. 콘텐츠 입력 유효성 검사
        if (editor.getMarkdown().length < 1) {
            alert('에디터 내용을 입력해 주세요.');
            throw new Error('editor content is required!');
        }

        // 입력 필드 값 가져오기
        const category = document.getElementById('category').value;
        const title = document.getElementById('title').value;

        // 2. url, parameter 세팅
        const url = 'http://localhost:9090/api/posts';  // 서버 주소와 엔드포인트 확인
        const params = {
            category: category,
            title: title,
            content: editor.getHTML()
        }

        // 3. API 호출
        try {
            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(params),
            });

            if (!response.ok) {
                throw new Error('Network response was not ok');
            }

            const postId = await response.json();
            alert(postId + '번 게시글이 저장되었습니다.');
            location.href = '/readAll';

        } catch (error) {
            console.error('저장 실패 : ', error);
            alert('저장 실패: ' + error.message);
        }
    } */
</script>
</body>
</html>
