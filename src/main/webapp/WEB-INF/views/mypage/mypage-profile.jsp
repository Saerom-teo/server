<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
        
        .hidden-input {
            display: none;
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
                    <div class="profile-button-container">
                        <button class="profile-button" id="uploadProfileImageButton">프로필 이미지 변경</button>
                        <input type="file" id="profileImage" name="profileImage" class="hidden-input" accept="image/*">
                    </div>
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
                                <td id="userEmail-cell">${email}</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>닉네임</td>
                                <td id="userNickname-cell">${nickname}</td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="userNickname">닉네임 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>생년월일</td>
                                <td id="userBirth-cell">${userBirth}</td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="userBirth">생년월일 변경</button></div></td>
                            </tr>
                            <tr>
                                <td>휴대전화</td>
                                <td id="userPhone-cell">${phoneNumber}</td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="userPhone">휴대전화 변경</button></div></td>
                            </tr>
<tr>
    <td>수거 서비스 신청 여부</td>
    <td id="userCollStatus-cell">
        <c:choose>
            <c:when test="${userCollStatus}">
                예
            </c:when>
            <c:otherwise>
               <td>
                <div class="profile-button-container">
                    <button class="profile-button" id="applyCollectionServiceButton">수거서비스 신청하기</button>
                </div>
                </td>
            </c:otherwise>
        </c:choose>
    </td>
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
                                <td id="userPostalCode-cell">${postalCode}</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>주소</td>
                                <td id="userAdd-cell">${mainAddress}</td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="mainAddress">주소 찾기</button></div></td>
                            </tr>
                            <tr>
                                <td>상세 주소</td>
                                <td id="userDetailAdd-cell">${detailAddress}</td>
                                <td><div class="profile-button-container"><button class="profile-button edit-button" data-target="detailAddress">주소 변경</button></div></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/collection/footer.jsp" %>
<script>
$(document).ready(function() {
    var currentEditing = null;

    // 프로필 이미지 변경 버튼 클릭 이벤트
    $("#uploadProfileImageButton").click(function() {
        $("#profileImage").click(); // 파일 선택 창 열기
    });

    // 파일 선택 후 업로드
    $("#profileImage").change(function() {
        var formData = new FormData();
        var fileInput = $("#profileImage")[0];

        if (fileInput.files.length === 0) {
            alert("파일을 선택해 주세요.");
            return;
        }

        formData.append("profileImage", fileInput.files[0]);

        $.ajax({
            type: "POST",
            url: "${path}/mypage/profile/uploadProfileImage",
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                alert("프로필 이미지가 성공적으로 업로드되었습니다.");
                window.location.href = "${path}/mypage/profile"; // 경로로 리다이렉션
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error("업로드 오류:", textStatus, errorThrown);
                alert("프로필 이미지 업로드 중 오류가 발생했습니다.");
            }
        });
    });

    // 모달 열기 (프로필 이미지 변경 제외)
    $(".modal-button").click(function(){
        var target = $(this).data("target");
        if (target !== "userImgPath") {
            $("#modal-body").load("${path}/mypage/profile-update/" + target + ".jsp");
            $("#myModal").css("display", "block");
        }
    });

    // 모달 닫기
    $(".close").click(function(){
        $(".modal").css("display", "none");
    });

    // 모달 외부 클릭 시 닫기
    $(window).click(function(event){
        if ($(event.target).hasClass("modal")) {
            $(".modal").css("display", "none");
        }
    });

    // 수정 버튼 클릭 이벤트
    $(".edit-button").click(function(){
        var target = $(this).data("target");

        // 주소찾기 버튼일 때는 텍스트 변경하지 않음
        if(target === 'mainAddress') {
            execDaumPostcode(); // 카카오맵 주소 찾기 호출
            return;
        }

        // 다른 버튼 누르면 초기화
        if (currentEditing && currentEditing !== target) {
            var previousCell = $("#" + currentEditing + "-cell");
            var previousValue = previousCell.find("input, select").val();
            previousCell.html(previousValue);
            $(".edit-button[data-target='" + currentEditing + "']").text("변경");
        }

        currentEditing = target;
        var cell = $("#" + target + "-cell");
        var input = cell.find("input, select");

        if(input.length === 0) {
            // input이 없으면 생성
            var currentValue = cell.text().trim();
            if(target === 'userGender') {
                cell.html('<select id="userGender" name="userGender" class="editable"><option value="Male" ${userGender == 'Male' ? 'selected' : ''}>남성</option><option value="Female" ${userGender == 'Female' ? 'selected' : ''}>여성</option></select>');
            } else if(target === 'userBirth') {
                cell.html('<input type="date" id="' + target + '" name="' + target + '" value="' + currentValue + '" class="editable">');
            } else {
                cell.html('<input type="text" id="' + target + '" name="' + target + '" value="' + currentValue + '" class="editable">');
            }
            $(this).text("저장");
            cell.find("input, select").focus(); // 저장 버튼 클릭 시 포커스
        } else {
            // input이 있으면 저장
            var newValue = input.val();

            var data = {};
            data[target] = newValue;
            cell.html(newValue);

            $.ajax({
                type: "POST",
                url: "${path}/mypage/profile/update",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                success: function(response) {
                    alert("정보가 성공적으로 업데이트되었습니다.");
                    $(".edit-button[data-target='" + target + "']").text("변경");
                    currentEditing = null; // 초기화
                    window.location.href = "${path}/mypage/profile"; // 경로로 리다이렉션
                },
                error: function() {
                    alert("업데이트 중 오류가 발생했습니다.");
                    $(".edit-button[data-target='" + target + "']").text("변경");
                    currentEditing = null; // 초기화
                }
            });
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
                window.location.href = "${path}/mypage/profile"; // 경로로 리다이렉션
            },
            error: function() {
                alert("업데이트 중 오류가 발생했습니다.");
            }
        });
    });

    // 주소 업데이트를 위한 유효성 검사 함수
    function validateAddress() {
        var postalCode = $('#userPostalCode-cell').text().trim();
        var mainAddress = $('#userAdd-cell').text().trim();
        var detailAddress = $('#userDetailAdd-cell input').val().trim();

        if (!postalCode || !mainAddress || !detailAddress) {
            alert('우편번호, 주소, 상세 주소를 모두 입력해 주세요.');
            return false;
        }

        return true;
    }

    // 주소 변경 버튼 클릭 이벤트
    $('.edit-button[data-target="detailAddress"]').click(function(){
        if (!validateAddress()) {
            return;
        }

        var postalCode = $('#userPostalCode-cell').text().trim();
        var mainAddress = $('#userAdd-cell').text().trim();
        var detailAddress = $('#userDetailAdd-cell input').val().trim();

        var data = {
            userPostalCode: postalCode,
            mainAddress: mainAddress,
            detailAddress: detailAddress
        };

        $.ajax({
            type: "POST",
            url: "${path}/mypage/profile/updateAddress",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            success: function(response) {
                alert("주소가 성공적으로 업데이트되었습니다.");
                window.location.href = "${path}/mypage/profile"; // 경로로 리다이렉션
            },
            error: function() {
                alert("주소 업데이트 중 오류가 발생했습니다.");
            }
        });
    });

    // 수거서비스 신청하기 버튼 클릭 이벤트
    $('#applyCollectionServiceButton').click(function(){
        window.location.href = "${path}/collection/regist";
    });
});

// 카카오맵 주소 찾기 기능
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var fullAddr = data.address; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            if(data.addressType === 'R'){
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 주소와 우편번호를 업데이트
            $('#userAdd-cell').html(fullAddr);
            $('#userPostalCode-cell').html(data.zonecode);

            // 상세 주소 input 필드 추가
            $('#userDetailAdd-cell').html('<input type="text" id="detailAddress" name="detailAddress" class="editable">');
        }
    }).open();
}
</script>

</body>
</html>

</script>

</body>
</html>


</body>
</html>
