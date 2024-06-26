package com.saeromteo.app.controller.news;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.service.news.NewsService;

@Controller
@RequestMapping("/news")
public class NewsFrontController {
	
	@Autowired
	NewsService newsService;
	
	@GetMapping
	public String main(Model model) {
		
		
		return "/dashboard/news";
	}
	
}
