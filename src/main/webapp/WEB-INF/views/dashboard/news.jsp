<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/news.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
a, button, input, select, h1, h2, h3, h4, h5, * {
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

.header {
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 1000;
}

@keyframes fadeInUp {
        0% { opacity: 0; transform: translateY(10px); }
        100% { opacity: 1; transform: translateY(0); }
    }

    .searchsection {
        animation: fadeInUp 0.7s ease-in-out; /* fadeInUp 애니메이션을 적용합니다. */
    }
</style>

<script>

	function reloadNews() {
			if($(".searchbar").val() == "") {
				$.ajax({
					url: "news/api/readByCheck/" + true,
					method: "GET",
					dataType: "json",
					success : function(res) {
						
						
						$(".news-contents").html("");
						resultHtml = "";
						$.each(res, function(index, item) {
						    resultHtml += `
						    <div class="news-1">
						        <a href=`+ item.newsUrl +` target="_blank">
						            <div class="news-real-content">
						                <div class="div6">` + item.newsTitle+ `</div>
						                <div class="_2024-05-19">` + item.newsPubdate + `</div>
						                <div class="div7">`+ item.newsDescription +`</div>
						            </div>
						        </a>
						    </div>
						    `;
						});
						$(".news-contents").html(resultHtml);
					},
					error: function(xhr, status, error) {
			            console.error(xhr.responseText);
			        }
				});
			} else {
				$.ajax({
					url: "news/api/search/" + $(".searchbar").val(),
					method: "GET",
					dataType: "json",
					success : function(res) {
						
						
						$(".news-contents").html("");
						resultHtml = "";
						$.each(res, function(index, item) {
						    resultHtml += `
						    <div class="news-1">
						        <a href=`+ item.newsUrl +` target="_blank">
						            <div class="news-real-content">
						                <div class="div6">` + item.newsTitle+ `</div>
						                <div class="_2024-05-19">` + item.newsPubdate + `</div>
						                <div class="div7">`+ item.newsDescription +`</div>
						            </div>
						        </a>
						    </div>
						    `;
						});
						$(".news-contents").html(resultHtml);
					},
					error: function(xhr, status, error) {
			            console.error(xhr.responseText);
			        }
				});
			}
		}
	
	function readCategory(category) {
		var link = "/app/news/category/" + category;
		location.href = link;
	}
	
	function reload() {
		location.href = "/app/news";
	}
	
</script>
<title>Document</title>
</head>
<body>
	<div class="news">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<%@ include file="/WEB-INF/views/common/dashboard-nav.jsp"%>

		<div class="searchsection">
			<div class="news-div">원하는 뉴스 키워드를 검색해보세요</div>
			<input class="searchbar" type="text" placeholder="검색어를 입력하면 자동으로 검색됩니다." onkeyup="reloadNews()"/>
		</div>
		<div class="news-main-body">
			<div class="news-date">
				<div class="div2">업데이트 날짜</div>
				<div class="_2024-05-28">${updateDate}</div>
			</div>
			<div class="news-body">
				<div class="category-nav-bar">
					<div class="category-1">
						<div class="div3">뉴스 카테고리</div>
					</div>
					<div class="category-12" onclick="reload()">
						<div class="div4">전체 뉴스</div>
					</div>
					<div class="category-13" onclick="readCategory('한국 뉴스')">
						<div class="div5">한국 뉴스</div>
					</div>
					<div class="category-13" onclick="readCategory('외국 뉴스')">
						<div class="div5">외국 뉴스</div>
					</div>
				</div>
				<div class="news-contents">
					<c:forEach var="news" items="${newsList}">
					<div class="news-1">
						<a href="${news.newsUrl}" target="_blank">
						<div class="news-real-content">
							<div class="div6">${news.newsTitle }</div>
							<div class="_2024-05-19">${news.newsPubdate }</div>
							<div class="div7">${news.newsDescription }</div>
						</div>
						</a>
					</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<!-- 
		<img class="group-8906"
			src="${pageContext.request.contextPath}/static/icon/news_up.png" />
		 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>

</body>
</html>