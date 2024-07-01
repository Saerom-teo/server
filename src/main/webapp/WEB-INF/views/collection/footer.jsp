<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    
<body>
    <div class="footer">
        <div class="footer-container">
            <div class="footer-content">
                <div class="footer-links">
                    <p>이용약관</p>
                    <p>개인정보 처리 방침</p>
                    <p>전자금융거래약관</p>
                    <p></p>
                </div>
                <hr>

                <div class="contact-info">
                    <p>상호명:새롬터 · 대표자명:HONG GILDONG · 주소:서울특별시 마포구 월드컵북로 4길 77 ANT타워 1층<br>
                    사업자등록번호:000-00-00000 · 통신판매업신고증:제 0000-서울마포-00000 호<br>
                    고객센터:1599-1234 · 팩스:000-000-0000 · 이메일:saeromteo@gmail.com</p>
                </div>
                <div>
                    <img src="${pageContext.request.contextPath}/static/icon/facebook.svg">
                    <img src="${pageContext.request.contextPath}/static/icon/instagram.svg">
                    <img src="${pageContext.request.contextPath}/static/icon/x.svg">
                    <img src="${pageContext.request.contextPath}/static/icon/b.svg">
                </div>
            </div>


            <div class="footer-sections">
                <div>
                    <h3>새롬터</h3>
                    <p>새롬터 소개</p>
                </div>
                <div>
                    <h3>수거안내</h3>
                    <p>수거서비스 소개</p>
                    <p>수거가능 지역 확인</p>
                </div>
                <div>
                    <h3>고객센터</h3>
                    <p><a class="footer-links" href="${pageContext.request.contextPath}/notice/readAll">공지사항</a></p>
                    <p><a class="footer-links" href="${pageContext.request.contextPath}/faq/read">자주 묻는 질문</a></p>
                    <p><a class="footer-links" href="${pageContext.request.contextPath}/question/readAll">문의사항</a></p>
                </div>
            </div>

        </div>
    </div>
</body>

</html>