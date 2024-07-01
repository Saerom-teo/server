<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>서비스 이용 동의서</title>
     <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/tos.css">
</head>

<body>
<div class ="toscontainer">
    <h1>서비스 이용 동의서</h1>

    <div class="article">
        <h2>제 1 장 총칙</h2>
        <div class="article">
            <h3 class="article-title">제 1 조 (목적)</h3>
            <p class="article-content">
                본 약관은 신한 DS 1차 프로젝트의 플라스틱 재활용 및 친환경 제품 판매 온라인 플랫폼(이하 '서비스')의 이용과 관련하여, 회사와 이용자 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.
            </p>
        </div>

        <div class="article">
            <h3 class="article-title">제 2 조 (정의)</h3>
            <div class="list-item">
                <span class="definition">서비스:</span> 신한 DS 1차 프로젝트의 온라인 플랫폼을 통해 제공되는 플라스틱 재활용 및 친환경 제품 판매 관련 모든 서비스를 의미합니다.
            </div>
            <div class="list-item">
                <span class="definition">이용자:</span> 본 약관에 따라 서비스를 이용하는 회원 및 비회원을 의미합니다.
            </div>
            <div class="list-item">
                <span class="definition">회원:</span> 서비스에 개인정보를 제공하여 회원 등록을 한 자로서, 서비스의 정보를 지속적으로 제공받으며, 서비스를 계속적으로 이용할 수 있는 자를 의미합니다.
            </div>
            <div class="list-item">
                <span class="definition">비회원:</span> 회원에 가입하지 않고 서비스를 이용하는 자를 의미합니다.
            </div>
            <div class="list-item">
                <span class="definition">포인트:</span> 서비스 내에서 제공되는 가상 적립금으로, 플라스틱 제공 및 다양한 활동을 통해 적립 및 사용할 수 있습니다.
            </div>
        </div>

        <div class="article">
            <h3 class="article-title">제 3 조 (약관의 명시와 개정)</h3>
            <p class="article-content">
                본 약관은 서비스 초기 화면에 게시하여 이용자가 확인할 수 있도록 합니다.
            </p>
            <p class="article-content">
                회사는 약관의 규제에 관한 법률, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 관련 법령을 위배하지 않는 범위 내에서 본 약관을 개정할 수 있습니다.
            </p>
            <p class="article-content">
                회사가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행 약관과 함께 서비스 초기 화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.
            </p>
            <p class="article-content">
                이용자는 개정된 약관에 대해 거부할 권리가 있습니다. 개정된 약관에 대해 거부하는 경우 서비스 이용을 중단하고 회원 탈퇴를 할 수 있습니다.
            </p>
        </div>

        <div class="article">
            <h3 class="article-title">제 4 조 (약관의 해석)</h3>
            <p class="article-content">
                본 약관에 명시되지 않은 사항은 관계법령 또는 상관례에 따릅니다.
            </p>
        </div>
    </div>

    <div class="article">
        <h2>제 2 장 회원 가입과 서비스 이용</h2>
        <div class="article">
            <h3 class="article-title">제 5 조 (회원 가입)</h3>
            <p class="article-content">
                회원 가입은 이용자가 약관의 내용에 대하여 동의를 한 다음 회원 가입 신청을 하고, 회사가 이러한 신청에 대하여 승낙함으로써 체결됩니다.
            </p>
            <p class="article-content">
                회사는 다음 각 호에 해당하는 신청에 대해서는 승낙하지 않을 수 있습니다.
            </p>
            <div class="list-item">
                1. 가입 신청자가 본 약관에 의하여 이전에 회원 자격을 상실한 적이 있는 경우
            </div>
            <div class="list-item">
                2. 실명이 아니거나 타인의 명의를 이용한 경우
            </div>
            <div class="list-item">
                3. 허위의 정보를 기재하거나, 회사가 제시하는 내용을 기재하지 않은 경우
            </div>
            <div class="list-item">
                4. 기타 회원으로 등록하는 것이 서비스의 기술상 현저히 지장이 있다고 판단되는 경우
            </div>
        </div>

        <div class="article">
            <h3 class="article-title">제 6 조 (회원 탈퇴 및 자격 상실)</h3>
            <p class="article-content">
                회원은 언제든지 서비스 내 탈퇴 기능을 이용하여 회원 탈퇴를 요청할 수 있으며, 회사는 즉시 회원 탈퇴를 처리합니다.
            </p>
            <p class="article-content">
                회원이 다음 각 호의 사유에 해당하는 경우, 회사는 회원 자격을 제한 및 정지시킬 수 있습니다.
            </p>
            <div class="list-item">
                1. 가입 신청 시에 허위 내용을 등록한 경우
            </div>
            <div class="list-item">
                2. 서비스 이용과 관련하여 회원이 부담하는 채무를 기일 내에 이행하지 않는 경우
            </div>
            <div class="list-item">
                3. 다른 사람의 서비스 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우
            </div>
            <div class="list-item">
                4. 서비스를 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우
            </div>
        </div>

        <div class="article">
            <h3 class="article-title">제 7 조 (회원에 대한 통지)</h3>
            <p class="article-content">
                회사가 회원에 대한 통지를 하는 경우, 회원이 지정한 이메일 주소로 할 수 있습니다.
            </p>
            <p class="article-content">
                회사는 불특정 다수 회원에 대한 통지의 경우 1주일 이상 서비스 게시판에 게시함으로써 개별 통지에 갈음할 수 있습니다.
            </p>
        </div>
    </div>

    <div class="article">
        <h2>제 3 장 서비스 제공 및 이용</h2>
        <div class="article">
            <h3 class="article-title">제 8 조 (서비스의 제공)</h3>
            <p class="article-content">
                회사는 다음과 같은 서비스를 제공합니다.
            </p>
            <div class="list-item">
                1. 플라스틱 수거 및 포인트 지급 서비스
            </div>
            <div class="list-item">
                2. 친환경 제품 판매 서비스
            </div>
            <div class="list-item">
                3. 환경 보호 및 재활용 관련 교육 자료 제공
            </div>
            <div class="list-item">
                4. 기타 회사가 추가 개발하거나 다른 회사와의 제휴 계약 등을 통해 제공하는 서비스
            </div>
        </div>

        <div class="article">
            <h3 class="article-title">제 9 조 (서비스의 변경 및 중단)</h3>
            <p class="article-content">
                회사는 서비스의 내용, 운영상, 기술상의 필요에 따라 제공하는 서비스를 변경할 수 있습니다.
            </p>
            <p class="article-content">
                회사는 다음 각 호에 해당하는 경우 서비스의 전부 또는 일부를 제한하거나 중단할 수 있습니다.
            </p>
            <div class="list-item">
                1. 서비스용 설비의 보수 등 공사로 인한 부득이한 경우
            </div>
            <div class="list-item">
                2. 이용자가 회사의 영업활동을 방해하는 경우
            </div>
            <div class="list-item">
                3. 기타 중대한 사유로 인하여 회사가 서비스 제공을 지속하는 것이 부적당하다고 인정하는 경우
            </div>
        </div>

        <div class="article">
            <h3 class="article-title">제 10 조 (포인트)</h3>
            <p class="article-content">
                포인트는 회원이 플라스틱을 제공하거나 기타 회사가 정한 활동을 통해 적립할 수 있습니다.
            </p>
            <p class="article-content">
                포인트는 회사가 정한 방법에 따라 서비스 내에서 사용할 수 있으며, 현금으로 환급되지 않습니다.
            </p>
            <p class="article-content">
                포인트의 유효기간은 적립일로부터 1년이며, 유효기간 내 사용하지 않은 포인트는 소멸됩니다.
            </p>
        </div>
    </div>

    <div class="article">
        <h2>제 4 장 의무와 책임</h2>
        <div class="article">
            <h3 class="article-title">제 11 조 (회사의 의무)</h3>
            <p class="article-content">
                회사는 관련 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며, 지속적이고 안정적으로 서비스를 제공하기 위해 최선을 다합니다.
            </p>
            <p class="article-content">
                회사는 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 개인정보 보호를 위해 보안 시스템을 갖추어야 합니다.
            </p>
            <p class="article-content">
                회사는 서비스 제공과 관련하여 알고 있는 이용자의 개인정보를 본인의 동의 없이 제3자에게 제공하지 않습니다.
            </p>
        </div>

        <div class="article">
            <h3 class="article-title">제 12 조 (이용자의 의무)</h3>
            <p class="article-content">
                이용자는 다음 행위를 하여서는 안 됩니다.
            </p>
            <div class="list-item">
                1. 신청 또는 변경 시 허위 내용의 등록
            </div>
            <div class="list-item">
                2. 타인의 정보 도용
            </div>
            <div class="list-item">
                3. 회사가 게시한 정보의 변경
            </div>
            <div class="list-item">
                4. 회사가 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시
            </div>
            <div class="list-item">
                5. 회사와 기타 제3자의 저작권 등 지적 재산권에 대한 침해
            </div>
            <div class="list-item">
                6. 회사와 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위
            </div>
            <div class="list-item">
                7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 서비스에 공개 또는 게시하는 행위
            </div>
        </div>
    </div>

    <div class="article">
        <h2>제 5 장 기타</h2>
        <div class="article">
            <h3 class="article-title">제 13 조 (저작권의 귀속 및 이용 제한)</h3>
            <p class="article-content">
                회사가 작성한 저작물에 대한 저작권 및 기타 지적 재산권은 회사에 귀속합니다.
            </p>
            <p class="article-content">
                이용자는 서비스를 이용함으로써 얻은 정보 중 회사에게 지적 재산권이 귀속된 정보를 회사의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안 됩니다.
            </p>
        </div>

        <div class="article">
            <h3 class="article-title">제 14 조 (분쟁 해결)</h3>
            <p class="article-content">
                회사는 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위해 피해보상처리기구를 설치·운영합니다.
            </p>
            <p class="article-content">
                회사는 이용자로부터 제출되는 불만사항 및 의견을 우선적으로 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리 일정을 즉시 통보합니다.
            </p>
        </div>

        <div class="article">
            <h3 class="article-title">제 15 조 (재판권 및 준거법)</h3>
            <p class="article-content">
                서비스 이용 중 발생한 분쟁에 대해 소송이 제기될 경우 대한민국의 법을 적용합니다.
            </p>
            <p class="article-content">
                회사의 본사 소재지를 관할하는 법원을 전속 관할 법원으로 합니다.
            </p>
        </div>
    </div>

    <p>최종 수정일: 2024년 6월 23일</p>
    </div>
</body>

</html>
