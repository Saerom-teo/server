package com.saeromteo.app.controller.editor;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/editor/api")
public class EditorController {
    
    @GetMapping("/show")
    public String showEditor(Model model) {
        return "editor/editor";
    }
    
    @PostMapping(value = "/submit", produces = "text/plain;charset=utf-8", consumes = "application/json")
    public String useEditor(
        @RequestParam(value = "subject", defaultValue = "defaultSubject") String subject,
        @RequestParam(value = "memo", required = false) String memo) {
        // 받은 데이터 처리
        if (memo == null) {
            memo = "defaultMemo"; // 기본값 설정
        }
        System.out.println("제목: " + subject);
        System.out.println("메모: " + memo);
        // 응답 반환 (뷰 이름이나 메시지 반환 가능)
        return "editor/editortest";
    }
}
