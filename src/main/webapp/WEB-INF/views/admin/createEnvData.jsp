<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/app/quiz/api/create" method="post">
		<fieldset>
			<legend>게시글 등록</legend>
			<label for="envTitle"></label><br><input id="envTitle" type="text" name="envTitle"><br>
			<label for="envContent"></label><br><textarea id="envContent" name="envContent"><br>
			<label for="envdata"></label><br><input id="envdata" type="file" name="envdata"><br>
			<label for="envMainCategory"></label><br><input id="envMainCategory" type="text" name="envMainCategory"><br>
			<label for="envSubCategory"></label><br><input id="envSubCategory" type="text" name="envSubCategory"><br>
			<label for="envType"></label><br><input id="envType" type="text" name="envType"><br>
			<button type="submit">제출</button>
		</fieldset>
	
	</form>
	
</body>
</html>