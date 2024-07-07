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
	href="${pageContext.request.contextPath}/static/css/review.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<title>Review</title>
<style>
		*{
			padding: 0;
			margin: 0;
			font-family: 'Noto Sans KR' !important;
		}

		.header {
			display: flex;
			justify-content: center;
			padding: 15px 0;
			box-shadow: 0px 7px 10px 0px rgba(0, 0, 0, 0.1);
			position: fixed;
			top: 0;
			width: 100%;
			z-index: 100;
			background: #ffffff;
			height: var(--header-size);
			box-sizing: border-box;
		}

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;

        }
        .wrapper {
            display: flex;
            margin-top: var(--header-size);
            width: 70%;
            min-width: 800px;
        }
        .collection-content {
            width: 100%;
        }
        .collection-name {
            border-style: solid;
            border-color: var(--gray);
            border-width: 0px 0px 1px 0px;
            padding: 60px 20px 10px 40px;
            color: var(--primary);
        }
        #collection-list {
            margin-top: 40px;
        	margin-bottom: 80px;
        	padding-left: 35px;
        }
        #collection-list h3 {
            margin-bottom: 20px;
        }

        /* Modal styles */
        .modal {
            position: fixed; 
            z-index: 100; 
            left: 0;
            top: 0;
            width: 100%;
            height: 100vh;
            overflow: auto; 
            background-color: rgb(0,0,0); 
            background-color: rgba(0,0,0,0.4); 
            display: none;
    		justify-content: center;
    		align-items: center;
        }

        .modal-content {
            background-color: #fefefe; 
            padding: 20px;
            width: 80%;
            max-width: 600px;
            display: flex;
    		flex-direction: column;
    		border-radius: 10px;
        }
        
        .modal-content hr {
        	color: var(--gray);
        	margin: 10px 0;
        	width: 100%;
        	border: 1px solid;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .result-images {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .result-images img {
            width: 48%;
            margin-bottom: 10px;
        }
        .category {
			box-sizing: border-box;
		    margin: 20px 0;
		    display: flex;
		    flex-direction: row;
		    justify-content: space-between;
        }
        
		 .category a {
            border: 1px solid var(--primary);
            border-radius: 8px;
            padding: 4px 25px;
            margin: 0 5px;
            cursor: pointer;
            text-decoration: none;
            color: var(--black);
            font-size: 14px;
        }
        
        
        .category a:hover {
			background-color: var(--tertiary);    
        }
        .category input {
        	border: 1px solid var(--primary);
        	padding: 4px 20px;
        	border-radius: 8px;
        	color: var(--black);
        	margin: 0 5px;
        }
        .category input:hover {
			background-color: var(--tertiary);
        }
        
        .category input:focus  {
			border-color: var(--primary);
        }
        .category button  {
			background-color: var(--primary);
			color: #fff;
			padding: 4px 20px;
			border-radius: 8px;
			font-size: 14px;
        }
    </style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
	    // 원하는 id에 current-page 클래스를 추가합니다.
	    var currentPageId = "review";
	    document.getElementById(currentPageId).classList.add("current-page");
	});

	var nowStar = 5;

	function deleteReview(reviewId) {
		if(confirm("작성한 후기를 삭제하시겠습니까?"))
		$.ajax({
			url:"${pageContext.request.contextPath}/review/deleteReview/" + reviewId,
			type: "DELETE",
			success: function(response) {
				alert("후기를 삭제하였습니다.");
				location.href = "${pageContext.request.contextPath}/review"
			}, error: function(xhr, status, error) {
				alert("삭제 실패");
			}
		})
	}
	function readBetweenDate() {
		var startdate = $(".startdate").val();
		var enddate = $(".enddate").val();
		location.href = "${pageContext.request.contextPath}/review/"+startdate+"/"+enddate;	
	}
	
	function changeStar(reviewId, starNum) {
		nowStar = starNum;
		$(".enrollStar" + reviewId).attr("src", "${pageContext.request.contextPath}/static/img/star2.svg");
		for(let i=0; i < starNum+1; i++) {
			$(".enrollStar" + reviewId + "-" + i).attr("src", "${pageContext.request.contextPath}/static/img/star.svg");
		}
	}
	
	function modify(reviewId, now) {
		nowStar = now;
		$(".review_w"+reviewId).attr("disabled", false);
		$(".review_w"+reviewId).addClass("review_w_update");
		$(".enrollStar"+reviewId).addClass("cursor");
		$(".enrollStar"+reviewId+"-1").attr("onclick", "changeStar("+reviewId+", 1)");
		$(".enrollStar"+reviewId+"-2").attr("onclick", "changeStar("+reviewId+", 2)");
		$(".enrollStar"+reviewId+"-3").attr("onclick", "changeStar("+reviewId+", 3)");
		$(".enrollStar"+reviewId+"-4").attr("onclick", "changeStar("+reviewId+", 4)");
		$(".enrollStar"+reviewId+"-5").attr("onclick", "changeStar("+reviewId+", 5)");
		$(".modify").attr("hidden", true);
		$(".complete").attr("hidden", false);
		$(".cancel").attr("hidden", false);
				
		$(".file").attr("hidden", false);
		
	}
	
	function cancel(reviewId, reviewContent, reviewScore) {
		$(".review_w"+reviewId).attr("disabled", true);
		$(".review_w"+reviewId).removeClass("review_w_update");
		$(".review_w"+reviewId).val(reviewContent);
		$(".enrollStar"+reviewId).removeClass("cursor");
		
		$(".modify").attr("hidden", false);
		$(".complete").attr("hidden", true);
		$(".cancel").attr("hidden", true);
		
		changeStar(reviewId, reviewScore);
	}
	
	function complete(reviewId) {
		if(confirm("수정하시겠습니까?")) {
			var review_data = {
					"reviewId" : reviewId,
					"reviewContent" : $(".review_w"+reviewId).val(),
					"reviewScore" : nowStar,
				}
			$.ajax({
		        url: '${pageContext.request.contextPath}/review/updateReview',
		        type: 'PUT',
		        contentType:"application/json",
				data:JSON.stringify(review_data),
		        success: function(response) {
		        	alert("리뷰가 수정되었습니다.");
		        	location.href = "${pageContext.request.contextPath}/review";
		        },
		        error: function(xhr, status, error) {
		        	alert("수정 실패")
		        }
		    });
		}
	} 
	

