<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
<!DOCTYPE html>
<html lang="en">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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

@keyframes fadeInUp {
        0% { opacity: 0; transform: translateY(10px); }
        100% { opacity: 1; transform: translateY(0); }
    }

    .quizbox {
        animation: fadeInUp 0.3s ease-in-out; /* fadeInUp 애니메이션을 적용합니다. */
    }
</style>

<script>
document.addEventListener("DOMContentLoaded", function() {
    // 원하는 id에 current-page 클래스를 추가합니다.
    var currentPageId = "quiz";
    document.getElementById(currentPageId).classList.add("current-page");
});
	$(document).ready( function (){
		if(sessionStorage.getItem("quizId") == null) {
			sessionStorage.setItem("quizId",${quizList[0].quizId});	
		}
		if(${chance} <= 0) {
			$("._1-3").html("남은 기회를 모두 소진했어요.");
		}
		
		var list = [];
		<c:forEach var="quiz" items="${quizList}">
			list.push({
				quizId : "${quiz.quizId}",
				quizName : "${quiz.quizName}",
				quizContent : "${quiz.quizContent}",
				quizAnswer : "${quiz.quizAnswer}",
				point : "${quiz.point}"
			});
		</c:forEach>
		
		var solvedList = [];
		<c:forEach var="id" items="${solvedQuizList}">
			solvedList.push("${id}");
		</c:forEach>
		
		let htmlContent = "";
		console.log(list);
	    for(let obj of list) {
	    	console.log(obj);
	        htmlContent += '<div class="quiz-1">';
	        htmlContent += '<div class="div5">';
	        htmlContent += '<ol class="div-5-span">';
	        htmlContent += '<li>' + obj.quizName + '</li></ol>';
	        htmlContent += '</div>';
	        
	        if(solvedList.includes(obj.quizId)) {
	            htmlContent += '<div class="div7">이미 푼 문제입니다.</div>';
	        } else {
	        	
	            htmlContent += '<div class="div6" ><span class="solvespan" onclick="changeProb(' + obj.quizId + ')">풀어보기</span></div>';
	        	$(".quiz-1").hover(function() {
	        		$(".quiz-1").addClass('hoverEffect');
	        	})
	        }
	        
	        htmlContent += '</div>';
	    }

	    $(".quizlistbody").append(htmlContent);
	})
	


	// 푼 내역에 쌓기
	// 만약 해당 문제가 이미 푼 문제라면 네 | 아니요 박스에 이미 푼 문제입니다를 넣기
	function yes() { 
		$.ajax({
			url: "${pageContext.request.contextPath}/quiz/api/createHistory",
			method: "POST",
			contentType: "application/json",
			data: JSON.stringify({
				user_id : null,
				quizId : sessionStorage.getItem("quizId"),
				userAnswer: true
			}),
			success : function(res) {
				//res에 따라 결정 정답이면 true 아니면 false를 반환한다.
				// res가 1일 경우 어떻게 하고
				// res가 0일 경우 어떻게 할지 결정
				if(res == 1) {

					async function showCorrectAnswer() {
	                    $(".quizbox").html("<div class='div2'>정답입니다!</div>");
	                    $(".quizbox").css("background", "blue");
	                    await new Promise(resolve => setTimeout(resolve, 2000));
	                    location.reload(true);
	                }

	                showCorrectAnswer();
					
				} else {
					async function showCorrectAnswer() {
	                    $(".quizbox").html("<div class='div2'>오답입니다.</div>");
	                    $(".quizbox").css("background", "red");
	                    await new Promise(resolve => setTimeout(resolve, 2000));
	                    location.reload(true);
	                }

	                showCorrectAnswer();
				}
				
			},
			error: function(xhr, status, error) {
	            console.error(xhr.responseText);
	        }
		});
	}
	function no() { 
		$.ajax({
			url: "${pageContext.request.contextPath}/quiz/api/createHistory",
			method: "POST",
			contentType: "application/json",
			data: JSON.stringify({
				user_id : null,
				quizId : sessionStorage.getItem("quizId"),
				userAnswer: false
			}),
			success : function(res) {
				//res에 따라 결정 정답이면 true 아니면 false를 반환한다.
				// res가 1일 경우 어떻게 하고
				// res가 0일 경우 어떻게 할지 결정
				if(res == 1) {

					async function showCorrectAnswer() {
	                    $(".quizbox").html("<div class='div2'>정답입니다!</div>");
	                    $(".quizbox").css("background", "blue");
	                    await new Promise(resolve => setTimeout(resolve, 2000));
	                    location.reload(true);
	                }

	                showCorrectAnswer();
					
				} else {
					async function showCorrectAnswer() {
	                    $(".quizbox").html("<div class='div2'>오답입니다.</div>");
	                    $(".quizbox").css("background", "red");
	                    await new Promise(resolve => setTimeout(resolve, 2000));
	                    location.reload(true);
	                }

	                showCorrectAnswer();
				}
				
			},
			error: function(xhr, status, error) {
	            console.error(xhr.responseText);
	        }
			
		});
		
	}
	
	function changeProb(quizId) {
		$.ajax({
			url: "${pageContext.request.contextPath}/quiz/api/readDetail/" + quizId,
			method: "GET",
			success : function(quiz) {
				sessionStorage.setItem("quizId", quiz.quizId);
				$(".quizbox").fadeOut(100, function() {
					$(".q").html("Q.");
					$(".q").append(quiz.quizName)
                    $(".div2").html(quiz.quizContent);
                    $("._10-span2").html(quiz.point);
                    $(".quizbox").fadeIn(100).addClass('animated fadeInUp');
                    
                    $(".quiz-1").removeClass("selected"); // 이전에 선택된 요소 클래스 제거
                    $(".quiz-1[data-quizid='" + quiz.quizId + "']").addClass("selected");
                    
                    $(".select").html('<div class="select-1"> <div class="div3" onclick="yes()">네</div></div><div class="select-2"><div class="div4" onclick="no()">아니요</div></div>')
                });
			},
			error: function(xhr, status, error) {
	            console.error(xhr.responseText);
	        }
		});
	}

</script>

<title>Document</title>
</head>
<body>
	<div class="quiz">
		<%@ include file="/WEB-INF/views/collection/header.jsp"%>
		<%@ include file="/WEB-INF/views/common/dashboard-nav.jsp"%>

		<div class="body">
			<div class="mainquiz">
				<div class="div">퀴즈</div>
				<div class="quizbox">
					<c:if test="${chance <= 0}">
						<div class="div2">오늘 풀 수 있는 문제를 모두 풀었어요<br> 내일 도전해 주세요!</div>
					</c:if>
					<c:if test="${chance > 0}">
						<div class="q">Q. 문제</div>
						<div class="_10">
							<span> <span class="_10-span">문제를 풀면</span> <span
								class="_10-span2"></span><span style="color:yellow">포인트</span> <span class="_10-span3">를
									받을 수 있어요</span>
							</span>
						</div>
						<div class="div2">
							문제를 선택해 보세요
						</div>
						<div class="select">
							
						</div>
					</c:if>
				</div>
			</div>
			<div class="subquiz">
				<div class="quizlist">
					<div class="div">퀴즈 목록</div>
					<div class="quizlistbody">
						
					

					</div>
				</div>
				<div class="quizrecord">
					<div class="div">퀴즈 내역</div>
					<div class="quizchance">
						<div class="_1-3">
							<span> <span class="_1-3-span">퀴즈 남은 기회</span> <span
								class="_1-3-span2">${chance}</span> <span class="_1-3-span3">/ 5</span>
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
	</div>

</body>
</html>

