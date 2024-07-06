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
  <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
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
<title>공지사항 | 새롬터</title>
</head>
<body>
	<div class="notice">
		<%@ include file="/WEB-INF/views/collection/header.jsp"%>
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
            <table class="notice-table">
                <thead >
                    <tr class="tableHead">
                    	<th>번호</th>
                        <th>분류</th>
                        <th>제목</th>
                        <th style="width: 177px;">등록일</th>            
                    </tr>
                </thead>
                <tbody>
					<%-- 현재 페이지 번호, 페이지 크기 및 전체 항목 수를 가져옴 --%>
					<c:set var="currentPage" value="${currentPage}" />
					<c:set var="pageSize" value="${pageSize}" />
					<c:set var="totalNotices" value="${totalNotices}" />

					<%-- 현재 페이지의 시작 인덱스를 계산 --%>
					<c:set var="startIndex" value="${(currentPage - 1) * pageSize}" />
					<c:forEach var="notice" items="${noticeList}" varStatus="status">
						<tr id="noticeTitle" class="noticelist" style="cursor:pointer;">
							<td>${totalNotices - (startIndex + status.index)}</td>
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
			<div class="pagination">
        		<a href="" class="prev-page"><img src="${pageContext.request.contextPath}/static/icon/mypage-toggle/chevron-left.svg" style="width: 10px;"/></a>
				    <c:forEach var="i" begin="1" end="${totalPages}">
				        <a href="?page=${i}" class="page-link ${i == currentPage ? 'active' : ''}" data-page="${i}">${i}</a>
				    </c:forEach>
				<a href="" class="next-page"><img src="${pageContext.request.contextPath}/static/icon/mypage-toggle/chevron-right.svg"style="width: 10px;"/></a>
			</div>
            <div class="search-bar">
                <form action="${pageContext.request.contextPath}/notice/readAll" method="get">
                <div style="display: flex; align-items: flex-end;">
                    <select class="selectbox" name="filter">
                        <option value="all">전체</option>
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                    </select>
	                <div>
	                	<input class="inputbox" type="text" name="query" placeholder="검색어를 입력해 주세요.">
	                	<button type="submit" style="position: relative; right: 30px; cursor: pointer;"><img id="submit-image" src="${pageContext.request.contextPath}/static/img/search.svg"/></button>
	                </div>
                </div>
                </form>
            </div>
		</div>
        </div>
		</div>
		<%@ include file="/WEB-INF/views/collection/footer.jsp"%>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function() {
    var currentPage = ${param.page != null ? param.page : 1};
    var totalPages = ${totalPages};

    if (currentPage <= 1) {
        $('.prev-page').addClass('disabled');
    }

    if (currentPage >= totalPages) {
        $('.next-page').addClass('disabled');
    }

    $('.prev-page').click(function(e) {
        e.preventDefault();
        if (currentPage > 1) {
            window.location.href = '?page=' + (currentPage - 1);
        }
    });

    $('.next-page').click(function(e) {
        e.preventDefault();
        if (currentPage < totalPages) {
            window.location.href = '?page=' + (currentPage + 1);
        }
    });
});
</script>
</html>