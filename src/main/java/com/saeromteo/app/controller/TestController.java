package com.saeromteo.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test")
public class TestController {

	@GetMapping(value = "/dashboard")
	public String dashboard() {
		return "dashboard/dashboard";
	}
	
	@GetMapping(value = "/notice")
	public String notice() {
		return "notice/notice";
	}

}