</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/collection/header.jsp"%>
	<div class="wrapper">
        <%@ include file="/WEB-INF/views/common/mypage-nav.jsp" %>
        <div class="collection-content">
            <div class="collection-name">
                <h1>구매후기</h1>
            </div>
            <div id="collection-list">
            
            <div class="category">
            		<div>
						<a href="${pageContext.request.contextPath}/review/365" id="year" class="">최근 1년</a>
            			<a href="location.href=`${pageContext.request.contextPath}/review/7" id="week" class="">1주일</a>
            			<a href="${pageContext.request.contextPath}/review/30" id="one-month" class="">1개월</a>
            			<a href="location.href=`${pageContext.request.contextPath}/review/90" id="three-month" class="">3개월</a>
            		</div>
            		<div>
			            <input type="date" id="startDate" class="startdate"></input>
			            <input type="date" id="endDate" class="enddate"></input>
			            <button onclick="readBetweenDate()">조회하기</button>
            		</div>
            	</div>
                <div id="collection-table">
                <div class="item-container">
					<c:forEach var="review" items="${reviewList}">
					<div class="item">
						<div class="item-info">
							<img
								src="${review.productImage}"
								class="item-image">
							<p class="item-name">${review.productName}</p>
							<div style="display:flex; width:100%; justify-content:right">
								<div class="written">${review.writeDate} 작성</div>
								<div class="delete-btn" onclick="deleteReview(${review.reviewId})">✕</div>
							</div>
						</div>
						
						<div class="width_line2"></div>
						<div class="star">
								
								
						<c:forEach var="var" begin="0" end="4">
							<c:if test="${var < review.reviewScore}">
							<img class="enrollStar${review.reviewId} enrollStar${review.reviewId}-${var+1}" src="${pageContext.request.contextPath}/static/img/star.svg">
							</c:if>
							<c:if test="${var >= review.reviewScore}">
							<img class="enrollStar${review.reviewId} enrollStar${review.reviewId}-${var+1}" src="${pageContext.request.contextPath}/static/img/star2.svg">
							</c:if>
						</c:forEach>
						
						</div>
						<textarea class="review_w review_w${review.reviewId}" disabled="true">${review.reviewContent}</textarea>
						
						<div style="display: flex; justify-content: space-between;">
							<c:if test="${review.reviewImage != null }">
							<img src="${review.reviewImage}"
								class="item-image2 item-image${review.reviewId}">
								</c:if>
							<div class="buttonBar" style="display:flex; width:100%; justify-content: right; align-items: end;">
								<div class="modify" onclick="modify(${review.reviewId}, ${review.reviewScore})" >수정하기</div>
								<div class="cancel" onclick="cancel(${review.reviewId}, '${review.reviewContent }', ${review.reviewScore })" hidden>취소하기</div>
								<div class="complete" onclick="complete(${review.reviewId})" hidden>등록하기</div>
							</div>
						</div>
					</div>
					</c:forEach>
				</div>
                </div>
            </div>
        </div>
    </div>
	
	
	
	<%@ include file="/WEB-INF/views/collection/footer.jsp"%>
</body>

</html>
