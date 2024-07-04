package com.saeromteo.app.controller.afterSales;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/afterSales")
public class AfterSalesController {

	@GetMapping("/refund")
	public String refundPage() {
		return "refund/refund";
	}
}
