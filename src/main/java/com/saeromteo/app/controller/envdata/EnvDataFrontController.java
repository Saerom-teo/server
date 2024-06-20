package com.saeromteo.app.controller.envdata;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.service.envdata.EnvDataService;

@Controller
@RequestMapping("/envdata")
public class EnvDataFrontController {
	
	@Autowired
	EnvDataService envService;
	
	@GetMapping
	public String main() {
		return "/dashboard/envdata";
	}
	
}
