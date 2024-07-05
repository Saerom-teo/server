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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/mypage-collection.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>회원 정보 수정</title>
    <style>
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
            width: 50%;
        }

        #collection-table th {
            text-align: left;
        }

        #collection-table tbody tr:last-child td {
            border-bottom: none;
        }

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
                   <div class="myinfo">
            <img class="user-profile" src="${profileImg}" />
            <p>${nickname} 님</p>
        </div>
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
                                <td><div class="profile-button-container"><button class="profile-button" data-target="password-update">비밀번호 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>닉네임</td>
                                <td><input type="text" id="nickname" name="nickname" value="user123"></td>
                                <td><div class="profile-button-container"><button class="profile-button" data-target="nickname-update">닉네임 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>생년월일</td>
                                <td>1990-01-01</td>
                                <td><div class="profile-button-container"><button class="profile-button" data-target="birthday-update">생년월일 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>성별</td>
                                <td>
                                    <div class="details__yes-no">
                                        <div class="checkbox"></div> 남성 
                                        <div class="checkbox"></div> 여성
                                    </div>
                                </td>
                                <td><div class="profile-button-container"><button class="profile-button" data-target="gender-update">성별 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>휴대전화</td>
                                <td><input type="text" id="phone" name="phone" value="010-1234-5678"></td>
                                <td><div class="profile-button-container"><button class="profile-button" data-target="phone-update">휴대전화 변경</button></div></td>
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
                                <td><div class="profile-button-container"><button class="profile-button" data-target="address-update">주소 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>상세 주소</td>
                                <td><input type="text" id="detailAddress" name="detailAddress" value="아파트 101호"></td>
                                <td><div class="profile-button-container"><button class="profile-button" data-target="detailaddress-update">상세 주소 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>배송 요청사항</td>
                                <td><input type="text" id="deliveryRequest" name="deliveryRequest" value="문 앞에 놔주세요"></td>
                                <td><div class="profile-button-container"><button class="profile-button" data-target="deliveryrequest-update">배송 요청사항 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>수령인</td>
                                <td><input type="text" id="receiver" name="receiver" value="홍길동"></td>
                                <td><div class="profile-button-container"><button class="profile-button" data-target="receiver-update">수령인 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>휴대전화</td>
                                <td><input type="text" id="phone" name="phone" value="010-9876-5432"></td>
                                <td><div class="profile-button-container"><button class="profile-button" data-target="phone-update">휴대전화 변경</button></div></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- 모달 -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div id="modal-body">
                <!-- AJAX로 로드된 내용이 여기에 삽입됩니다. -->
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/collection/footer.jsp" %>

    <script>
        $(document).ready(function(){
            // 모달 열기
            $(".profile-button").click(function(){
                var target = $(this).data("target");
                $.ajax({
                    url: "${path}/views/mypage/mypage-update/" + target + ".jsp",
                    success: function(data){
                        $("#modal-body").html(data);
                        $("#myModal").css("display", "block");
                    }
                });
            });

            // 모달 닫기
            $(".close").click(function(){
                $("#myModal").css("display", "none");
            });

            // 모달 외부 클릭 시 닫기
            $(window).click(function(event){
                if (event.target == $("#myModal")[0]) {
                    $("#myModal").css("display", "none");
                }
            });

            // 폼 제출 시 페이지 리로드
            $(document).on("submit", "form", function(e){
                e.preventDefault();
                var form = $(this);
                $.ajax({
                    type: form.attr("method"),
                    url: form.attr("action"),
                    data: form.serialize(),
                    success: function(response) {
                        alert("정보가 성공적으로 업데이트되었습니다.");
                        $("#myModal").css("display", "none");
                        location.reload(); // 페이지 리로드
                    },
                    error: function() {
                        alert("업데이트 중 오류가 발생했습니다.");
                    }
                });
            });
        });
    </script>
</body>
</html>
