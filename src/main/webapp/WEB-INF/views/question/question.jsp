<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<div class="content">
            <table class="question-table">
                <thead >
                    <tr class="tableHead">
                    	<th>번호</th>
                        <th>분류</th>
                        <th>제목</th>
                        <th>공개여부</th>
                        <th>답변상태</th>
                        <th>등록일</th>            
                    </tr>
                </thead>
                <tbody>
                     <c:forEach var="question" items="${questionList}" varStatus="status">
				        <tr id="questionTitle" class="questionlist" style="cursor:pointer;">
				        	<td>${status.count}</td>
				            <td>${question.questionCategory}</td>
				            <td>${question.questionTitle}</td>
				            <td>${question.questionPublic}</td>
				            <td>${question.questionAnswer}</td>
				            <td>${question.questionDate}</td>
				        </tr>
				        <tr id="questionContent">
                            <td colspan="6">${question.questionContent}</td>        
                        </tr>
				    </c:forEach>
                </tbody>
            </table>
		<div class="bottomOption">
        	<a href="" class="prev-page"><</a>
			<div class="pagination">
			    <c:forEach var="i" begin="1" end="${totalPages}">
			        <a href="" class="page-link" data-page="${i}">${i}</a>
			    </c:forEach>
			</div>
			<a href="" class="next-page">></a>
            <div class="search-bar">
                <select>
                    <option value="전체">전체</option>
                    <option value="제목">제목</option>
                    <option value="내용">내용</option>
                </select>
                <input type="text" placeholder="검색어를 입력해 주세요.">
                <button type="submit">검색</button>
            </div>
		</div>
        </div>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
</body>
</html>