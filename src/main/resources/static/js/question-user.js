document.addEventListener('DOMContentLoaded', function () {
    var titles = document.querySelectorAll('.questionTitle');
    titles.forEach(function (title) {
        title.addEventListener('click', function () {
            var isPublic = this.getAttribute('data-public') === '0';
            var userId = this.getAttribute('data-user-id');
            var loggedInUserId = this.getAttribute('data-logged-in-user-id');

            console.log("userId:", userId); // 디버깅 로그
            console.log("loggedInUserId:", loggedInUserId); // 디버깅 로그

            if (isPublic || userId === loggedInUserId) {
                var content = this.nextElementSibling;
                var answer = content ? content.nextElementSibling : null;
				
                // 현재 항목이 열려 있는지 확인
                var isVisible = $(content).is(':visible');
                
                // 모든 내용 및 답변 닫기
                $('.questionContent, .questionAnswer').slideUp(0);

                // 현재 항목이 열려있지 않을 때만 열기
                if (!isVisible) {
                    if (content && content.classList.contains('questionContent')) {
                        $(content).slideToggle(0, function() {
                            if (answer && answer.classList.contains('questionAnswer') && answer.textContent.trim() !== '' && answer.textContent.trim() !== '관리자') {
                                $(answer).slideDown(0);
                            }
                        });
                    }
                }
            } else {
                alert('해당 항목을 볼 권한이 없습니다.');
            }
        });
    });
});