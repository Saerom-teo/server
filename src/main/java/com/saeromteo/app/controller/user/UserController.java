package com.saeromteo.app.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.saeromteo.app.service.user.EmailService;


@Controller
public class UserController {

	@Autowired
	EmailService eService;
	
	@GetMapping(value = "/")
	public String home( ) {
	    return "main";
	}
	
}
