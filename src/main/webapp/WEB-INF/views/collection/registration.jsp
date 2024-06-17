<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/address_input.js"></script>
        <script>
            function enableAddress() {
                document.getElementById("address").disabled = false;
            }
        </script>
    </head>

    <body>
        <h1>올레픽 신청하기</h1>
        <form action="../api/collection/registration" method="post" onsubmit="enableAddress()">
            <input type="text" id="name" name="name" placeholder="이름" value="홍길동"><br>
            <input type="text" id="phone" name="phone" placeholder="번호" value="010-1234-5678"><br>
            <input type="text" id="address" name="address" placeholder="주소" disabled value="서울시 강남구">
            <input type="button" onclick="execDaumPostcode()" value="주소입력"><br>
            <input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" value="아파트 101동 202호"><br>
            <input type="submit" value="제출">
        </form>
    </body>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    </html>