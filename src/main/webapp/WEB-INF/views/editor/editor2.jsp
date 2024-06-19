<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>TOAST UI Editor 적용하기</title>

    <!-- TUI 에디터 CSS CDN -->
    <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
</head>
<style>
#editor {
    /* border : 1px solid; */
    width : 50%;
}
</style>
<body>
    <h2>Hello, TOAST UI Editor!</h2>

    <!-- 에디터를 적용할 요소 (컨테이너) -->
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
        <a href="/post/list.html" class="btns back">뒤로 가기</a>
    </div>
    <div id="editor"/>
    </form>
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