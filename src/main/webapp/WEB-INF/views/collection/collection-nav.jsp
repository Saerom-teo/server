<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/vars.css">
<link rel="stylesheet" href="css/style.css">

<body>
    <div class="semi-header">
        <div id="semi-header-container">
        	<a href="intro">참여안내</a>
        	<a href="regist">신청하기</a>
        	<a href="request">수거요청</a>
        	<a href="#">수거현황</a>
        </div>
    </div>
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        var lastScrollTop = 0;
        var semiHeader = document.getElementById('semi-header');

        window.addEventListener('scroll', function () {
            var scrollTop = window.pageYOffset || document.documentElement.scrollTop;

            if (scrollTop > lastScrollTop) {
                semiHeader.classList.add('hidden');
                semiHeader.classList.remove('shown');
            } else {
                semiHeader.classList.add('shown');
                semiHeader.classList.remove('hidden');
            }
            lastScrollTop = scrollTop;
        });
    });

    </script>
</body>


</html>