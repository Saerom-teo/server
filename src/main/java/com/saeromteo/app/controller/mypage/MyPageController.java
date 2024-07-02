package com.saeromteo.app.controller.mypage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.model.point.PointDto.PointResponse;
import com.saeromteo.app.model.user.UserDTO;
import com.saeromteo.app.service.collection.CollectionService;
import com.saeromteo.app.service.point.PointService;
import com.saeromteo.app.service.user.UserService;
import com.saeromteo.app.util.RankUtil;

import io.swagger.annotations.Api;
import springfox.documentation.annotations.ApiIgnore;

@Controller
@RequestMapping("/mypage")
@Api(tags = "Mypage Management")
public class MyPageController {

	@Autowired
	CollectionService collectionService;
	
	@Autowired
	PointService pointService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	JWTUtil jwtUtil;
	
	@Autowired
	RankUtil rankUtil;

	@GetMapping("/collection")
	@ApiIgnore
	public String collection(Model model, HttpServletRequest request) {
		String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);
		UserDTO user = userService.readUserByUserId(userId);
		
		String nickname = user.getUserNickname();
		int point = user.getUserPointHistory();
		String rank = user.getUserRank();
		
		model.addAttribute("nickname", nickname);
		model.addAttribute("point", point);
		model.addAttribute("rank", rankUtil.calcRank(rank));
		model.addAttribute("rankImg", rankUtil.getRankImage(rank));
		
		return "mypage/mypage-collection";
	}
	
	@GetMapping("/collection/cancel")
	@ApiIgnore
	public String collectionCancel(@RequestParam("collectionId") Integer collectionId) {
		System.out.println(collectionId);
		collectionService.cancelCollection(collectionId);
		return "redirect:/mypage/collection";
	}
	
	@GetMapping("/point")
	@ApiIgnore
    public String point(Model model, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int size, 
    		@RequestParam(defaultValue = "all") String type, HttpServletRequest request) {
		String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);
        if ("all".equals(type)) {
            type = null; // type이 'all'이면 null로 처리하여 모든 데이터를 조회
        }
        List<PointResponse> pointResponses = pointService.getPointsByUserId(userId, page, size, type);
        int totalPoints = pointService.getTotalPointsByUserId(userId, type); // 총 포인트 수를 가져오는 메서드
        int totalPages = (int) Math.ceil((double) totalPoints / size);
        
        model.addAttribute("pointResponses", pointResponses);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentType", type); // 현재 타입을 전달
        return "mypage/mypage-point";
	}

}