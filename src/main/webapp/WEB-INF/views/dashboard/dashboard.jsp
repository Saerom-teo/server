<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<meta charset="UTF-8">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/dashboard.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  
  
  <style>
   a,
   button,
   input,
   select,
   h1,
   h2,
   h3,
   h4,
   h5,
   * {
       box-sizing: border-box;
       margin: 0;
       padding: 0;
       border: none;
       text-decoration: none;
       background: none;
   
       -webkit-font-smoothing: antialiased;
   }
   
   menu, ol, ul {
       list-style-type: none;
       margin: 0;
       padding: 0;
   }
   </style>
<title>대시보드</title>
</head>
<body>
  <div class="page">
  <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <div class="frame-67">
      <div class="div">대시보드</div>
      <div class="div2">뉴스</div>
      <div class="div2">퀴즈</div>
      <div class="div2">자료</div>
    </div>
    <div class="frame-59">
      <div class="news">
        <div class="frame-60">
          <div class="div3">최근 뉴스</div>
          <div class="div4">더보기</div>
        </div>
        <div class="frame-61">
          <div class="frame-65">
            <img class="image-17" src="image-170.png" />
            <div class="frame-52">
              <div class="div5">환경 오염 심각, 곧 지구 망함</div>
              <div class="div6">
                언제 망할지... 다들 궁금해 하는데 집에 가고 싶은데 배고프고 오늘
                마라탕 먹으니까 버틸 수 있음 보도자료 보도자료 보도자료 보도자료
                보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
                보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
                보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
              </div>
            </div>
          </div>
          <div class="frame-66">
            <div class="frame-51">
              <img class="image-172" src="image-171.png" />
              <div class="frame-522">
                <div class="div5">환경 오염 심각, 곧 지구 망함</div>
                <div class="div6">
                  언제 망할지... 다들 궁금해 하는데 집에 가고 싶은데 배고프고 오늘
                  마라탕 먹으니까료 보도자료 보도자료 보도자료 보도자료 보도자료
                  보도자료
                </div>
              </div>
            </div>
            <div class="frame-523">
              <img class="image-172" src="image-172.png" />
              <div class="frame-522">
                <div class="div5">환경 오염 심각, 곧 지구 망함</div>
                <div class="div6">
                  언제 망할지... 다들 궁금해 하는데 집에 가고 싶은데 배고프고 오늘
                  마라탕 먹으니까 버틸 수 있음 보도자료 보도자료 보도자료 보도자료
                  보도자료 보도자자료 보도자료 보도자료 보도자료 보도자료 보도자료
                  보도자료
                </div>
              </div>
            </div>
            <div class="frame-53">
              <img class="image-172" src="image-173.png" />
              <div class="frame-522">
                <div class="div5">환경 오염 심각, 곧 지구 망함</div>
                <div class="div6">
                  언제 망할지... 다들 궁금해 하는데 집에 가고 싶은데 배고프고 오늘
                  마라탕 먹으니까 버틸 수 있음 보도자료 보도자료 보도자료 보도자료
                  보도자료 보도자료 보도료 보도자료 보도자료 보도자료 보도자료
                  보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
                  보도자료 보도자료
                </div>
              </div>
            </div>
            <div class="frame-54">
              <img class="image-172" src="image-174.png" />
              <div class="frame-522">
                <div class="div7">환경 오염 심각, 곧 지구 망함</div>
                <div class="div8">
                  언제 망할지... 다들 궁금해 하는데 집에 가고 싶은데 배고프고 오늘
                  마라탕 먹으니까 버틸 수 있음 보도자료 보도자료 보도자료 보도자료
                  보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
                  보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
                  보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="env-data">
        <div class="frame-63">
          <div class="frame-62">
            <div class="div9">오늘의 퀴즈</div>
          </div>
          <div class="frame-632">
            <div class="div4">더보기</div>
          </div>
        </div>
        <div class="frame-64">
          <div class="frame-69">
            <div class="q">Q. 문제</div>
            <div class="_10">
              <span>
                <span class="_10-span">문제를 풀면</span>
                <span class="_10-span2">10 포인트</span>
                <span class="_10-span3">를 받을 수 있어요</span>
              </span>
            </div>
          </div>
          <div class="div10">
            성층권에 존재하여 지표면에 도달하는 자외선의 양을 줄여주는 층을
            <br />
            오존이라고 한다. 이때, 오존층이 파괴되면 환경오염이 심화된다.
            <br />
            이 때, 냉장고와 에이컨이 생성될 때 발생하는 프레온 가스는
            <br />
            오존층 파괴의 주 원인인가?
          </div>
          <div class="frame-68">
            <div class="frame-70">
              <div class="div11">
                네, 프레온 가스는
                <br />
                나빠요
              </div>
            </div>
            <div class="frame-71">
              <div class="div12">
                아니요 프레온 가스는
                <br />
                착해요
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="env-data2">
        <div class="frame-63">
          <div class="div9">최근 자료</div>
          <div class="div4">더보기</div>
        </div>
        <div class="frame-642">
          <div class="frame-65">
            <img class="image-17" src="image-175.png" />
            <div class="frame-52">
              <div class="div5">환경 오염 심각, 곧 지구 망함</div>
              <div class="div6">
                언제 망할지... 다들 궁금해 하는데 집에 가고 싶은데 배고프고 오늘
                마라탕 먹으니까 버틸 수 있음 보도자료 보도자료 보도자료 보도자료
                보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
                보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
                보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
              </div>
            </div>
          </div>
          <div class="frame-662">
            <img class="image-18" src="image-180.png" />
            <div class="frame-52">
              <div class="div5">환경 오염 심각, 곧 지구 망함</div>
              <div class="div6">
                언제 망할지... 다들 궁금해 하는데 집에 가고 싶은데 배고프고 오늘
                마라탕 먹으니까 버틸 수 있음 보도자료 보도자료 보도자료 보도자료
                보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
                보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
                보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
              </div>
            </div>
          </div>
          <div class="frame-672">
            <img class="image-18" src="image-181.png" />
            <div class="frame-52">
              <div class="div5">환경 오염 심각, 곧 지구 망함</div>
              <div class="div6">
                언제 망할지... 다들 궁금해 하는데 집에 가고 싶은데 배고프고 오늘
                마라탕 먹으니까 버틸 수 있음 보도자료 보도자료 보도자료 보도자료
                보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
                보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
                보도자료 보도자료 보도자료 보도자료 보도자료 보도자료 보도자료
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp"%>
  </div>
  
</body>
</html>
