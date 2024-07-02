<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/mypage-collection.css">
    
    <style>
        #point-table table {
            width: 100%;
            table-layout: fixed; /* 테이블 셀 너비 고정 */
            border-collapse: collapse; /* 테두리 겹침 */
            border-bottom: 1px solid var(--gray);
            margin: 15px 0;
        }

        #point-table th, td {
            text-align: center; /* 텍스트 중앙 정렬 */
            padding: 8px; /* 셀 내 여백 */
        }

        #point-table th {
            border-style: solid;
    		border-color: var(--primary);
    		border-width: 1px 0px 1px 0px;
        }
        
        #point-list{
        	margin-top: 40px;
        }
        
        .category {
        	margin: 10px 40px;
        	box-sizing: border-box;
        }
        
        .category a {
            border: 1px solid var(--primary);
            border-radius: 8px;
            padding: 4px 25px;
            margin: 0 5px;
            cursor: pointer;
            text-decoration: none;
            color: var(--primary);
        }
        
        .category a:hover {
			background-color: var(--secondary);            
        }
        
        .category a.current-type {
			background-color: var(--primary);
			color: #fff; 
			cursor: default;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }

        .pagination a {
            margin: 0 5px;
            padding: 8px 16px;
            border: 1px solid var(--primary);
            border-radius: 4px;
            text-decoration: none;
            color: var(--primary);
        }

        .pagination a.active {
            background-color: var(--primary);
            color: white;
        }

        .pagination a.disabled {
            pointer-events: none;
            color: grey;
        }
    </style>
    
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var currentPageId = "point";
            document.getElementById(currentPageId).classList.add("current-page");
        });
    </script>
</head>

<body>
    <%@ include file="/WEB-INF/views/collection/header.jsp" %>
    <div class="wrapper">
        <%@ include file="/WEB-INF/views/common/mypage-nav.jsp" %>
        <div class="collection-content">
            <div class="collection-name">
                <h1>포인트</h1>
            </div>
            <div id="point-list">
            	<div class="category">
            		<a href="?type=all" id="all" class="${empty param.type or param.type == 'all' ? 'current-type' : ''}">전체</a>
            		<a href="?type=earned" id="earned" class="${param.type == 'earned' ? 'current-type' : ''}">적립</a>
            		<a href="?type=spent" id="spent" class="${param.type == 'spent' ? 'current-type' : ''}">사용</a>
            	</div>
                <div id="point-table">
                    <table>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>포인트</th>
                                <th>적립구분</th>
                                <th>적립날짜</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="point" items="${pointResponses}" varStatus="status">
                                <tr>
                                    <td>${(currentPage - 1) * pageSize + status.index + 1}</td> <!-- 인덱스 계산 -->
                                    <td>${point.amount}</td>
                                    <td>${point.accrualType}</td>
                                    <td><fmt:formatDate value="${point.dateIssued}" pattern="yyyy-MM-dd"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="pagination">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <a href="?page=${i}&type=${param.type}" class="active">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="?page=${i}&type=${param.type}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/collection/footer.jsp"%>
</body>

</html>
