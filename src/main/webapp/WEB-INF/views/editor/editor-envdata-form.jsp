<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<div id="editor"></div>
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script>
    const editor = new toastui.Editor({
        el: document.querySelector('#editor'), // 에디터를 적용할 요소 (컨테이너)
        height: '500px',                        // 에디터 영역의 높이 값 (OOOpx || auto)
        initialEditType: 'markdown',            // 최초로 보여줄 에디터 타입 (markdown || wysiwyg)
        previewStyle: 'vertical',                // 마크다운 프리뷰 스타일 (tab || vertical)
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
                    const response = await fetch('${pageContext.request.contextPath}/api/editor/image-upload', {
                        method : 'POST',
                        body : formData,
                    });

                    // 3. 컨트롤러에서 전달받은 디스크에 저장된 파일명
                    var filename = await response.text();
                    filename = filename.slice(1,-1);
                    console.log('서버에 저장된 파일명 : ', filename);

                    // 4. addImageBlobHook의 callback 함수를 통해, 디스크에 저장된 이미지를 에디터에 렌더링
                    const imageUrl = `${pageContext.request.contextPath}/api/editor/image-print?filename=` + filename;
                    callback(imageUrl, 'image alt attribute');

                } catch (error) {
                    console.error('업로드 실패 : ', error);
                }
            }
        }
        /* end of hooks */
    });

 	// 저장 버튼 클릭 이벤트 핸들러
    function submitCreate() {
    	if(confirm("환경자료를 생성하시겠습니까?")) {
    		
    		var formData = new FormData();
			formData.append('envTitle', $('.envTitle').val());
		    formData.append('envContent', editor.getHTML());
		    formData.append('envDataFile', $('.envData')[0].files[0]);
		    formData.append('envMainCategory', $('.envMainCategory').val());
		    formData.append('envSubCategory', $('.envSubCategory').val());
		    formData.append('envType', $('.envType').val());

            // 게시물 데이터를 서버로 전송
            $.ajax({
                url: "${pageContext.request.contextPath}/envdata/api/create",
                type: "POST",
                contentType: false,
		        processData: false,
		        data: formData,
                success: function (data) {
                		alert("환경자료가 생성되었습니다.");
                       location.href = "envdata-manager";
                  
                }
            });
    	}
    }
</script>
</body>
</html>