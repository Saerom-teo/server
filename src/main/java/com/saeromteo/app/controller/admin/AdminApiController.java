package com.saeromteo.app.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.saeromteo.app.service.collection.CollectionService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/api/admin")
@Api(tags = "Admin Management")
public class AdminApiController {

	@Autowired
	CollectionService collectionService;

	@GetMapping("/collection/approve")
	@ApiOperation(value = "수거 신청", notes = "사용자가 수거 서비스를 신청한다.")
	public String registration(@RequestParam("collectionId") String collectionId) {
		System.out.println("collectionId: " + collectionId);
		return "redirect:/admin/collection-manager";
	}

}
