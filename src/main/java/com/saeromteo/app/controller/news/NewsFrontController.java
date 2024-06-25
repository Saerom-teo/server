package com.saeromteo.app.controller.news;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.dto.news.NewsDto.NewsResponse;
import com.saeromteo.app.service.news.NewsService;

@Controller
@RequestMapping("/news")
public class NewsFrontController {
	
	@Autowired
	NewsService newsService;
	
	@GetMapping
	public String main(Model model) {
		
		List<NewsResponse> newsList = newsService.readAll();
		model.addAttribute("newsList", newsList);
		
		return "/dashboard/news";
	}
	
}
