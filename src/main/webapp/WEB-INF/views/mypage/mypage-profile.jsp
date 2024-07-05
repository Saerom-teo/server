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

        .editable {
            background-color: #f0f8ff; /* 수정 모드일 때의 배경색 */
        }

        input[disabled] {
            background-color: #e9ecef; /* 비활성화된 input의 배경색 */
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
                                <td id="email-cell">${email}</td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="email">이메일 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>비밀번호</td>
                                <td id="password-cell">
                                    <c:forEach var="i" begin="1" end="${pwdLength}">*</c:forEach>
                                </td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="password">비밀번호 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>닉네임</td>
                                <td id="nickname-cell">${nickname}</td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="nickname">닉네임 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>생년월일</td>
                                <td id="birthday-cell">${userBirth}</td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="birthday">생년월일 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>성별</td>
                                <td id="gender-cell">
                                    <select id="gender" name="gender" class="editable">
                                        <option value="Male" ${gender == 'Male' ? 'selected' : ''}>남성</option>
                                        <option value="Female" ${gender == 'Female' ? 'selected' : ''}>여성</option>
                                    </select>
                                </td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="gender">성별 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>휴대전화</td>
                                <td id="phone-cell">${phoneNumber}</td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="phone">휴대전화 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>수거 서비스 신청 여부</td>
                                <td id="service-cell">${userCollStatus ? '예' : '아니오'}</td>
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
                                <td id="postalcode-cell">${postalCode}</td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="postalcode">우편번호 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>주소</td>
                                <td id="main-address-cell">${mainAddress}</td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="mainaddress">주소 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>상세 주소</td>
                                <td id="detail-address-cell">${detailAddress}</td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="detailaddress">상세 주소 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>배송 요청사항</td>
                                <td id="deliveryrequest-cell">${deliveryRequest}</td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="deliveryrequest">배송 요청사항 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>수령인</td>
                                <td id="receiver-cell">${receiver}</td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="receiver">수령인 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>휴대전화</td>
                                <td id="receiver-phone-cell">${receiverPhone}</td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="receiverphone">휴대전화 변경</button></div></td>
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
            var currentEditing = null;

            // 모달 열기
            $(".profile-button").click(function(){
                var target = $(this).data("target");

                // 다른 버튼 누르면 초기화
                if (currentEditing && currentEditing !== target) {
                    var previousCell = $("#" + currentEditing + "-cell");
                    var previousValue = previousCell.find("input, select").val();
                    previousCell.html(previousValue);
                    $(".profile-button[data-target='" + currentEditing + "']").text("변경");
                }

                currentEditing = target;
                var cell = $("#" + target + "-cell");
                var input = cell.find("input, select");

                if(input.length === 0) {
                    // input이 없으면 생성
                    var currentValue = cell.text().trim();
                    if(target === 'gender') {
                        cell.html('<select id="gender" name="gender" class="editable"><option value="Male" ${gender == 'Male' ? 'selected' : ''}>남성</option><option value="Female" ${gender == 'Female' ? 'selected' : ''}>여성</option></select>');
                    } else {
                        cell.html('<input type="text" id="' + target + '" name="' + target + '" value="' + currentValue + '" class="editable">');
                    }
                    $(this).text("저장");
                    cell.find("input, select").focus(); // 저장 버튼 클릭 시 포커스
                } else {
                    // input이 있으면 저장
                    var newValue = input.val();
                    cell.html(newValue);

                    $.ajax({
                        type: "POST",
                        url: "${path}/user/update/" + target,
                        data: { value: newValue },
                        success: function(response) {
                            alert("정보가 성공적으로 업데이트되었습니다.");
                            $(".profile-button[data-target='" + target + "']").text("변경");
                            currentEditing = null; // 초기화
                        },
                        error: function() {
                            alert("업데이트 중 오류가 발생했습니다.");
                            $(".profile-button[data-target='" + target + "']").text("변경");
                            currentEditing = null; // 초기화
                        }
                    });
                }
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
