<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/css/afterSales.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/vars.css">
 
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
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
  <div class="mypage-orderlist">
  <div style="display: flex; ">
		<div>
			<%@ include file="/WEB-INF/views/common/mypage-nav.jsp"%>
		</div>
	
    <div class="order-inquiry">
      <div class="order-inquiry-head">
        <div class="div">교환 반품 환불 신청</div>
      </div>
      <div class="order-inquiry-option">
        <div class="_2024-02-12-12-08-25">
          <span>
            <span class="_2024-02-12-12-08-25-span">주문일자</span>
            <span class="_2024-02-12-12-08-25-span2">2024.02.12. 12:08:25</span>
          </span>
        </div>
        <div class="_202305301027050001">
          <span>
            <span class="_202305301027050001-span">주문번호</span>
            <span class="_202305301027050001-span2"></span>
            <span class="_202305301027050001-span3">202305301027050001</span>
          </span>
        </div>
      </div>
      <div class="order-inquiry-list">
        <div class="order-choice">
          <div class="div2">반품 / 교환 요청 상품 선택</div>
          <div class="order-list">
            <img class="group-8914" src="group-89140.svg" />
            <img class="_1-15491" src="_1-154910.png" />
            <div class="group-8915">
              <div class="div3">
                <span>
                  <span class="div-3-span">[소락] 오가닉 코튼 자수 손수건</span>
                  <span class="div-3-span2"></span>
                </span>
              </div>
              <div class="_5000">
                <span>
                  <span class="_5000-span">5000원</span>
                  <span class="_5000-span2"></span>
                  <span class="_5000-span3"></span>
                </span>
              </div>
            </div>
            <div class="frame-8933">
              <div class="frame-8934">
                <div class="div4">반품 수량</div>
                <div class="frame">
                  <div class="frame-117">
                    <div class="div5">-</div>
                  </div>
                  <div class="frame-118">
                    <div class="_2">2</div>
                  </div>
                  <div class="frame-119">
                    <div class="div5">+</div>
                  </div>
                </div>
              </div>
              <div class="frame-8934">
                <div class="div4">상품 금액</div>
                <div class="_10-000">10,000 원</div>
              </div>
              <div class="frame-8934">
                <div class="div4">배송비</div>
                <div class="_3-000">3,000 원</div>
              </div>
            </div>
          </div>
        </div>
        <div class="order-insert">
          <div class="div2">반품 / 교환 수거 정보 입력</div>
          <div class="order-list2">
            <div class="group-8920">
              <div class="div6">
                <span>
                  <span class="div-6-span">반품</span>
                  <span class="div-6-span2"></span>
                </span>
              </div>
              <img class="vector" src="vector0.svg" />
              <div class="div7">교환</div>
              <img class="vector2" src="vector1.svg" />
            </div>
            <div class="group-8916">
              <div class="rectangle-4309"></div>
              <div class="div8">반품 사유를 선택해주세요</div>
            </div>
            <div class="group-8917">
              <div class="rectangle-4310"></div>
              <div class="div9">상세 사유 입력(선택 사항)</div>
            </div>
            <div class="div10">
              <span>
                <span class="div-10-span">반품 주소</span>
                <span class="div-10-span2"></span>
              </span>
            </div>
            <div class="group-8923">
              <div class="div11">주문 배송 정보와 동일</div>
              <img class="group-89142" src="group-89141.svg" />
            </div>
            <div class="rectangle-4311"></div>
          </div>
        </div>
        <div class="order-info">
          <div class="div2">환불 정보</div>
          <div class="order-list3">
            <div class="_15000">
              <span>
                <span class="_15000-span">
                  취소 상품 총 금액 합계
                  <br />
                </span>
                <span class="_15000-span2">
                  <br />
                </span>
                <span class="_15000-span3">15000원</span>
              </span>
            </div>
            <div class="div12">-</div>
            <div class="_3000">
              <span>
                <span class="_3000-span">반품 시 추가 배송비</span>
                <span class="_3000-span2">
                  <br />
                  <br />
                </span>
                <span class="_3000-span3">3000원</span>
              </span>
            </div>
            <div class="div12">=</div>
            <div class="_150002">
              <span>
                <span class="_150002-span">
                  환불 예정 금액
                  <br />
                </span>
                <span class="_150002-span2">
                  <br />
                </span>
                <span class="_150002-span3">15000원</span>
              </span>
            </div>
          </div>
        </div>
        <div class="order-cancel">
          <div class="div13">반품 / 교환 신청</div>
        </div>
      </div>
    </div>
  </div>
  </div>
  <%@ include file="/WEB-INF/views/common/footer.jsp"%>
  
  <script>
$(document).ready(function() {
    // 세션 스토리지에서 orderDetailInquiry 정보 가져오기
    let orderDetailInquiry = JSON.parse(sessionStorage.getItem('orderDetailInquiry'));

    if (orderDetailInquiry) {
        console.log(orderDetailInquiry); // 디버그용
        // orderDetailInquiry 정보를 활용하여 페이지에 표시하거나 처리
        // 예: 특정 HTML 요소에 데이터 표시
        $('#orderCodeDisplay').text(orderDetailInquiry[0].orderCode);
        $('#orderStatusDisplay').text(orderDetailInquiry[0].orderStatus);
    } else {
        alert('주문 정보가 존재하지 않습니다.');
    }
});
</script>
</body>
</html>