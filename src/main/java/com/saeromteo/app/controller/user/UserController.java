package com.saeromteo.app.controller.user;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.model.user.UserDTO;
import com.saeromteo.app.service.user.UserService;
import com.saeromteo.app.util.RankUtil;

@Controller
public class UserController {

    @Autowired
    JWTUtil jwtUtil;

    @Autowired
    UserService userService;
    
    @Autowired
    RankUtil rankUtil;
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
    public String mypageProfile(Model model ,HttpServletRequest request) {

    	String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);
		
		getMypageInfo(model, userId);
    	return "mypage/mypage-profile";
    }
    @PostMapping("/mypage/profile/profile-update")
    public String profileUpdate(){
    	
    	return "";
    }
    @PostMapping("/mypage/profile/password-update")
    public String passwordUpdate(){
    	
    	return "";
    }
    
//    @PostMapping("/mypage/profile/nickname-update")
//    public String nicknameUpdate(){
//    	
//    	return "";
//    }
//    
//    
//    
//    @PostMapping("/mypage/profile/nickname-update")
//    public String nicknameUpdate(){
//    	
//    	return "";
//    }
    
    
    
	public void getMypageInfo(Model model, int userId) {		
		UserDTO user = userService.readUserByUserId(userId);
		
		String nickname = user.getUserNickname();
		String profileImg = user.getUserImgPath();
		int point = user.getUserPointHistory();
		String rank = user.getUserRank();
		
		model.addAttribute("nickname", nickname);
		model.addAttribute("profileImg", profileImg);
		model.addAttribute("point", point);
		model.addAttribute("rank", rankUtil.calcRank(rank));
		model.addAttribute("rankImg", rankUtil.getRankImage(rank));
	}
	
}
