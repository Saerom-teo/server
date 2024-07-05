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
	href="${pageContext.request.contextPath}/static/css/shopnav.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<title>Document</title>

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
   .shopnav {
	   position: fixed;
		top: var(--header-size);
		width: 100%;
		z-index: 80;
	}.hidden {
	animation: hide 0.1s linear forwards;
}

@keyframes hide {
	from {
		opacity: 1;
	}

	to {
		opacity: 0;
		visibility: hidden;
	}
}

.shown {
	animation: show 0.1s linear forwards;
}

@keyframes show {
	from {
		visibility: hidden;
		opacity: 0;
	}

	to {
		visibility: visible;
		opacity: 1;
	}
}
   </style>
</head>
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
<body>
  <div class="shopnav" id="semi-header">
    <div class="shopnavbar">
    <div class="shopnav-div2 all-products nav-active">전체</div>
   	<c:forEach items="${major}" var="category_major">
   	<div class="box" style="padding:0; maring:0">
      <div class="shopnav-div2 major major${category_major}">${category_major}</div>
      
      <div class="shopnavdetail">
	      <div class="shopnavdetailcontent">
      <c:forEach items="${middle}" var="category_middle">
      <c:if test="${category_middle.majorCategory == category_major}">
	        <div class="navcategory-1">
	        
	          <div class="shopnav-div4 middle">${category_middle.middleCategory}</div>
	          
	          <c:forEach items="${category}" var="categoryVO">
	          <c:if test="${categoryVO.majorCategory == category_major && categoryVO.middleCategory == category_middle.middleCategory}">
	          <div class="shopnav-div5 small"><pre>${categoryVO.smallCategory}</pre></div>
	          </c:if>
	          </c:forEach>
	        </div>
    	</c:if>
    	</c:forEach>
	      </div>
    	</div>
    </div>
    </c:forEach>
    
      
    </div>
    
  </div>
  
</body>
</html>