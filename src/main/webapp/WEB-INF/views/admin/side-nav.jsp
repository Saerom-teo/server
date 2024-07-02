<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
    <div class="sb-sidenav-menu">
        <div class="nav">
            <div class="sb-sidenav-menu-heading">Core</div>
            <a class="nav-link" href="dashboard">
                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                Dashboard
            </a>
            <div class="sb-sidenav-menu-heading">Interface</div>
            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts"
                aria-expanded="false" aria-controls="collapseLayouts">
                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                Layouts
                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
            </a>
            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                <nav class="sb-sidenav-menu-nested nav">
                    <a class="nav-link" href="layout-static.html">Static Navigation</a>
                    <a class="nav-link" href="layout-sidenav-light.html">Light Sidenav</a>
                </nav>
            </div>
            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages"
                aria-expanded="false" aria-controls="collapsePages">
                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                Pages
                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
            </a>
            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth"
                        aria-expanded="false" aria-controls="pagesCollapseAuth">
                        Authentication
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne"
                        data-bs-parent="#sidenavAccordionPages">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="login.html">Login</a>
                            <a class="nav-link" href="register.html">Register</a>
                            <a class="nav-link" href="password.html">Forgot Password</a>
                        </nav>
                    </div>
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                        data-bs-target="#pagesCollapseError" aria-expanded="false" aria-controls="pagesCollapseError">
                        Error
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne"
                        data-bs-parent="#sidenavAccordionPages">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="401.html">401 Page</a>
                            <a class="nav-link" href="404.html">404 Page</a>
                            <a class="nav-link" href="500.html">500 Page</a>
                        </nav>
                    </div>
                </nav>
            </div>
            <div class="sb-sidenav-menu-heading">Addons</div>
            <a class="nav-link" href="charts.html">
                <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                Charts
            </a>
            <a class="nav-link" href="tables.html">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                Tables
            </a>
            <div class="sb-sidenav-menu-heading">Collection</div>
            <a class="nav-link" href="collection-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                수거 관리
            </a>
            <div class="sb-sidenav-menu-heading">Community</div>
            <a class="nav-link" href="news-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                뉴스 관리
            </a>
            <a class="nav-link" href="quiz-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                퀴즈 관리
            </a>
            <a class="nav-link" href="envdata-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                환경자로 관리
            </a>
            <div class="sb-sidenav-menu-heading">Notice, Q&A</div>
            <a class="nav-link" href="notice-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                공지
            </a>
            <a class="nav-link" href="question-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                문의사항
            </a>
            <div class="sb-sidenav-menu-heading">Product</div>
            <a class="nav-link" href="product-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                상품 관리
            </a>
            <a class="nav-link" href="product-category-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                상품 카테고리 관리
            </a>
            <a class="nav-link" href="product-discount-manager">
                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                상품 할인 관리
            </a>
        </div>
    </div>
    <!-- <div class="sb-sidenav-footer">
                <div class="small">Logged in as:</div>
                Start Bootstrap
            </div> -->
</nav>