package com.saeromteo.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.dto.envdata.EnvironmentDataDto.EnvDataResponse;
import com.saeromteo.app.model.product.ProductEntity;
import com.saeromteo.app.service.envdata.EnvDataService;
import com.saeromteo.app.service.product.ProductService;


@Controller
@RequestMapping("/")
public class MainController {
	
	@Autowired
	EnvDataService envDataService;
	
	@Autowired
	ProductService productService;
	
	/*
	@GetMapping
	public String main(Model model) {
		
		List<EnvDataResponse> envDataList = envDataService.readThree();
		model.addAttribute("envDataList", envDataList);
		return "main";
	}
	*/
	
	@GetMapping
	public String main(Model model) {
		List<EnvDataResponse> envDataList = envDataService.readThree();
		List<ProductEntity> productList = productService.readAll();
		model.addAttribute("envDataList", envDataList);
		model.addAttribute("productList", productList);
		return "main"; 
	}
	
}
