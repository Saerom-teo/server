package com.saeromteo.app.controller.user;

import java.sql.Date;
import java.time.LocalDate;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.model.user.UserDTO;
import com.saeromteo.app.service.user.UserService;
import com.saeromteo.app.util.RankUtil;
import com.saeromteo.app.util.S3Util;

@Controller
public class UserController {

    @Autowired
    JWTUtil jwtUtil;

    @Autowired
    UserService userService;
    
    @Autowired
    RankUtil rankUtil;
    
    @Autowired
    S3Util s3Util;

    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        SecurityContextLogoutHandler logoutHandler = new SecurityContextLogoutHandler();
        logoutHandler.logout(request, response, null);

        Cookie deleteCookie = new Cookie("jwtToken", null);
        deleteCookie.setPath("/");
        deleteCookie.setHttpOnly(true);
        deleteCookie.setMaxAge(0);
        response.addCookie(deleteCookie);

        return "redirect:/";
    }

    @GetMapping("/mypage/profile")
    public String mypageProfile(Model model, HttpServletRequest request) {
        String token = jwtUtil.getJwtFromCookies(request);
        int userId = jwtUtil.getUserIdFromToken(token);
        getMypageInfo(model, userId);
        return "mypage/mypage-profile";
    }

    @PostMapping("/mypage/profile/update")
    @ResponseBody
    public String profileUpdate(@RequestBody UserDTO request, HttpServletRequest httpServletRequest) {
        String token = jwtUtil.getJwtFromCookies(httpServletRequest);
        int userId = jwtUtil.getUserIdFromToken(token);
        
        System.out.println(request.toString());
        
        userService.updateUserProfile(userId, request);
        return "success";
    }
    
    @PostMapping("/mypage/profile/uploadProfileImage")
    @ResponseBody
    public String uploadProfileImage(@RequestParam("profileImage") MultipartFile profileImage, HttpServletRequest httpServletRequest) {
        String token = jwtUtil.getJwtFromCookies(httpServletRequest);
        int userId = jwtUtil.getUserIdFromToken(token);

        // S3에 파일 업로드
        String imageUrl = s3Util.uploadFile(profileImage, "profile-images");

        // UserDTO 업데이트
        UserDTO userDTO = new UserDTO();
        userDTO.setUserImgPath(imageUrl);

        // UserDTO 정보 업데이트
        userService.updateUserProfile(userId, userDTO);

        return "success";
    }


    public void getMypageInfo(Model model, int userId) {
        UserDTO user = userService.readUserByUserId(userId);
        String email = (user.getUserEmail() != null) ? user.getUserEmail() : "";
        String nickname = (user.getUserNickname() != null) ? user.getUserNickname() : "닉네임 없음";
        String profileImg = (user.getUserImgPath() != null) ? user.getUserImgPath() : "default.jpg";
        int point = user.getUserPointHistory();

        String rank = rankUtil.calcRank(user.getUserId());
        String rankImg = rankUtil.getRankImage(rank);

        Date userBirth = (user.getUserBirth() != null) ? user.getUserBirth() : Date.valueOf(LocalDate.now());
        String gender = (user.getUserGender() != null) ? user.getUserGender() : "unknown";
        String phoneNumber = (user.getUserPhone() != null) ? user.getUserPhone() : "휴대폰 인증을 진행하지 않았습니다.";
        Boolean userCollStatus = user.isUserCollStatus();

        Integer postalCode = user.getUserPostalCode();
        if (postalCode == null) {
            postalCode = null;
            model.addAttribute("postalCode", "");
        }
        String userAdd = (user.getUserAdd() != null) ? user.getUserAdd() : "";

        model.addAttribute("email", email);
        model.addAttribute("nickname", nickname);
        model.addAttribute("profileImg", profileImg);
        model.addAttribute("point", point);
        model.addAttribute("rank", rank);
        model.addAttribute("rankImg", rankImg);
        model.addAttribute("userBirth", userBirth);
        model.addAttribute("gender", gender);
        model.addAttribute("phoneNumber", phoneNumber);
        model.addAttribute("userCollStatus", userCollStatus);
        model.addAttribute("userAdd", userAdd);
    }

}
