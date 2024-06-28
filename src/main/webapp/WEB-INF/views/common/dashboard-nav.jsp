<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	
.frame-67 {
  background: rgba(246, 246, 246, 0.73);
  padding: 10px;
  display: flex;
  flex-direction: row;
  gap: 10px;
  align-items: center;
  justify-content: center;
  align-self: stretch;
  flex-shrink: 0;
  height: 75px;
  position: relative;
  overflow: hidden;
}

.dashboard-nav-div2 {
  color: var(--color, #616060);
  text-align: center;
  font-family: "NotoSansKr-Bold", sans-serif;
  font-size: 12px;
  line-height: 13px;
  font-weight: 700;
  position: relative;
  width: 48px;
  height: 33px;
  display: flex;
  align-items: center;
  justify-content: center;
}

</style>
</head>
<body>
	<div class="frame-67">
      <a href="/app/dashboard"><div class="dashboard-nav-div2">대시보드</div></a>
      <a href="/app/news"><div class="dashboard-nav-div2">뉴스</div></a>
      <a href="/app/quiz"><div class="dashboard-nav-div2">퀴즈</div></a>
      <a href="/app/envdata"><div class="dashboard-nav-div2">자료</div></a>
    </div>
</body>
</html>