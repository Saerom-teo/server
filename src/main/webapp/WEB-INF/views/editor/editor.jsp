<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,javax.servlet.*,javax.servlet.http.*,javax.servlet.jsp.*"%>
<%@ page import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,org.apache.commons.fileupload.util.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Editor</title>
  <!-- include libraries(jQuery, bootstrap) -->
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <!-- include summernote css/js -->
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
  <script>
    $(document).ready(function() {
      $('#summernote').summernote({
        placeholder: '내용 작성',
        tabsize: 2,
        height: 400
      });
    });
  </script>
  <script>
	function goWrite(frm) {
		var title = frm.title.value;
		var content = frm.content.value;
		var category = frm.category.value;
		
		if (category.trim() == ''){
			alert("카테고리를 입력해주세요");
			return false;
		}
		if (title.trim() == ''){
			alert("제목을 입력해주세요");
			return false;
		}
		if (content.trim() == ''){
			alert("내용을 입력해주세요");
			return false;
		}
		frm.submit();
	}
	</script>
</head>
<body>
  <form id="editorForm" method="get" action="../../question/api/readAll">
	  <div>
	    <table border="1" width="750">
	      <tr>
	      	<td>카테고리</td>
	      	<td><input type="text" name="category" style="width: 20%" ></td>
	      </tr>
	      <tr>
	        <td>제목</td>
	        <td><input type="text" name="title" style="width: 100%"></td>
	      </tr>
	      <tr>
	        <td colspan="2">
	          <textarea id="summernote" name="content"></textarea>
	        </td>
	      </tr>
	    </table>
	    <input id="public" type="int" value="0">
	    <input id="subBtn" type="button" value="작성 완료"  onclick="goWrite(this.form)"/>
	  </div>
  </form>
</body>
</html>
