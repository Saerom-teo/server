<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>고객 센터</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/notice.css">
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <div class="menu">
                <h2>고객 센터</h2>
                <ul>
                    <li class="active">공지사항</li>
                    <li>자주 묻는 질문</li>
                    <li>문의사항</li>
                </ul>
            </div>
        </div>
        <div class="content">
            <table class="notice-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>분류</th>
                        <th>제목</th>
                        <th>등록일</th>
                    </tr>
                </thead>
                <tbody>
                     <c:forEach var="notice" items="${noticeList}">
				        <tr>
				            <td>${notice.noticeId}</td>
				            <td>${notice.noticeCategory}</td>
				            <td>${notice.noticeTitle}</td>
				            <td>${notice.noticeDate}</td>
				        </tr>
				    </c:forEach>
                </tbody>
            </table>
            <div class="pagination">
                <span>&laquo;</span>
                <span class="active">1</span>
                <span>2</span>
                <span>&raquo;</span>
            </div>
            <div class="search-bar">
                <select>
                    <option value="전체">전체</option>
                    <option value="검색">검색</option>
                    <option value="제목">제목</option>
                    <option value="내용">내용</option>
                </select>
                <input type="text" placeholder="검색어를 입력해 주세요.">
                <button type="submit">검색</button>
            </div>
        </div>
    </div>
</body>
</html>
