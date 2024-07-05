package com.saeromteo.app.controller.dashboard;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.saeromteo.app.service.envdata.EnvDataService;
import com.saeromteo.app.service.news.NewsService;
import com.saeromteo.app.service.quiz.QuizService;

@Controller
public class DashboardController {

	@Autowired
	EnvDataService envdataService;
	
	@Autowired
	NewsService newsService;
	
	@Autowired
	QuizService quizService;
	
	
	
	@GetMapping("/dashboard")
	public String main(Model model) {
		
		model.addAttribute("envDataList", envdataService.readThree());
		model.addAttribute("newsList", newsService.readFour());
		model.addAttribute("quiz", quizService.readAll().get(0));
		
		return "/dashboard/dashboard";
	}
	
}
