package com.saeromteo.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.dto.envdata.EnvironmentDataDto.EnvDataResponse;
import com.saeromteo.app.service.envdata.EnvDataService;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	EnvDataService envDataService;
	
	@GetMapping
	public String main(Model model) {
		
		List<EnvDataResponse> envDataList = envDataService.readThree();
		model.addAttribute("envDataList", envDataList);
		return "main2";
	}
	
}
