<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>모달 창 예제</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/icon/favicon.ico">
<script>
        var baseUrl = window.location.protocol + '//' + window.location.host + '<%=request.getContextPath()%>';
</script>
<style>
/* Modal */
.modal {
	visibility: hidden; /* 초기 상태에서는 보이지 않음 */
	opacity: 0;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
	display: flex;
	align-items: center;
	justify-content: center;
	transition: visibility 0s, opacity 0.2s linear;
}

.modal-content {
	background-color: #fefefe;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
	max-width: 600px;
	border-radius: 10px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, .5);
	position: relative;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

#modal-text {
	max-height: 400px;
	overflow-y: auto;
}

.footer {
	text-align: center;
	font-size: 10px;
	color: #B9B7B7;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.footer a {
	color: #B9B7B7;
	text-decoration: none;
}
</style>
</head>
<body>
	<div class="footer">
		<p>
			새롬터 | <a href="#" onclick="openModal('serviceTOS')">이용약관</a> | <a
				href="#" onclick="openModal('personalTOS')">개인정보 처리 방침</a>
		</p>
		<p>SearomTae all rights reserved</p>
	</div>

	<!-- 모달 구조 -->
	<div id="modal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<div id="modal-text"></div>
		</div>
	</div>

	<script>
		// 모달 열기 함수
		window.openModal = function(contentType) {
			const $modal = $('#modal');
			const $modalText = $('#modal-text');

			let url = '';
			// contentType에 따라 요청할 URL 설정
			switch (contentType) {
			case 'serviceTOS':
				url = baseUrl + '/auth/TOS/serviceTOS';
				break;
			case 'personalTOS':
				url = baseUrl + '/auth/TOS/personalTOS';
				break;
			case 'marketingTOS':
				url = baseUrl + '/auth/TOS/marketingTOS';
				break;
			case 'thirdPartyTOS':
				url = baseUrl + '/auth/TOS/thirdPartyTOS';
				break;
			}

			// AJAX 요청으로 URL의 내용을 모달에 표시
			$.get(url, function(data) {
				$modalText.html(data); // 모달 텍스트 업데이트
				$modal.css('visibility', 'visible').css('opacity', '1'); // 모달 표시
			}).fail(function() {
				console.error('Error fetching modal content'); // 에러 처리
			});
		}

		// 모달 닫기 함수
		window.closeModal = function() {
			$('#modal').css('visibility', 'hidden').css('opacity', '0');
		}

		$(document).ready(
				function() {
					// 모달 외부 클릭 시 닫기
					$(window).click(
							function(event) {
								if ($(event.target).is('#modal')) {
									$('#modal').css('visibility', 'hidden')
											.css('opacity', '0');
								}
							});
				});
	</script>

</body>
</html>
