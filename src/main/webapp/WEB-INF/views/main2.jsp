<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!DOCTYPE html>
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
   </style>
  <title>Document</title>
</head>
<body>
  <div class="desktop-80">
  <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <div class="banner">
      <div class="div">
        <span>
          <span class="div-span">
            플라스틱 버리고,
            <br />
          </span>
          <span class="div-span2">쇼핑</span>
          <span class="div-span3">도 하자!</span>
        </span>
      </div>
      <div class="div2">
        플라스틱 수거 서비스를 신청하면 쓰레기를
        <br />
        대신 버리고 포인트를 지급해 드려요.
      </div>
      <img class="_1-1" src="${pageContext.request.contextPath}/static/img/main-img-0.png" />
      <div class="frame-34">
        <div class="ellipse-212"></div>
        <div class="ellipse-213"></div>
        <div class="ellipse-214"></div>
        <div class="ellipse-215"></div>
        <div class="ellipse-216"></div>
        <div class="ellipse-217"></div>
        <div class="ellipse-220"></div>
      </div>
    </div>
    <div class="navibar">
      <div class="navibar-title">
        <div class="div3">자주 쓰는 메뉴</div>
      </div>
      <div class="frame-36">
        <div class="menu-1">
          <div class="div4">환경 교육 듣기</div>
        </div>
        <div class="menu-1">
          <div class="div4">환경 보도 자료 확인하기</div>
        </div>
        <div class="menu-2">
          <div class="div5">수거 서비스 신청하기</div>
        </div>
        <div class="menu-1">
          <div class="div4">수거 현황 보러가기</div>
        </div>
        <div class="menu-1">
          <div class="div4">인기 상품 확인하기</div>
        </div>
        <div class="menu-1">
          <div class="div4">내 등급 확인하기</div>
        </div>
        <div class="menu-1">
          <div class="div4">수거 서비스 신청하기</div>
        </div>
      </div>
    </div>
    <div class="body-1">
      <div class="body-1-1">
        <img class="main-image-1-1" src="${pageContext.request.contextPath}/static/img/banner-img-1.png" />
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
        <img class="main-image-2-1" src="${pageContext.request.contextPath}/static/img/banner-img-2.png" />
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
        <div
          class="frame-8875"
          style="
            background: url(${pageContext.request.contextPath}/static/img/main-img-1.png) center;
            background-size: cover;
            background-repeat: no-repeat;
          "
        >
          <div class="frame-8879">
            <div class="div12">올레핀 신청하기</div>
          </div>
        </div>
        <div class="frame-8876">
          <div
            class="frame-8877"
            style="
              background: url(${pageContext.request.contextPath}/static/img/main-img-1.png) center;
              background-size: cover;
              background-repeat: no-repeat;
            "
          >
            <div class="frame-88792">
              <div class="div13">
                올레핀
                <br />
                신청방법 안내
              </div>
            </div>
          </div>
          <div
            class="frame-8878"
            style="
              background: url(${pageContext.request.contextPath}/static/img/main-img-2.png) center;
              background-size: cover;
              background-repeat: no-repeat;
            "
          >
            <div class="frame-88792">
              <div class="div13">
                새롬터
                <br />
                환경 뉴스 &amp; 자료
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="body-3">
      <div class="frame-30">
        <div class="div14">할인 상품</div>
      </div>
      <div class="div15">
        <div class="frame-20">
          <img class="_1-15487" src="${pageContext.request.contextPath}/static/img/product-img.png" />
          <div class="frame-21">
            <div class="div16">
              <span>
                <span class="div-16-span">[소락] 오가닉 코튼 자수 손수건</span>
                <span class="div-16-span2"></span>
              </span>
            </div>
            <div class="group-8899">
              <div class="group-8898">
                <div class="_7000">
                  <span>
                    <span class="_7000-span">7000 원</span>
                    <span class="_7000-span2"></span>
                    <span class="_7000-span3"></span>
                    <span class="_7000-span4"></span>
                  </span>
                </div>
                <div class="line-7"></div>
              </div>
              <div class="_5000">
                <span>
                  <span class="_5000-span">5000 원</span>
                  <span class="_5000-span2"></span>
                </span>
              </div>
            </div>
            <div class="group-8900">
              <div class="frame-19">
                <div class="best">BEST</div>
              </div>
              <div class="frame-18">
                <div class="sale">SALE</div>
              </div>
            </div>
          </div>
        </div>
        <div class="frame-212">
          <img class="_1-15487" src="${pageContext.request.contextPath}/static/img/product-img.png" />
          <div class="frame-21">
            <div class="div16">
              <span>
                <span class="div-16-span3">[소락] 오가닉 코튼 자수 손수건</span>
                <span class="div-16-span4"></span>
              </span>
            </div>
            <div class="group-8899">
              <div class="group-8898">
                <div class="_7000">
                  <span>
                    <span class="_7000-span5">7000 원</span>
                    <span class="_7000-span6"></span>
                    <span class="_7000-span7"></span>
                    <span class="_7000-span8"></span>
                  </span>
                </div>
                <div class="line-7"></div>
              </div>
              <div class="_5000">
                <span>
                  <span class="_5000-span3">5000 원</span>
                  <span class="_5000-span4"></span>
                </span>
              </div>
            </div>
            <div class="group-8900">
              <div class="frame-19">
                <div class="best">BEST</div>
              </div>
              <div class="frame-18">
                <div class="sale">SALE</div>
              </div>
            </div>
          </div>
        </div>
        <div class="frame-22">
          <img class="_1-15487" src="${pageContext.request.contextPath}/static/img/product-img.png" />
          <div class="frame-21">
            <div class="div16">
              <span>
                <span class="div-16-span5">[소락] 오가닉 코튼 자수 손수건</span>
                <span class="div-16-span6"></span>
              </span>
            </div>
            <div class="group-8899">
              <div class="group-8898">
                <div class="_7000">
                  <span>
                    <span class="_7000-span9">7000 원</span>
                    <span class="_7000-span10"></span>
                    <span class="_7000-span11"></span>
                    <span class="_7000-span12"></span>
                  </span>
                </div>
                <div class="line-7"></div>
              </div>
              <div class="_5000">
                <span>
                  <span class="_5000-span5">5000 원</span>
                  <span class="_5000-span6"></span>
                </span>
              </div>
            </div>
            <div class="group-8900">
              <div class="frame-19">
                <div class="best">BEST</div>
              </div>
              <div class="frame-18">
                <div class="sale">SALE</div>
              </div>
            </div>
          </div>
        </div>
        <div class="frame-23">
          <img class="_1-15487" src="${pageContext.request.contextPath}/static/img/product-img.png" />
          <div class="frame-21">
            <div class="div16">
              <span>
                <span class="div-16-span7">[소락] 오가닉 코튼 자수 손수건</span>
                <span class="div-16-span8"></span>
              </span>
            </div>
            <div class="group-8899">
              <div class="group-8898">
                <div class="_7000">
                  <span>
                    <span class="_7000-span13">7000 원</span>
                    <span class="_7000-span14"></span>
                    <span class="_7000-span15"></span>
                    <span class="_7000-span16"></span>
                  </span>
                </div>
                <div class="line-7"></div>
              </div>
              <div class="_5000">
                <span>
                  <span class="_5000-span7">5000 원</span>
                  <span class="_5000-span8"></span>
                </span>
              </div>
            </div>
            <div class="group-8900">
              <div class="frame-19">
                <div class="best">BEST</div>
              </div>
              <div class="frame-18">
                <div class="sale">SALE</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="body-32">
      <div class="frame-30">
        <div class="div14">인기 상품</div>
      </div>
      <div class="div15">
        <div class="frame-20">
          <img class="_1-15487" src="${pageContext.request.contextPath}/static/img/product-img.png" />
          <div class="frame-21">
            <div class="div16">
              <span>
                <span class="div-16-span9">[소락] 오가닉 코튼 자수 손수건</span>
                <span class="div-16-span10"></span>
              </span>
            </div>
            <div class="group-8899">
              <div class="group-8898">
                <div class="_7000">
                  <span>
                    <span class="_7000-span17">7000 원</span>
                    <span class="_7000-span18"></span>
                    <span class="_7000-span19"></span>
                    <span class="_7000-span20"></span>
                  </span>
                </div>
                <div class="line-7"></div>
              </div>
              <div class="_5000">
                <span>
                  <span class="_5000-span9">5000 원</span>
                  <span class="_5000-span10"></span>
                </span>
              </div>
            </div>
            <div class="group-8900">
              <div class="frame-19">
                <div class="best">BEST</div>
              </div>
              <div class="frame-18">
                <div class="sale">SALE</div>
              </div>
            </div>
          </div>
        </div>
        <div class="frame-212">
          <img class="_1-15487" src="${pageContext.request.contextPath}/static/img/product-img.png" />
          <div class="frame-21">
            <div class="div16">
              <span>
                <span class="div-16-span11">[소락] 오가닉 코튼 자수 손수건</span>
                <span class="div-16-span12"></span>
              </span>
            </div>
            <div class="group-8899">
              <div class="group-8898">
                <div class="_7000">
                  <span>
                    <span class="_7000-span21">7000 원</span>
                    <span class="_7000-span22"></span>
                    <span class="_7000-span23"></span>
                    <span class="_7000-span24"></span>
                  </span>
                </div>
                <div class="line-7"></div>
              </div>
              <div class="_5000">
                <span>
                  <span class="_5000-span11">5000 원</span>
                  <span class="_5000-span12"></span>
                </span>
              </div>
            </div>
            <div class="group-8900">
              <div class="frame-19">
                <div class="best">BEST</div>
              </div>
              <div class="frame-18">
                <div class="sale">SALE</div>
              </div>
            </div>
          </div>
        </div>
        <div class="frame-22">
          <img class="_1-15487" src="${pageContext.request.contextPath}/static/img/product-img.png" />
          <div class="frame-21">
            <div class="div16">
              <span>
                <span class="div-16-span13">[소락] 오가닉 코튼 자수 손수건</span>
                <span class="div-16-span14"></span>
              </span>
            </div>
            <div class="group-8899">
              <div class="group-8898">
                <div class="_7000">
                  <span>
                    <span class="_7000-span25">7000 원</span>
                    <span class="_7000-span26"></span>
                    <span class="_7000-span27"></span>
                    <span class="_7000-span28"></span>
                  </span>
                </div>
                <div class="line-7"></div>
              </div>
              <div class="_5000">
                <span>
                  <span class="_5000-span13">5000 원</span>
                  <span class="_5000-span14"></span>
                </span>
              </div>
            </div>
            <div class="group-8900">
              <div class="frame-19">
                <div class="best">BEST</div>
              </div>
              <div class="frame-18">
                <div class="sale">SALE</div>
              </div>
            </div>
          </div>
        </div>
        <div class="frame-23">
          <img class="_1-15487" src="${pageContext.request.contextPath}/static/img/product-img.png" />
          <div class="frame-21">
            <div class="div16">
              <span>
                <span class="div-16-span15">[소락] 오가닉 코튼 자수 손수건</span>
                <span class="div-16-span16"></span>
              </span>
            </div>
            <div class="group-8899">
              <div class="group-8898">
                <div class="_7000">
                  <span>
                    <span class="_7000-span29">7000 원</span>
                    <span class="_7000-span30"></span>
                    <span class="_7000-span31"></span>
                    <span class="_7000-span32"></span>
                  </span>
                </div>
                <div class="line-7"></div>
              </div>
              <div class="_5000">
                <span>
                  <span class="_5000-span15">5000 원</span>
                  <span class="_5000-span16"></span>
                </span>
              </div>
            </div>
            <div class="group-8900">
              <div class="frame-19">
                <div class="best">BEST</div>
              </div>
              <div class="frame-18">
                <div class="sale">SALE</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="body-33">
      <div class="frame-30">
        <div class="div14">환경 뉴스</div>
      </div>
      <div class="div15">
        <div class="frame-20">
          <img class="_1-15487" src="${pageContext.request.contextPath}/static/img/product-img.png" />
          <div class="frame-21">
            <div class="div16">
              <span>
                <span class="div-16-span17">[소락] 오가닉 코튼 자수 손수건</span>
                <span class="div-16-span18"></span>
              </span>
            </div>
            <div class="group-8899">
              <div class="group-8898">
                <div class="_7000">
                  <span>
                    <span class="_7000-span33">7000 원</span>
                    <span class="_7000-span34"></span>
                    <span class="_7000-span35"></span>
                    <span class="_7000-span36"></span>
                  </span>
                </div>
                <div class="line-7"></div>
              </div>
              <div class="_5000">
                <span>
                  <span class="_5000-span17">5000 원</span>
                  <span class="_5000-span18"></span>
                </span>
              </div>
            </div>
            <div class="group-8900">
              <div class="frame-19">
                <div class="best">BEST</div>
              </div>
              <div class="frame-18">
                <div class="sale">SALE</div>
              </div>
            </div>
          </div>
        </div>
        <div class="frame-212">
          <img class="_1-15487" src="${pageContext.request.contextPath}/static/img/product-img.png" />
          <div class="frame-21">
            <div class="div16">
              <span>
                <span class="div-16-span19">[소락] 오가닉 코튼 자수 손수건</span>
                <span class="div-16-span20"></span>
              </span>
            </div>
            <div class="group-8899">
              <div class="group-8898">
                <div class="_7000">
                  <span>
                    <span class="_7000-span37">7000 원</span>
                    <span class="_7000-span38"></span>
                    <span class="_7000-span39"></span>
                    <span class="_7000-span40"></span>
                  </span>
                </div>
                <div class="line-7"></div>
              </div>
              <div class="_5000">
                <span>
                  <span class="_5000-span19">5000 원</span>
                  <span class="_5000-span20"></span>
                </span>
              </div>
            </div>
            <div class="group-8900">
              <div class="frame-19">
                <div class="best">BEST</div>
              </div>
              <div class="frame-18">
                <div class="sale">SALE</div>
              </div>
            </div>
          </div>
        </div>
        <div class="frame-22">
          <img class="_1-15487" src="${pageContext.request.contextPath}/static/img/product-img.png" />
          <div class="frame-21">
            <div class="div16">
              <span>
                <span class="div-16-span21">[소락] 오가닉 코튼 자수 손수건</span>
                <span class="div-16-span22"></span>
              </span>
            </div>
            <div class="group-8899">
              <div class="group-8898">
                <div class="_7000">
                  <span>
                    <span class="_7000-span41">7000 원</span>
                    <span class="_7000-span42"></span>
                    <span class="_7000-span43"></span>
                    <span class="_7000-span44"></span>
                  </span>
                </div>
                <div class="line-7"></div>
              </div>
              <div class="_5000">
                <span>
                  <span class="_5000-span21">5000 원</span>
                  <span class="_5000-span22"></span>
                </span>
              </div>
            </div>
            <div class="group-8900">
              <div class="frame-19">
                <div class="best">BEST</div>
              </div>
              <div class="frame-18">
                <div class="sale">SALE</div>
              </div>
            </div>
          </div>
        </div>
        <div class="frame-23">
          <img class="_1-15487" src="${pageContext.request.contextPath}/static/img/product-img.png" />
          <div class="frame-21">
            <div class="div16">
              <span>
                <span class="div-16-span23">[소락] 오가닉 코튼 자수 손수건</span>
                <span class="div-16-span24"></span>
              </span>
            </div>
            <div class="group-8899">
              <div class="group-8898">
                <div class="_7000">
                  <span>
                    <span class="_7000-span45">7000 원</span>
                    <span class="_7000-span46"></span>
                    <span class="_7000-span47"></span>
                    <span class="_7000-span48"></span>
                  </span>
                </div>
                <div class="line-7"></div>
              </div>
              <div class="_5000">
                <span>
                  <span class="_5000-span23">5000 원</span>
                  <span class="_5000-span24"></span>
                </span>
              </div>
            </div>
            <div class="group-8900">
              <div class="frame-19">
                <div class="best">BEST</div>
              </div>
              <div class="frame-18">
                <div class="sale">SALE</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp"%>
  </div>
  
</body>
</html>