package com.saeromteo.app.controller.user;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.saeromteo.app.service.user.MessageService;


@Controller
public class UserController {
    @Autowired
    @Qualifier("messageService")
    MessageService ms;
	
	@GetMapping(value = "/")
	public String home(Principal principal) {
	       if (principal == null) {
	            System.out.println("User is not authenticated.");
	            return "redirect:/auth/login";
	        }
	        System.out.println(principal.getName());
	        return "main";
	}
	
}
