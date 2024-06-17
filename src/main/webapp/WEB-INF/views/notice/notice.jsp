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
	href="${pageContext.request.contextPath}/static/css/notice.css">
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
<script src="${pageContext.request.contextPath}/static/js/notice.js"></script>
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
				<div class="div2">공지사항</div>
				<div class="div3">자주 묻는 질문</div>
				<div class="div4">문의사항</div>
			</div>
		<div class="content">
            <table class="notice-table">
                <thead >
                    <tr class="tableHead">
                    	<th>번호</th>
                        <th>분류</th>
                        <th>제목</th>
                        <th>등록일</th>            
                    </tr>
                </thead>
                <tbody>
                     <c:forEach var="notice" items="${noticeList}" varStatus="status">
				        <tr id="noticeTitle" class="noticelist" style="cursor:pointer;">
				        	<td>${status.count}</td>
				            <td>${notice.noticeCategory}</td>
				            <td>${notice.noticeTitle}</td>
				            <td>${notice.noticeDate}</td>
				        </tr>
				        <tr id="noticeContent">
                            <td colspan="4">${notice.noticeContent}</td>
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