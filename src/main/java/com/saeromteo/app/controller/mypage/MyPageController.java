package com.saeromteo.app.controller.mypage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.saeromteo.app.model.point.PointDto.PointResponse;
import com.saeromteo.app.service.collection.CollectionService;
import com.saeromteo.app.service.point.PointService;

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

	@GetMapping("/collection")
	@ApiIgnore
	public String collection() {
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
    		@RequestParam(defaultValue = "all") String type) {
        int userId = 1;
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