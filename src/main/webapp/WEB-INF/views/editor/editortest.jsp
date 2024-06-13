<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Editor Test</title>
</head>
<body>
    <h2>전달된 값</h2>
    <%
        String subject = request.getParameter("subject");
        String memo = request.getParameter("memo");

        if (subject != null && memo != null) {
        %>console.log("<p>제목: " + subject + "</p>");
          console.log("<p>내용: " + memo + "</p>");
        <%} else {
        %>console.log("<p>전달된 값이 없습니다.</p>");
        <%}
    %>
</body>
</html>
