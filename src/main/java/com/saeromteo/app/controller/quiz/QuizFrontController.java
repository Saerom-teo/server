package com.saeromteo.app.controller.quiz;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.dto.quiz.QuizDto.QuizResponse;
import com.saeromteo.app.service.quiz.QuizHistoryService;
import com.saeromteo.app.service.quiz.QuizService;

@Controller
@RequestMapping("/quiz")
public class QuizFrontController {
	
	@Autowired
	QuizService quizService;
	@Autowired
	QuizHistoryService quizHistoryService;
	
	@GetMapping
	public String quiz(Model model) {
		
		// quiz 목록
		List<QuizResponse> quizList = quizService.readRandom(1);
		// 지금까지 번 point 수
		int point = quizService.readAllPoint(1);
		// 오늘 하루 푼 퀴즈 리스트
		List<Integer> solvedQuizList = quizHistoryService.readByUserIdSolvedAt(1);
		if(solvedQuizList == null) {
			model.addAttribute("chance", 5);
		} else {
			model.addAttribute("chance", 5-solvedQuizList.size());
		}	
		
		for(int i:solvedQuizList) {
			System.out.println(i);
		}
		
		model.addAttribute("quizList", quizList);
		model.addAttribute("point", point);
		model.addAttribute("solvedQuizList", solvedQuizList);
		
		return "dashboard/quiz";
	}
	
}
