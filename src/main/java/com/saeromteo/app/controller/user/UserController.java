package com.saeromteo.app.controller.user;

import java.sql.Date;
import java.time.LocalDate;
import java.util.Map;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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


        userService.updateUserProfile(userId, request);
        return "success";
    }

    
    @PostMapping("/mypage/profile/uploadProfileImage")
    @ResponseBody
    public String uploadProfileImage(@RequestParam("profileImage") MultipartFile profileImage, HttpServletRequest httpServletRequest) {
        String token = jwtUtil.getJwtFromCookies(httpServletRequest);
        int userId = jwtUtil.getUserIdFromToken(token);
System.out.println("uploadProfile");
        // S3에 파일 업로드
        String imageUrl = s3Util.uploadFile(profileImage, "profile-images");

        // UserDTO 업데이트
        UserDTO userDTO = new UserDTO();
        userDTO.setUserImgPath(imageUrl);

        // UserDTO 정보 업데이트
        userService.updateUserProfile(userId, userDTO);

        return "success";
    }
    

    @PostMapping("/mypage/profile/updateAddress")
    @ResponseBody
    public String updateAddress(@RequestBody Map<String, String> addressData, RedirectAttributes redirectAttributes, HttpServletRequest httpServletRequest) {
        String mainAddress = addressData.get("mainAddress");
        String detailAddress = addressData.get("detailAddress");
        int userPostalCode;
        String token = jwtUtil.getJwtFromCookies(httpServletRequest);
        int userId = jwtUtil.getUserIdFromToken(token);
        

        try {
            userPostalCode = Integer.parseInt(addressData.get("userPostalCode"));
        } catch (NumberFormatException e) {
            redirectAttributes.addFlashAttribute("message", "우편번호가 유효하지 않습니다.");
            return "error";
        }

        // 사용자 정보를 업데이트하는 서비스 메서드 호출
        boolean updateSuccess = userService.updateUserAddress(userId,mainAddress, detailAddress, userPostalCode);

        if (updateSuccess) {
            redirectAttributes.addFlashAttribute("message", "주소가 성공적으로 업데이트되었습니다.");
            return "success";
        } else {
            redirectAttributes.addFlashAttribute("message", "주소 업데이트 중 오류가 발생했습니다.");
            return "error";
        }
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
        
        String address = user.getUserAdd();
        String mainAddress = "";
        String detailAddress = "";
        if (address != null && address.contains("/")) {
            String[] addressParts = address.split("/", 2);
            mainAddress = addressParts[0];
            detailAddress = addressParts.length > 1 ? addressParts[1] : "";
        } else {
            mainAddress = address != null ? address : "";
            detailAddress = "";
        }
        
        String userRealName = user.getUserRealName();
        model.addAttribute("postalCode", postalCode != null ? postalCode : "");
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
        model.addAttribute("mainAddress", mainAddress);
        model.addAttribute("detailAddress", detailAddress);
        model.addAttribute("userRealName", userRealName);
    }
}
