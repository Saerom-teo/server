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
	
	@GetMapping(value = "/orderlist")
	public String orderlist() {
		return "mypage/mypage-orderlist";
	}
	
	@GetMapping(value = "/shoppingmall")
	public String shoppingmall() {
		return "shop/shoppingmall";
	}
	
	@GetMapping(value = "/shopdetail")
	public String shopdetail() {
		return "shop/shopdetail";
	}
	
	@GetMapping(value = "/complete")
	public String complete() {
		return "shop/complete";
	}
	
	@GetMapping(value = "/news")
	public String news() {
		return "dashboard/news";
	}
	
	@GetMapping(value = "/quiz")
	public String quiz() {
		return "dashboard/quiz";
	}
	
	@GetMapping(value = "/admin/envdata")
	public String envdata() {
		return "dashboard/envdata";
	}
	
	@GetMapping(value = "/envdetail")
	public String envdetail() {
		return "dashboard/envdetail";
	}
	
	@GetMapping(value = "/admin/createenvdata")
	public String envdatacreate() {
		return "admin/createEnvData";
	}

}
