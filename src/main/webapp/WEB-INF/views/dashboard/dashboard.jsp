<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  
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
       text-decoration: none !important;
       background: none;
   
   }
   
   a {
   color: gray;
   }
   
   a:hover {
   	color: black;
   }
   
   menu, ol, ul {
       list-style-type: none;
       margin: 0;
       padding: 0;
   }
   
   @keyframes fadeInUp {
        0% { opacity: 0; transform: translateY(10px); }
        100% { opacity: 1; transform: translateY(0); }
    }

    .news {
        animation: fadeInUp 0.3s ease-in-out; /* fadeInUp 애니메이션을 적용합니다. */
    }
    .env-data {
        animation: fadeInUp 0.3s ease-in-out; /* fadeInUp 애니메이션을 적용합니다. */
    }
    .env-data2 {
        animation: fadeInUp 0.3s ease-in-out; /* fadeInUp 애니메이션을 적용합니다. */
    }
    
    .header {
		position: fixed;
		top: 0;
		width: 100%;
		z-index: 1000;
	}
   </style>
   <script>
	document.addEventListener("DOMContentLoaded", function() {
	    // 원하는 id에 current-page 클래스를 추가합니다.
	    var currentPageId = "headerDashboard";
	    document.getElementById(currentPageId).classList.add("header-focus");
	});

   
   	function readEnvDataDetail(envId) {
   		
   		var link = "${pageContext.request.contextPath}/envdata/readDetail/" + envId;
   		location.href = link;
   		
   	}
   	
   	$(document).ready(function () {
   	    const newsList = [];
	   	 <c:forEach var="news" items="${newsList}">
	   		newsList.push({
				newsId : "${news.newsId}",
				newsCheck : "${news.newsCheck}",
				newsTitle : "${news.newsTitle}",
				newsDescription : "${news.newsDescription}",
				newsPubdate : "${news.newsPubdate}",
				newsUrl : "${news.newsUrl}",
				newsCategory : "${news.newsCategory}"
			});
		</c:forEach>
	   	    
   	    
   	    let currentIndex = 0;
   	    const newsCount = 4;

   	    function displayNews() {
   	        $(".frame-66").html("");
   	        result = "";
   	        for (let i = 0; i < newsCount; i++) {
   	            const newsIndex = (currentIndex + i) % newsList.length;
   	            const news = newsList[newsIndex];
   	            result += `
   	                    <a class="frame-51" href=`+news.newsUrl+` target="_blank">
   	                <div class="news-item">
   	                        <div class="frame-522">
   	                            <div class="div5">`+news.newsTitle+`</div>` +
		   	                         `<div style="font-weight:400; font-size:12px; color:gray; margin-top:10px;">`+
		   	                  	`발간 날짜 |`+news.newsPubdate+
		   	                  `</div>
   	                        </div>
   	                </div>
   	                    </a >
   	          `;
   	         
   	        }
   	     $(".frame-66").html(result);

   	// 모든 뉴스 항목을 서서히 표시
         setTimeout(() => {
             $('.news-item').each(function(index) {
                 $(this).delay(index * 200).queue(function(next) {
                     $(this).addClass('visible');
                     next();
                 });
             });
         }, 100); // 약간의 지연을 주어 트랜지션 효과가 자연스럽게 시작되도록 함
   	    }

   	 function cycleNews() {
         $('.news-item').each(function(index) {
             $(this).delay(index * 200).queue(function(next) {
                 $(this).removeClass('visible');
                 next();
             });
         });

         setTimeout(() => {
             currentIndex = (currentIndex + newsCount) % newsList.length;
             displayNews();
         }, 1000); // 트랜지션 종료 후 다음 뉴스로 전환
     }

   	    displayNews();
   	    setInterval(cycleNews, 7000);
   	});

   	
   </script>
<title>대시보드</title>
</head>
<body>
  <div class="page">
  <%@ include file="/WEB-INF/views/collection/header.jsp"%>
    <div class="frame-59">
      <div class="news">
        <div class="frame-60">
          <div class="div3">최근 뉴스</div>
          <div class="div4"><a href = "${pageContext.request.contextPath}/news">더보기</a></div>
        </div>
        <div class="frame-61">
 
          <div class="frame-66">
          <c:forEach var="news" items="${newsList }">
            <a class="frame-51" href="${news.newsUrl }" target="_blank">
            <div>
              <div class="frame-522">
                <div class="div5">${news.newsTitle }</div>
   
                <div style="font-weight:400; font-size:12px;">
                	${news.newsPubdate}
                </div>
              </div>
            </div>
              </a>
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
            <div class="div4"><a href = "${pageContext.request.contextPath}/quiz">더보기</a></div>
          </div>
        </div>
        <div class="frame-64">
          <div class="frame-69">
            <div class="q">Q. ${quiz.quizName }</div>
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
            <a href="${pageContext.request.contextPath}/quiz">
          <div class="frame-68">
            <div class="frame-70">
              <div class="div11">
                문제 풀어보기
              </div>
            </div>
          </div>
        </div>
            </a>
      </div>
      <div class="env-data2">
        <div class="frame-63">
          <div class="div9">최근 자료</div>
          <div class="div4"><a href = "${pageContext.request.contextPath}/envdata">더보기</a></div>
        </div>
        <div class="frame-642">
        <c:forEach var="envdata" items="${envDataList}">
          <div class="frame-65" onclick="readEnvDataDetail(${envdata.envId})">
            <div class="image-17" style="background-image:url('${envdata.envData}')"></div>
            <div class="frame-52">
              <div class="div5">${envdata.envTitle }</div>
              <span style="font-weight:500; font-size:12px">${envdata.enrolledDate}</span>
            </div>
            
            <div class="overlay">
						<div><span style="color:yellow">주제</span>${envdata.envTitle}</div>
						<div><span style="color:yellow">자료타입</span>${envdata.envType}</div>
						<div><span style="color:yellow">등록날짜</span>${envdata.enrolledDate}</div>
						<div><span style="color:yellow">카테고리</span>${envdata.envMainCategory} > ${envdata.envSubCategory}</div>
					</div>
          </div>
          </c:forEach>
          
        </div>
      </div>
    </div>
  </div>
  <%@ include file="/WEB-INF/views/collection/footer.jsp"%>
  
</body>
</html>
