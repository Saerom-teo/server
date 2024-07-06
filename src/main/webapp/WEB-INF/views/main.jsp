<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/vars.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css">
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
            text-decoration: none;
            background: none;
            -webkit-font-smoothing: antialiased;
        }

        menu,
        ol,
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        .wrap {
            position: absolute;
            width: 100%;
            height: 100%;
            display: flex;
            transition: left 0.3s ease-in-out;
        }

        .wrap .banner-img {
            width: 100vw;
            height: 100%;
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
        }

        .indicators {
            display: flex;
            justify-content: center;
            margin-top: 10px;
        }

        .ellipse-214,
        .ellipse-212 {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background-color: var(--lightgray);
            margin-bottom: 5px;
        }

        .active-indicator {
            background-color: green;
        }


        @keyframes fadeInUp {
            0% {
                opacity: 0;
                transform: translateY(20px);
            }

            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .on {
            animation: fadeInUp 1.5s ease-in-out;
        }
        
        .nav-container {
        	width: 70%;
    		display: flex;
    		align-items: center;
    		justify-content: space-between;
        }
        
        .menu-1:hover {
			border-color: var(--primary);
			color: var(--primary) !important;
		}
    </style>

    <script>
        $(document).ready(function () {
            var iw = $(".banner").width();   // 이미지 너비
            var ih = 760;  // 이미지 높이
            var total = $(".banner-img").length;   // 이미지의 개수
            $(".wrap").css({ "width": iw * total }); // 이미지의 개수 * 이미지의 너비
            $(".banner").css({ "width": iw, "height": ih });

            var n = 0;

            function slide() {
                n++;
                if (n == total) {
                    n = 0;
                }
                $(".wrap").animate({ "left": -n * iw }, 300);
                updateIndicators(n);
            }

            function updateIndicators(index) {
                $('.ellipse-214, .ellipse-212').removeClass('active-indicator');
                $('.ellipse-214, .ellipse-212').eq(index).addClass('active-indicator');
            }

            function startSlider() {
                interval = setInterval(slide, 4000);
            }

            function stopSlider() {
                clearInterval(interval);
            }

            updateIndicators(n);
            startSlider();

            $(".banner").hover(stopSlider, startSlider);

            const content1 = document.querySelector('.body-1-1');
            const content2 = document.querySelector('.body-1-2');
            const content3 = document.querySelector('.body-2');


            function animationWhendisplayed() {
                const observer = new IntersectionObserver((entries, observer) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            entry.target.classList.add('on');
                            observer.unobserve(entry.target); // 애니메이션 후 더 이상 관찰하지 않음
                        }
                    });
                }, { threshold: 0.15 }); // 10% 이상 보일 때 트리거

                observer.observe(content1);
                observer.observe(content2);
                observer.observe(content3);
            }

            animationWhendisplayed();
        });



        
    </script>
    <title>Document</title>
</head>

