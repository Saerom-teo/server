package com.saeromteo.app.controller.user;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.saeromteo.app.service.user.EmailService;
import com.saeromteo.app.service.user.MessageService;


@Controller
public class UserController {

	@Autowired
	EmailService eService;
	
	@GetMapping(value = "/")
	public String home(Principal principal) {
	    return "main";
	}
	
}
