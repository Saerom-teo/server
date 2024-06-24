<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
function submitForm() {
	var formData = new FormData();
    formData.append('envTitle', $('#envTitle').val());
    formData.append('envContent', $('#envContent').val());
    formData.append('envDataFile', $('#envdata')[0].files[0]);
    formData.append('envMainCategory', $('#envMainCategory').val());
    formData.append('envSubCategory', $('#envSubCategory').val());
    formData.append('envType', $('#envType').val());

    $.ajax({
        url: '/app/envdata/api/create',
        type: 'POST',
        contentType: false,
        processData: false,
        data: formData,
        success: function(response) {
            window.location.href = "/app/envdata";
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
        }
    });
}


</script>
</head>
<body>
	<form id="postForm">
		<fieldset>
			<legend>게시글 등록</legend>
			<label for="envTitle">제목</label><br><input id="envTitle" type="text" name="envTitle"><br>
			<label for="envContent">내용</label><br><textarea id="envContent" name="envContent"></textarea><br>
			<label for="envdata">데이터</label><br><input id="envdata" type="file" name="envdataFile"><br>
			<label for="envMainCategory">메인카테고리</label><br><input id="envMainCategory" type="text" name="envMainCategory"><br>
			<label for="envSubCategory">서브카테고리</label><br><input id="envSubCategory" type="text" name="envSubCategory"><br>
			<label for="envType">데이터종류</label><br><input id="envType" type="text" name="envType"><br>
			<button type="button" onclick="submitForm()">제출</button>
		</fieldset>
	
	</form>
	
</body>
</html>