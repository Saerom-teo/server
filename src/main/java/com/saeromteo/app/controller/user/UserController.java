package com.saeromteo.app.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {
	@GetMapping(value = "/")
	public String login() {
		return "main";
	}
}
