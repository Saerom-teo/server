package com.saeromteo.app.controller.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.saeromteo.app.service.collection.CollectionService;

import io.swagger.annotations.Api;
import springfox.documentation.annotations.ApiIgnore;

@Controller
@RequestMapping("/mypage")
@Api(tags = "Mypage Management")
public class MyPageController {

	@Autowired
	CollectionService collectionService;

	@GetMapping("/collection")
	@ApiIgnore
	public String collection() {
		return "mypage/mypage-collection";
	}
	
	@GetMapping("/collection/cancel")
	@ApiIgnore
	public String collectionCancel(@RequestParam("collectionId") Integer collectionId) {
		System.out.println(collectionId);
		collectionService.calcelCollection(collectionId);
		return "redirect:/mypage/collection";
	}

}