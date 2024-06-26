package com.saeromteo.app.controller.envdata;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.dto.envdata.EnvironmentDataDto.EnvDataResponse;
import com.saeromteo.app.service.envdata.EnvDataService;

@Controller
@RequestMapping("/envdata")
public class EnvDataFrontController {
	
	@Autowired
	EnvDataService envService;
	
	@GetMapping
	public String main(Model model) {
		
		List<EnvDataResponse> envDataList = envService.readAll();
		model.addAttribute("envDataList", envDataList);
		
		return "/dashboard/envdata";
	}
	
	@GetMapping("/category/{main}/{sub}")
	public String readByCategory(@PathVariable("main") String mainCategory, @PathVariable("sub") String subCategory, Model model) {
		List<EnvDataResponse> envDataList = null;
		if(subCategory.equals("all")) {
			envDataList = envService.readByMainCategory(mainCategory);
		} else {
			envDataList = envService.readBySubCategory(subCategory);
		}
		 
		model.addAttribute("envDataList", envDataList);
		
		return "/dashboard/envdata";
	}

	@GetMapping("/readDetail/{envId}")
	public String readDetail(@PathVariable("envId") int envId, Model model) {
		
		EnvDataResponse envData = envService.readDetail(envId);
		model.addAttribute("envData", envData);
		
		return "/dashboard/envdetail";
	}
	
}
