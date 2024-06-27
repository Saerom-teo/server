package com.saeromteo.app.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.dto.envdata.EnvironmentDataDto.EnvDataResponse;
import com.saeromteo.app.dto.news.NewsDto.NewsResponse;
import com.saeromteo.app.model.collection.CollectionEntity;
import com.saeromteo.app.service.collection.CollectionService;
import com.saeromteo.app.service.envdata.EnvDataService;
import com.saeromteo.app.service.news.NewsService;
import com.saeromteo.app.dto.notice.NoticeEntity;
import com.saeromteo.app.dto.question.QuestionDTO.QuestionResponse;
import com.saeromteo.app.dto.notice.NoticeDTO.NoticeRequest;
import com.saeromteo.app.dto.notice.NoticeDTO.NoticeResponse;
import com.saeromteo.app.dto.quiz.QuizDto.QuizResponse;
import com.saeromteo.app.service.notice.NoticeService;
import com.saeromteo.app.service.question.QuestionService;
import com.saeromteo.app.service.quiz.QuizService;

import io.swagger.annotations.Api;
import springfox.documentation.annotations.ApiIgnore;

@Controller
@RequestMapping("/admin")
@Api(tags = "Admin Management")
public class AdminController {
	
	@Autowired
	CollectionService collectionService;
	
	@Autowired
	NewsService newsService;
	
	@Autowired
	EnvDataService envDataService;
	
	@Autowired
	QuizService quizService;
	
	@Autowired
	NoticeService noticeService;
	
	@Autowired
	QuestionService questionService;

	@GetMapping("/dashboard")
	@ApiIgnore
	public String dashboard() {
		return "admin/dashboard";
	}
	
	@GetMapping("/collection-manager")
	@ApiIgnore
	public String collection(Model model) {
		List<CollectionEntity> collectionList = collectionService.readAll();
		System.out.println(collectionList);
		model.addAttribute("collectionList", collectionList);
		return "admin/collection-manager";
	}
	
	@GetMapping("/news-manager")
	@ApiIgnore
	public String news(Model model) {
		List<NewsResponse> newsList = newsService.readAll();
		model.addAttribute("newsList", newsList);
		model.addAttribute("updateNewsDate", newsService.readUpdateDate());
		
		return "admin/news-manager";
	}
	
	@GetMapping("/quiz-manager")
	@ApiIgnore
	public String quiz(Model model) {
		List<QuizResponse> quizList = quizService.readAll();
		model.addAttribute("quizList", quizList);
		
		return "admin/quiz-manager";
	}
	
	@GetMapping("/envdata-manager")
	@ApiIgnore
	public String envdata(Model model) {
		List<EnvDataResponse> envDataList = envDataService.readAll();
		model.addAttribute("envDataList", envDataList);
		
		return "admin/envdata-manager";
	}

	@GetMapping("/notice-manager")
	@ApiIgnore
	public String notice(Model model) {
		List<NoticeResponse> noticeList = noticeService.readAllAdmin();
		//System.out.println(noticeList);
		model.addAttribute("noticeList", noticeList);
		return "admin/notice-manager";
	}
	
	@GetMapping("/question-manager")
	@ApiIgnore
	public String question(Model model) {
		List<QuestionResponse> questionList = questionService.readAllAdmin();
		model.addAttribute("questionList", questionList);
		return "admin/question-manager";
	}
}