package com.saeromteo.app.controller.faq;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/faq")
public class faqController {

	@GetMapping(value = "/read", produces = "application/json")
	public String readFaq() {
		return "faq/faq";
	}
	
}
