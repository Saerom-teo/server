<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<title>회원정보수정</title>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
	
	<style>
    .container {
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: flex-start;
            padding: 20px;
        }

        .profile-sidebar {
            width: 300px;
            padding: 20px;
            border-right: 1px solid #E6E0E0;
        }

        .profile-sidebar img {
            display: block;
            margin: 0 auto 20px;
            width: 118px;
            height: 118px;
        }

        .profile-sidebar .user-info {
            text-align: center;
            font-weight: 500;
        }

        .user-info__name {
            font-size: 32px;
            line-height: 46px;
            margin-bottom: 10px;
        }

        .user-info__points,
        .user-info__rank,
        .user-info__label {
            color: #333232;
            font-size: 20px;
            line-height: 13px;
        }

        .user-info__label {
            font-size: 16px;
            line-height: 13px;
        }

        .profile-content {
            flex: 1;
            padding: 20px;
        }

        .profile-header {
            font-size: 32px;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .profile-details {
            border: 1px solid #B9B7B7;
            border-radius: 20px;
            padding: 20px;
        }

        .profile-details__header {
            font-size: 24px;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .profile-details__info {
            font-size: 20px;
            font-weight: 500;
            color: #575F57;
        }

        .button {
            display: inline-block;
            margin-top: 10px;
            padding: 5px 10px;
            border: 0.8px solid #616060;
            border-radius: 7px;
            font-size: 10px;
            font-weight: 500;
            color: #000;
            text-align: center;
            cursor: pointer;
        }

        .profile-details__info > div {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .details__yes-no {
            font-size: 16px;
            color: #575F57;
            display: flex;
            align-items: center;
        }

        .checkbox {
            width: 16px;
            height: 15px;
            background: #D9D9D9;
            border: 0.8px solid #000000;
            margin-right: 10px;
        }

        .shipping-info {
            margin-top: 20px;
            border: 1px solid #B9B7B7;
            border-radius: 20px;
            padding: 20px;
        }

        .shipping-info__header {
            font-size: 24px;
            font-weight: 500;
            margin-bottom: 20px;
        }

	</style>
</head>

<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="wrapper">
			<%@ include file="/WEB-INF/views/common/mypage-nav.jsp"%>
	    <div class="container">
        <div class="profile-content">
            <div class="profile-header">회원 정보 수정</div>
            <div class="profile-details">
                <div class="profile-details__header">기본 회원 정보</div>
                <div class="profile-details__info">
                    <div>이메일 <div class="button">비밀번호 변경</div></div>
                    <div>비밀번호 <div class="button">닉네임 수정</div></div>
                    <div>닉네임 <div class="button">휴대전화 변경</div></div>
                    <div>생년월일</div>
                    <div>성별 <div class="details__yes-no"><div class="checkbox"></div>yes <div class="checkbox"></div>no</div></div>
                    <div>휴대전화</div>
                    <div>수거 서비스 신청 여부</div>
                </div>
            </div>
            <div class="shipping-info">
                <div class="shipping-info__header">배송지 정보</div>
                <div class="profile-details__info">
                    <!-- 배송지 정보 입력 필드 -->
                </div>
            </div>
        </div>
    </div>
    </div>

    <%@ include file="/WEB-INF/views/collection/footer.jsp"%>
</body>
</html>
