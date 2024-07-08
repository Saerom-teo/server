<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
    <div class="sb-sidenav-menu">
        <div class="nav">
        	<a class="nav-link" href="${pageContext.request.contextPath}/">
                <div class="sb-nav-link-icon"><i class="fas fa-solid fa-store"></i></div>
                새롬터 바로가기
            </a>
            <div class="sb-sidenav-menu-heading">Collection</div>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/collection-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                수거 관리
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/point-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                포인트 관리
            </a>
            <div class="sb-sidenav-menu-heading">Community</div>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/news-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                뉴스 관리
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/quiz-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                퀴즈 관리
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/envdata-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                환경자료 관리
            </a>
            <div class="sb-sidenav-menu-heading">Notice, Q&A</div>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/notice-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                공지
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/question-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                문의사항
            </a>
            <div class="sb-sidenav-menu-heading">Product</div>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/product-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                상품 관리
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/product-category-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                상품 카테고리 관리
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/product-discount-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                상품 할인 관리
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/review-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                리뷰 관리
            </a>
        </div>
    </div>
    <!-- <div class="sb-sidenav-footer">
                <div class="small">Logged in as:</div>
                Start Bootstrap
            </div> -->
</nav>