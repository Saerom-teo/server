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
   <script>
   	function readEnvDataDetail(envId) {
   		
   		var link = "/app/envdata/readDetail/" + envId;
   		location.href = link;
   		
   	}
   </script>
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
          <div class="div4"><a href = "/app/news">더보기</a></div>
        </div>
        <div class="frame-61">
          <div class="frame-65">
            <div class="frame-52">
            <a href="${newsList[0].newsUrl }" target="_blank">
              <div class="div5">${newsList[0].newsTitle }</div>
              <div class="div6">
                ${newsList[0].newsDescription }
              </div>
              </a>
            </div>
          </div>
          <div class="frame-66">
          <c:forEach var="news" items="${newsList }" begin="1">
            <div class="frame-51">
            <a href="${news.newsUrl }" target="_blank">
              <div class="frame-522">
                <div class="div5">${news.newsTitle }</div>
                <div class="div6">
                  ${news.newsDescription }
                </div>
              </div>
              </a>
            </div>
         </c:forEach>
          </div>
        </div>
      </div>
      <div class="env-data">
        <div class="frame-63">
          <div class="frame-62">
            <div class="div9">오늘의 퀴즈</div>
          </div>
          <div class="frame-632">
            <div class="div4"><a href = "/app/quiz">더보기</a></div>
          </div>
        </div>
        <div class="frame-64">
          <div class="frame-69">
            <div class="q">Q. 문제</div>
            <div class="_10">
              <span>
                <span class="_10-span">문제를 풀면</span>
                <span class="_10-span2">${quiz.point}포인트</span>
                <span class="_10-span3">를 받을 수 있어요</span>
              </span>
            </div>
          </div>
          <div class="div10">
            ${quiz.quizContent }
          </div>
          <div class="frame-68">
            <div class="frame-70">
              <div class="div11">
                네
              </div>
            </div>
            <div class="frame-71">
              <div class="div12">
                아니요
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="env-data2">
        <div class="frame-63">
          <div class="div9">최근 자료</div>
          <div class="div4"><a href = "/app/envdata">더보기</a></div>
        </div>
        <div class="frame-642">
        <c:forEach var="envdata" items="${envDataList}">
          <div class="frame-65" onclick="readEnvDataDetail(${envdata.envId})">
            <img class="image-17" src="${envdata.envData}" />
            <div class="frame-52">
              <div class="div5">${envdata.envTitle }</div>
            </div>
          </div>
          </c:forEach>
          
        </div>
      </div>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp"%>
  </div>
  
</body>
</html>
