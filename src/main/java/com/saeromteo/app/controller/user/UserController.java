package com.saeromteo.app.controller.user;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.service.user.UserService;

@Controller
public class UserController {

    @Autowired
    JWTUtil jwtUtil;

    @Autowired
    UserService userService;

    /**
     * 로그아웃 처리를 합니다.
     *
     * @param request  클라이언트의 HTTP 요청
     * @param response 클라이언트의 HTTP 응답
     * @return 메인 페이지로 리다이렉트
     */
    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        // Spring Security 로그아웃 처리
        SecurityContextLogoutHandler logoutHandler = new SecurityContextLogoutHandler();
        logoutHandler.logout(request, response, null);
        
        // JWT 토큰 쿠키 삭제
        Cookie deleteCookie = new Cookie("jwtToken", null);
        deleteCookie.setPath("/");
        deleteCookie.setHttpOnly(true);
        deleteCookie.setMaxAge(0); // 쿠키를 즉시 만료시킴
        response.addCookie(deleteCookie);
        
        return "redirect:/";
    }

    /**
     * 마이페이지 프로필 화면으로 이동합니다.
     *
     * @return 마이페이지 프로필 화면
     */
    @GetMapping(value = "/mypage/profile")
    public String mypageProfile() {
        return "mypage/mypage-profile";
    }
}
