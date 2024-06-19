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
  <link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">
  <link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/question.css">
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
    /* border : 1px solid; */
    width : 100%;
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
					<img class="image-26"
						src="${pageContext.request.contextPath}/static/img/notice-img.png" />
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
    			<td><input type="text", id="category"></td>
    		</tr>
    		<tr>
    			<td>제목</td>
    			<td><input type="text" id="title"></td>
    		</tr>
    	</table>
	<div id="btnDiv">
        <button type="button" class="btns save" onclick="savePost();">저장하기</button>
        <a href="../question/readAll" class="btns back">뒤로 가기</a>
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
		// 게시글 저장
		async function savePost() {
		    // 1. 콘텐츠 입력 유효성 검사
		    if (editor.getMarkdown().length < 1) {
		        alert('에디터 내용을 입력해 주세요.');
		        throw new Error('editor content is required!');
		    }
		
		    // 2. url, parameter 세팅
		    const url = '/api/posts';
		    const params = {
		        title: '1번 게시글 제목',
		        content: editor.getHTML(),
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
		
		        const postId = await response.json();
		        alert(postId + '번 게시글이 저장되었습니다.');
		        location.href = '/post/list.html';
		
		    } catch (error) {
		        console.error('저장 실패 : ', error)
		    }
		}
    </script>
</body>
</html>