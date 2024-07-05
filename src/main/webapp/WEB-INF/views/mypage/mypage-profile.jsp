<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/mypage-collection.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <title>회원 정보 수정</title>
    <style>
        /* 추가된 CSS */
        .profile-button-container .profile-button:hover {
            background: var(--primary-dark);
        }

        .profile-button-container .profile-button {
            background: var(--primary);
            color: #fff;
            font-size: 14px;
            padding: 9px 10px;
            border-radius: 8px;
            cursor: pointer;
            width: 150px;
            margin-right: 5px;
        }
        

        #collection-table td {
            text-align: left;
            border-bottom: 1px solid var(--gray);
        }

        #collection-table th {
            text-align: left;
        }

        #collection-table tbody tr:last-child td {
            border-bottom: none;
        }
            /* 테이블 간격 조정 */
        .collection-table-wrapper {
            margin-top: 40px;
            width: 100%;
}        
        .button-cell {
            text-align: right;
        }

    </style>
</head>

<body>
    <%@ include file="/WEB-INF/views/collection/header.jsp" %>
    <div class="wrapper">
        <%@ include file="/WEB-INF/views/common/mypage-nav.jsp" %>
        <div class="collection-content">
            <div class="collection-name">
                <h1>회원 정보 수정</h1>
            </div>
            <div id="collection-list">
                <h3>기본 회원 정보</h3>
                <div id="collection-table">
                    <table>
                        <thead>
                            <tr>
                                <th>항목</th>
                                <th>내용</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>이메일</td>
                                <td>user@example.com</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>비밀번호</td>
                                <td>********</td>
                                <td><div class="profile-button-container"><button class="profile-button">비밀번호 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>닉네임</td>
                                <td>user123</td>
                                <td><div class="profile-button-container"><button class="profile-button">닉네임 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>생년월일</td>
                                <td>1990-01-01</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>성별</td>
                                <td>
                                    <div class="details__yes-no">
                                        <div class="checkbox"></div> 남성 
                                        <div class="checkbox"></div> 여성
                                    </div>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>휴대전화</td>
                                <td>010-1234-5678</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>수거 서비스 신청 여부</td>
                                <td>예</td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div id="collection-list">
                <h3>배송지 정보</h3>
                <div id="collection-table">
                    <table>
                        <thead>
                            <tr>
                                <th>항목</th>
                                <th>내용</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>우편번호</td>
                                <td>12345</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>주소</td>
                                <td>서울특별시 강남구 테헤란로 123</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>상세 주소</td>
                                <td>아파트 101호</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>수령인</td>
                                <td>홍길동</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>휴대전화</td>
                                <td>010-9876-5432</td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/collection/footer.jsp" %>
</body>
</html>
