package com.saeromteo.app.controller.quiz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.dto.quiz.QuizDto.QuizResponse;
import com.saeromteo.app.service.quiz.QuizService;

@Controller
@RequestMapping("/quiz")
public class QuizFrontController {
	
	@Autowired
	QuizService quizService;
	
	@GetMapping
	public String quiz(Model model) {
		
		List<QuizResponse> quizList = quizService.readRandom(1);
		int point = quizService.readAllPoint(1);
		
		for(QuizResponse q:quizList) {
			System.out.println(q.getQuizName());
		}
		
		model.addAttribute("quizList", quizList);
		model.addAttribute("point", point);
		
		return "dashboard/quiz";
	}
	
}
