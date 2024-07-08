package com.saeromteo.app.controller.mypage;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.model.user.UserDTO;
import com.saeromteo.app.service.user.UserService;
import com.saeromteo.app.util.RankUtil;

import springfox.documentation.annotations.ApiIgnore;

@RestController
@RequestMapping("/api/mypage")
public class MyPageApiController {
	
	@Autowired
	JWTUtil jwtUtil;
	
	@Autowired
	UserService userService;
	
	@Autowired
	RankUtil rankUtil;
	
	@GetMapping("/getMyInfo")
	@ApiIgnore
	public HashMap<String, Object> getMyInfo(Model model, HttpServletRequest request) {
		String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);

		HashMap<String, Object> map = getMypageInfo(userId);
		
		return map;
	}
	
	public HashMap<String, Object> getMypageInfo(int userId) {
		UserDTO user = userService.readUserByUserId(userId);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String nickname = user.getUserNickname();
		String profileImg = user.getUserImgPath();
		int point = user.getUserPointHistory();
		String rank = rankUtil.calcRank(userId);
		
		map.put("nickname", nickname);
		map.put("profileImg", profileImg);
		map.put("point", point);
		map.put("rank", rank);
		map.put("rankImg", rankUtil.getRankImage(rank));

		
		return map;
	}

}
