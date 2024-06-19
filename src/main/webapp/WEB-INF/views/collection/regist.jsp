<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" page-category="collection"  category-no="1">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/collection.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">

    <title>Document</title>
</head>

<body category-no="1">
    <%@ include file="/WEB-INF/views/collection/header.jsp"%>
    <div id="semi-header">
    	<%@ include file="/WEB-INF/views/collection/collection-nav.jsp"%>
    </div>

    <div id="regist">
        <div id="regist-title">
            <h1>잠깐! 신청 전 주의사항을 확인해 주세요.</h1>
        </div>

        <div id="grid-wrapper">
            <div>
                <h3>01</h3>
                <h2>수거 가능 물품 확인</h2>
                <P>복합플라스틱 제외, 재활용 가능한 플라스틱만 수거 대상입니다. 수거 요청 전에 반드시 수거 가능한 플라스틱 유형을 확인해 주세요.</P>
            </div>
    
            <div>
                <h3>02</h3>
                <h2>플라스틱 상태 확인</h2>
                <P>수거된 플라스틱은 청결 상태와 재활용 가능성을 기준으로 검사됩니다. 오염되거나 재활용이 불가능한 플라스틱은 포인트 산정에서 제외될 수 있습니다</P>
            </div>
    
            <div>
                <h3>03</h3>
                <h2>지정된 수거함 사용</h2>
                <P>지정된 수거함을 사용해야 하며, 최초 서비스 신청 시 수거함이 지급됩니다. 수거함 사용에 대한 보증금이 있으니 이를 숙지해 주시기 바랍니다.</P>
            </div>
    
            <div>
                <h3>04</h3>
                <h2>AI 테스트</h2>
                <P>수거 요청을 위해 AI 테스트를 통과해야 합니다. 이 테스트는 수거 요청 절차의 일부로, 요청의 정확성을 보장하기 위해 필요합니다.</P>
            </div>
        </div>

        <div id="regist-comment">
            <p>모든 절차를 충분히 이해하셨다면, 아래 '동의하고 계속하기' 버튼을 클릭하여 수거 신청을 완료해 주세요.</p>
            <a>*수거 물품 중 적합하지 않은 물품 또는 이물질이 있어 재활용하지 못하는 물품이 일정 비율 이상이면 포인트가 지급되지 않을 수도 있습니다.*</a><br>
            <button>동의하고 계속하기</button>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/collection/footer.jsp"%>
    
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var categoryNo = document.body.getAttribute('category-no');
            var navLinks = document.querySelectorAll('.semi-header a');

            if (categoryNo && navLinks[categoryNo]) {
                navLinks[categoryNo].classList.add('black');
            }
        });
    </script>
</body>

</html>