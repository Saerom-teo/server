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
							class="_10-span2">10 포인트</span> <span class="_10-span3">를
								받을 수 있어요</span>
						</span>
					</div>
					<div class="div2">
						성층권에 존재하여 지표면에 도달하는 자외선의 양을 줄여주는 층을 <br /> 오존이라고 한다. 이때, 오존층이
						파괴되면 환경오염이 심화된다. <br /> 이 때, 냉장고와 에이컨이 생성될 때 발생하는 프레온 가스는 <br />
						오존층 파괴의 주 원인인가?
					</div>
					<div class="select">
						<div class="select-1">
							<div class="div3">
								네, 프레온 가스는 <br /> 나빠요
							</div>
						</div>
						<div class="select-2">
							<div class="div4">
								아니요, 프레온 <br /> 가스는 나빠요
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="subquiz">
				<div class="quizlist">
					<div class="div">퀴즈 목록</div>
					<div class="quizlistbody">
						<div class="quiz-1">
							<div class="div5">
								<ol class="div-5-span">
									<li>아이스크림을 먹으면 배가 아플까요?</li>
								</ol>
							</div>
							<div class="div6">풀어보기</div>
						</div>
						<div class="quiz-1">
							<div class="div5">
								<ol class="div-5-span2">
									<li>아이스크림을 먹으면 배가 아플까요?</li>
								</ol>
							</div>
							<div class="div6">풀어보기</div>
						</div>
						<div class="quiz-1">
							<div class="div5">
								<ol class="div-5-span3">
									<li>아이스크림을 먹으면 배가 아플까요?</li>
								</ol>
							</div>
							<div class="div6">풀어보기</div>
						</div>
						<div class="quiz-1">
							<div class="div5">
								<ol class="div-5-span4">
									<li>아이스크림을 먹으면 배가 아플까요?</li>
								</ol>
							</div>
							<div class="div6">풀어보기</div>
						</div>
					</div>
				</div>
				<div class="quizrecord">
					<div class="div">퀴즈 내역</div>
					<div class="quizchance">
						<div class="_1-3">
							<span> <span class="_1-3-span">퀴즈 남은 기회</span> <span
								class="_1-3-span2">1</span> <span class="_1-3-span3">/ 3</span>
							</span>
						</div>
						<div class="_3">하루에 총 3개의 퀴즈를 풀 수 있어요</div>
					</div>
					<div class="quizpoint">
						<div class="_30-p">
							<span> <span class="_30-p-span">지금까지 퀴즈를 풀어서</span> <span
								class="_30-p-span2">30P</span> <span class="_30-p-span3">를
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

