package com.saeromteo.app.controller.question;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.model.question.QuestionDTO;
import com.saeromteo.app.model.question.QuestionDTO.QuestionRequest;
import com.saeromteo.app.model.question.QuestionDTO.QuestionResponse;
import com.saeromteo.app.service.question.QuestionService;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/question")
public class QuestionController {

    @Autowired
    QuestionService questionService;
    
    @Autowired
	JWTUtil jwtUtil;
    
    // 문의사항 전체 조회
    @GetMapping(value = "/readAll", produces = "application/json")
    public String readAll(Model model,
                          @RequestParam(defaultValue = "1") int page,
                          @RequestParam(defaultValue = "10") int pageSize,
                          @RequestParam(name = "filter", required = false, defaultValue = "all") String filter,
                          @RequestParam(name = "query", required = false, defaultValue = "") String query,
                          HttpServletRequest request) {
        List<QuestionResponse> questionList;
        int totalQuestions;
        
        String token = jwtUtil.getJwtFromCookies(request);
        int userId = jwtUtil.getUserIdFromToken(token); // JWT 토큰에서 userId를 가져오는 메서드
        
        if ("title".equals(filter) && !query.isEmpty()) {
            totalQuestions = questionService.getTotalQuestionCountByTitle(query);
            questionList = questionService.findNoticesByTitle(query, page, pageSize, userId);
        } else if ("content".equals(filter) && !query.isEmpty()) {
            totalQuestions = questionService.getTotalQuestionCountByContent(query);
            questionList = questionService.findNoticesByContent(query, page, pageSize, userId);
        } else {
            totalQuestions = questionService.getTotalQuestionCount();
            questionList = questionService.findAllNotices(page, pageSize, userId);
        }

        int totalPages = (int) Math.ceil((double) totalQuestions / pageSize);

        model.addAttribute("questionList", questionList);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalQuestions", totalQuestions);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("filter", filter);
        model.addAttribute("query", query);
        model.addAttribute("currentUserId", userId);

        return "question/question";
    }

    // 문의사항 카테고리별 조회
    @GetMapping(value = "/readCategory/{questionCategory}", produces = "application/json")
    public List<QuestionResponse> readCategory(@PathVariable("questionCategory") String questionCategory) {
        return questionService.readCategory(questionCategory);
    }

    // 문의사항 상세 조회.
    @GetMapping(value = "/readDetail/{id}")
    @ResponseBody
    public QuestionResponse readDetail(@PathVariable("id") int questionId) {
    	QuestionResponse result = questionService.readDetail(questionId);
        return result;
    }
    
    @PostMapping("/readUser")
    @ApiOperation(value = "유저별 문의 조회", notes = "유저별 문의를 조회한다.")
    public String readUser(HttpServletRequest request, 
                           Model model,
                           @RequestParam(defaultValue = "1") int page,
                           @RequestParam(defaultValue = "10") int pageSize,
                           @RequestParam(name = "filter", required = false, defaultValue = "all") String filter,
                           @RequestParam(name = "query", required = false, defaultValue = "") String query) {
        String token = jwtUtil.getJwtFromCookies(request);
        int userId = jwtUtil.getUserIdFromToken(token);
        
        List<QuestionResponse> questionList;
        int totalQuestions;

        if ("title".equals(filter) && !query.isEmpty()) {
            totalQuestions = questionService.getTotalUserQuestionCountByTitle(query, userId);
            questionList = questionService.findUserQuestionsByTitle(query, userId, page, pageSize);
        } else if ("content".equals(filter) && !query.isEmpty()) {
            totalQuestions = questionService.getTotalUserQuestionCountByContent(query, userId);
            questionList = questionService.findUserQuestionsByContent(query, userId, page, pageSize);
        } else {
            totalQuestions = questionService.getTotalUserQuestionCount(userId);
            questionList = questionService.readUserQuestions(userId, page, pageSize);
        }

        int totalPages = (int) Math.ceil((double) totalQuestions / pageSize);

        model.addAttribute("questionList", questionList);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalQuestions", totalQuestions);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("filter", filter);
        model.addAttribute("query", query);
        model.addAttribute("loggedInUserId", userId);
        
        return "question/question-user";
    }
    
    // 유저별 문의사항 조회
//    @PostMapping(value = "/readUser")
//    public String readUser(@RequestParam("userId") int userId, Model model) {
//    	model.addAttribute("questionList", questionService.readUser(userId));
//        return "question/question";
//    }

    @GetMapping(value="/createQuestion", produces = "application/json")
    public String createQuestionForm(HttpServletRequest request, Model model) {
    	String token = jwtUtil.getJwtFromCookies(request);
        int userId = jwtUtil.getUserIdFromToken(token);
    	model.addAttribute("userId", userId);
    	
    	System.out.println("================================"+userId+"=============================");
    	
    	return "question/question-write";
    }
    
    // 문의사항 작성
	@PostMapping(value = "/insertQuestion", produces = "text/plain;charset=utf-8")
    public ResponseEntity<String> createQuestion(QuestionDTO.QuestionRequest questionRequest) {
		System.out.println(questionRequest);
        int result = questionService.insertQuestion(questionRequest);
        if (result > 0) {
	        return ResponseEntity.ok("ok");
	    } else {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("수정 실패");
	    }					
    }

    // 문의사항 답변 작성
    @PutMapping(value = "/insertAnswer", consumes = "application/json", produces = "application/json")
    public ResponseEntity<String> createQuestionAnswer(@RequestBody QuestionDTO.QuestionRequest questionRequest) {
    	System.out.println(questionRequest);
        int result = questionService.insertQuestionAnswer(questionRequest);
		if (result > 0) {
	        return ResponseEntity.ok("ok");
	    } else {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("수정 실패");
	    }
    }

    // 문의사항 수정
    @PutMapping(value = "/updateQuestion", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String updateQuestion(@RequestBody QuestionRequest questionRequest) {
        int result = questionService.updateQuestion(questionRequest);
        return result + "건 수정되었습니다.";
    }

    // 문의사항 삭제
    @DeleteMapping(value = "/deleteQuestion/{questionId}")
    public ResponseEntity<String> deleteQuestion(@PathVariable("questionId") int questionId) {
        int result = questionService.deleteQuestion(questionId);
        if (result > 0) {
	        return ResponseEntity.ok("1건 삭제되었습니다.");
	    } else {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("수정 실패");
	    }
    }
}
