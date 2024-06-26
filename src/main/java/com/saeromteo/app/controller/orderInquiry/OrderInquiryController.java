package com.saeromteo.app.controller.orderInquiry;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.service.orderInquiry.OrderInquiryService;


@Controller
@RequestMapping("/orderInquiry")
public class OrderInquiryController {

	
	@Autowired
	OrderInquiryService orderInquiryService;
	
	@GetMapping(value = "/list", produces = "application/json")
	public String orderInquiry(Model model) {
		List<OrderDetailResponse> orderList = orderInquiryService.readAll(1);
		model.addAttribute("orderList", orderList);
		return "orderInquiry/orderInquiry2";
	}
	
	@GetMapping(value = "/byPeriod", produces = "application/json")
	public String orderInquiryByPeriod(@RequestParam String period, Model model) {
		
		int userCode = 1;
		Date startDate = orderInquiryService.calculateStartDate(period);
		Date endDate = orderInquiryService.calculateEndDate();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<OrderDetailResponse> orderList = orderInquiryService.readByPeriod(userCode, sdf.format(startDate), sdf.format(endDate));
        
        return "orderInquiry/orderListFragment :: order-list";
	}
}
