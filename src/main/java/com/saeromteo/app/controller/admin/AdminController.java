package com.saeromteo.app.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.model.collection.CollectionEntity;
import com.saeromteo.app.service.collection.CollectionService;

import io.swagger.annotations.Api;
import springfox.documentation.annotations.ApiIgnore;

@Controller
@RequestMapping("/admin")
@Api(tags = "Admin Management")
public class AdminController {
	
	@Autowired
	CollectionService collectionService;

	@GetMapping("/dashboard")
	@ApiIgnore
	public String dashboard() {
		return "admin/dashboard";
	}
	
	@GetMapping("/collection-manager")
	@ApiIgnore
	public String collection(Model model) {
		List<CollectionEntity> collectionList = collectionService.readAll();
		System.out.println(collectionList);
		model.addAttribute("collectionList", collectionList);
		return "admin/collection-manager";
	}

}