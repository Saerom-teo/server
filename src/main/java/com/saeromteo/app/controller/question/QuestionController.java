package com.saeromteo.app.controller.question;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.dto.question.QuestionDTO.QuestionRequest;
import com.saeromteo.app.dto.question.QuestionDTO.QuestionResponse;
import com.saeromteo.app.service.question.QuestionService;

@RestController
@RequestMapping("/question/api")
public class QuestionController {

    @Autowired
    QuestionService questionService;

    // 문의사항 전체 조회
    @GetMapping(value = "/readAll", produces = "application/json")
    public List<QuestionResponse> readAll() {
        return questionService.readAll();
    }

    // 문의사항 카테고리별 조회
    @GetMapping(value = "/category/{questionCategory}", produces = "application/json")
    public List<QuestionResponse> readCategory(@PathVariable("questionCategory") String questionCategory) {
        return questionService.readCategory(questionCategory);
    }

    // 문의사항 상세 조회
    @GetMapping(value = "/readDetail/{questionId}", produces = "application/json")
    public QuestionResponse readDetail(@PathVariable("questionId") int questionId) {
        return questionService.readDetail(questionId);
    }

    // 유저별 문의사항 조회
    @GetMapping(value = "/readUser/{userCode}", produces = "application/json")
    public List<QuestionResponse> readUser(@PathVariable("userCode") int userCode) {
        return questionService.readUser(userCode);
    }

    // 문의사항 작성
    @PostMapping(value = "/insertQuestion", produces = "text/plain;charset=utf-8", consumes = "application/json" )
    public String createQuestion(@RequestBody QuestionRequest questionRequest) {
        int result = questionService.insertQuestion(questionRequest);
        return result + "건 작성되었습니다.";
    }

    // 문의사항 답변 작성
    @PostMapping(value = "/insertAnswer", produces = "text/plain;charset=utf-8", consumes = "application/json" )
    public String createQuestionAnswer(@RequestBody QuestionRequest questionRequest) {
        int result = questionService.insertQuestionAnswer(questionRequest);
        return result + "건 답변 작성되었습니다.";
    }

    // 문의사항 수정
    @PutMapping(value = "/updateQuestion", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String updateQuestion(@RequestBody QuestionRequest questionRequest) {
        int result = questionService.updateQuestion(questionRequest);
        return result + "건 수정되었습니다.";
    }

    // 문의사항 삭제
    @DeleteMapping(value = "/deleteQuestion/{questionId}" , produces =  "text/plain;charset=utf-8")
    public String deleteQuestion(@PathVariable("questionId") int questionId) {
        int result = questionService.deleteQuestion(questionId);
        return result + "건 삭제되었습니다.";
    }
}