<body>
    <div class="desktop-80">
        <%@ include file="/WEB-INF/views/collection/header.jsp" %>
            <div class="banner">
                <div class="wrap">
                    <div class="banner-img"
                        style="background-image: url('${pageContext.request.contextPath}/static/img/banner1.png')">
                    </div>
                    <div class="banner-img"
                        style="background-image: url('${pageContext.request.contextPath}/static/img/banner2.png')">
                    </div>
                    <div class="banner-img"
                        style="background-image: url('${pageContext.request.contextPath}/static/img/banner3.png')">
                    </div>
                </div>
                <div class="frame-34">
                    <div class="ellipse-212"></div>
                    <div class="ellipse-212"></div>
                    <div class="ellipse-212"></div>
                </div>
            </div>
            <div class="navibar">
            	<div class="nav-container">
	                <div class="navibar-title">
	                    <p class="div3">자주 쓰는 메뉴</p>
	                </div>
	                <div class="frame-36">
	                    <a class="menu-1" href="${pageContext.request.contextPath}/products">
	                            쇼핑몰 둘러보기
	                    </a>
	                    <a class="menu-1" href="${pageContext.request.contextPath}/dashboard">
	                            환경 보도 자료 확인하기
	                    </a>
	                    <a class="menu-1" href="${pageContext.request.contextPath}/collection/intro">
	                       수거 서비스 신청하기
	                    </a>
	                    <a class="menu-1" href="${pageContext.request.contextPath}/mypage/collection">
	                            수거 현황 보러가기
	                    </a>
	                    <a class="menu-1" href="${pageContext.request.contextPath}/quiz">
	                            퀴즈 풀러 가기
	                    </a>
	                    <a class="menu-1" href="${pageContext.request.contextPath}/notice/readAll">
	                            공지사항 확인하기
	                    </a>
	            	</div>
                </div>
            </div>
            <div class="body-1">
                <div class="body-1-1">
                    <img class="main-image-1-1"
                        src="${pageContext.request.contextPath}/static/img/banner-img-1.png" />
                    <div class="frame-8849">
                        <div class="_01">01</div>
                        <div class="div6">
                            플라스틱을 재활용하여
                            <br />
                            순환경제를 이뤄냅니다.
                            <br />
                        </div>
                        <div class="div7">
                            가정에서 버려지는 플라스틱을 다시 소재로 활용할 수
                            <br />
                            있도록 집 앞 수거함을 통해 재활용률을 높여
                            <br />
                            순환경제를 이뤄냅니다.
                        </div>
                    </div>
                </div>
                <div class="body-1-2">
                    <div class="frame-88492">
                        <div class="_02">02</div>
                        <div class="div8">
                            지속 가능한 미래를
                            <br />
                            꿈꿉니다.
                            <br />
                        </div>
                        <div class="div9">
                            오염된 지구 환경을 개선하여
                            <br />
                            미래 세대에게 깨끗한 지구를 물려줍니다.
                            <br />
                            공존과 균형을 지켜 나가는 것,
                            <br />
                            미래를 위한 우리 세대의 역할입니다.
                        </div>
                    </div>
                    <img class="main-image-1-1"
                        src="${pageContext.request.contextPath}/static/img/banner-img-2.png" />
                </div>
            </div>
            <div class="body-2">
                <div class="frame-8873">
                    <div class="div10">함께하기</div>
                    <div class="div11">
                        새롬터와 함께
                        <br />
                        환경을 지켜주세요.
                    </div>
                </div>
                <div class="frame-8874">
                    <div class="frame-8875" style="
        background: url(${pageContext.request.contextPath}/static/img/main-img-1.png) center;
        background-size: cover;
        background-repeat: no-repeat;
        ">
                        <div class="frame-8879">
                            <div class="div12">올레핀 이용방법</div>
                            
                        </div>
                        	<div class="div12-1" style="margin-top: 40px;">1. 신청 양식에 따라 개인 정보 입력하기</div>
                            <div class="div12-1">2. 제공된 수거함에 플라스틱 넣기</div>
                            <div class="div12-1">3. 수거함 사진 찍어서 수거 요청 하기</div>
                            <div class="div12-1">4. 수거 현황 확인하고 포인트 받기</div>
                        
                    </div>
                    <div class="frame-8876">
                    <a class="frame-8877" href="${pageContext.request.contextPath}/collection/intro" style="
            background: url(${pageContext.request.contextPath}/static/img/main-img-1.png) center;
            background-size: cover;
            background-repeat: no-repeat;">
                            <div class="frame-88792">
                                <div class="div13">
                                    올레핀 신청하기
                                </div>
                            </div>
                        </a>
                        
                        <a class="frame-8878" href="${pageContext.request.contextPath}/dashboard" style="
						            background: var(--primary);
						            background-size: cover;
						            background-repeat: no-repeat;
						        ">
                            <div class="frame-88792">
                                <div class="div13">
                                    환경 소식 확인하기
                                </div>
                            </div>
                        </a>
                        
                    </div>
                </div>
            </div>
            
			<div class="prd_container">
				<div class="prd_txt">
					<div class="discount_prd">할인 상품</div>
				</div>
				<div class="item-container"></div>
			</div>
	
			<div class="prd_container" id="prd_2">
				<div class="prd_txt">
					<div class="popularity_prd" style="width:100%">인기 상품</div>
				</div>
				<div class="item-container2"></div>
			</div>
		
		<%@ include file="/WEB-INF/views/collection/footer.jsp"%>
	</div>
	<script>
	var originalData = [];
	var originalData2 = [];
	
	 $(document).ready(function() {
		    <c:forEach var="product" items="${productList}">
		        originalData.push({
		            "productCode": "${product.productCode}",
		            "productName": "${product.productName}",
		            "productPrice": ${product.productPrice},
		            "discountedPrice": ${product.discountedPrice},
		            "stockQuantity": ${product.stockQuantity},
		            "registrationDate": "${product.registrationDate}",
		            "envMark": "${product.envMark}",
		            "thumbnail": "${product.thumbnail}",
		            "detailImage": "${product.detailImage}",
		            "categoryNumber": ${product.categoryNumber},
		            "discountCode": ${product.discountCode},
		            "discountRate": ${product.discountRate != null ? product.discountRate : 0},
		        });
		    </c:forEach>
		    
		    <c:forEach var="product" items="${productList}">
	        originalData2.push({
	            "productCode": "${product.productCode}",
	            "productName": "${product.productName}",
	            "productPrice": ${product.productPrice},
	            "discountedPrice": ${product.discountedPrice},
	            "stockQuantity": ${product.stockQuantity},
	            "registrationDate": "${product.registrationDate}",
	            "envMark": "${product.envMark}",
	            "thumbnail": "${product.thumbnail}",
	            "detailImage": "${product.detailImage}",
	            "categoryNumber": ${product.categoryNumber},
	            "discountCode": ${product.discountCode},
	            "discountRate": ${product.discountRate != null ? product.discountRate : 0},
	            "wishlistCount" : ${product.wishCount}
	        });
	    </c:forEach>
	
		productSort();
	 });
	
	/* 상품 정렬 */
	function productSort(){
	    var sortBy = $(".discount_prd").text(); 
	    var sortBy_2 = $(".popularity_prd").text();
	    
	  	if(sortBy == "할인 상품"){
	        originalData.sort((a, b) => b.discountRate - a.discountRate);
	    } 
	  	 
	  	if(sortBy_2 == "인기 상품"){ // 위시리스트 많이 담긴 순 
	  		originalData2.sort((a, b) => b.wishlistCount - a.wishlistCount);
	    } 
	  	display();
	}
	
	function display(){
		$(".item-container").empty();
		$(".item-container2").empty();
		
		originalData.slice(0, 4).forEach(function(product) {
            // 각 상품에 대한 HTML 생성 후 .item-container에 추가
            var itemHtml = `<div class="item" onclick="location.href='${pageContext.request.contextPath}/products/`+ product.productCode +`'">
                <img src="${pageContext.request.contextPath}/static/img/product-img.png" class="item-image">
                <div class="item-details">
                    <div><p>${'${product.productName}'}</p></div>
                    <div class="price-container">`;
                        
                    if (product.discountRate && product.discountRate > 0) {
                    // 할인율 % 표시
                    var discountRateInt = product.discountRate * 100;
                    	itemHtml += `<div class="percent">[${'${discountRateInt}'}%]</div>`;
                	}
                   
                   itemHtml += `<div>${'${product.discountedPrice}'}원</div>`;
                   
                   if (product.discountRate > 0 ) {
                       itemHtml += `<div class="original-price">&nbsp;${'${product.productPrice}'}원</div>`;
                       
                   }
                   
                   itemHtml += `</div>`;
                   
                   if (product.discountRate && product.discountRate > 0) {
                       itemHtml += `<span class="sale">SALE</span>`;
                   }
                   
                   itemHtml += `<span class="best">BEST</span>
                       </div>
                   </div>`;
            
            $(".item-container").append(itemHtml);
        });
		
		originalData2.slice(0, 4).forEach(function(product) {
            // 각 상품에 대한 HTML 생성 후 .item-container에 추가
            var itemHtml = `<div class="item" onclick="location.href='${pageContext.request.contextPath}/products/`+ product.productCode +`'">
                <img src="${pageContext.request.contextPath}/static/img/product-img.png" class="item-image">
                <div class="item-details">
                    <div><p>${'${product.productName}'}</p></div>
                    <div class="price-container">`;
                        
                    if (product.discountRate && product.discountRate > 0) {
                    // 할인율 % 표시
                    var discountRateInt = product.discountRate * 100;
                    	itemHtml += `<div class="percent">[${'${discountRateInt}'}%]</div>`;
                	}
                   
                   itemHtml += `<div>${'${product.discountedPrice}'}원</div>`;
                   
                   if (product.discountRate > 0 ) {
                       itemHtml += `<div class="original-price">&nbsp;${'${product.productPrice}'}원</div>`;
                       
                   }
                   
                   itemHtml += `</div>`;
                   
                   if (product.discountRate && product.discountRate > 0) {
                       itemHtml += `<span class="sale">SALE</span>`;
                   }
                   
                   itemHtml += `<span class="best">BEST</span>
                       </div>
                   </div>`;
            
            $(".item-container2").append(itemHtml);
        });
	}
    </script>
</body>
</html>