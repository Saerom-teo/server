<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/quiz.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">


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
</style>

<script>
	function changeProb(index) {
		$.ajax({
			url: "/api/readDetail",
			type: "get",
			data: {
				quizId: index
			},
			success: function(quiz) {
				$(".div2").html(quiz.quizCon)
			}
		})
	}

</script>

<title>Document</title>
</head>
<body>
	<div class="quiz">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<%@ include file="/WEB-INF/views/common/newsnav.jsp"%>

		<div class="body">
			<div class="mainquiz">
				<div class="div">퀴즈</div>
				<div class="quizbox">
					<div class="q">Q. 문제</div>
					<div class="_10">
						<span> <span class="_10-span">문제를 풀면</span> <span
							class="_10-span2">3 포인트</span> <span class="_10-span3">를
								받을 수 있어요</span>
						</span>
					</div>
					<div class="div2">
						${quizList[0].quizContent}
					</div>
					<div class="select">
						<div class="select-1">
							<div class="div3">
								네
							</div>
						</div>
						<div class="select-2">
							<div class="div4">
								아니요
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="subquiz">
				<div class="quizlist">
					<div class="div">퀴즈 목록</div>
					<div class="quizlistbody">
						<c:forEach var="quiz" items="${quizList}" varStatus="index">
							<div class="quiz-1">
								<div class="div5">
									<ol class="div-5-span">
										<li>${quiz.quizContent}</li>
									</ol>
								</div>
								<div class="div6" onclick="changeProb('${index.index}')">풀어보기</div>
							</div>
						</c:forEach>
					

					</div>
				</div>
				<div class="quizrecord">
					<div class="div">퀴즈 내역</div>
					<div class="quizchance">
						<div class="_1-3">
							<span> <span class="_1-3-span">퀴즈 남은 기회</span> <span
								class="_1-3-span2">1</span> <span class="_1-3-span3">/ 5</span>
							</span>
						</div>
						<div class="_3">하루에 총 5개의 퀴즈를 풀 수 있어요</div>
					</div>
					<div class="quizpoint">
						<div class="_30-p">
							<span> <span class="_30-p-span">지금까지 퀴즈를 풀어서</span> <span
								class="_30-p-span2">${point}P</span> <span class="_30-p-span3">를
									벌었어요!</span>
							</span>
						</div>
						<div class="_140-p">다음 등급까지 140P 남았어요</div>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>

</body>
</html>

