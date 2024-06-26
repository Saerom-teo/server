package com.saeromteo.app.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.saeromteo.app.service.user.EmailService;


@Controller
public class UserController {

	@Autowired
	EmailService eService;
	
    @GetMapping("/")
    public String home(@AuthenticationPrincipal OidcUser principal, Model model) {
        if (principal != null) {
            model.addAttribute("name", principal.getAttribute("name"));
        }
        return "home"; // home.html 뷰로 리디렉션
    }
	
}
