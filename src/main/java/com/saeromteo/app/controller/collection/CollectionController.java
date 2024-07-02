package com.saeromteo.app.controller.collection;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.model.user.UserDTO;
import com.saeromteo.app.service.collection.CollectionService;
import com.saeromteo.app.service.user.UserService;

import io.swagger.annotations.Api;
import springfox.documentation.annotations.ApiIgnore;

@Controller
@RequestMapping("/collection")
@Api(tags = "Collection Management")
public class CollectionController {

	@Autowired
	CollectionService collectionService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	JWTUtil jwtUtil;

	@GetMapping("/intro")
	@ApiIgnore
	public String intro() {
		return "collection/intro";
	}
	
	@GetMapping("/regist")
	@ApiIgnore
	public String regist() {
		return "collection/regist";
	}
	
	@GetMapping("/regist-submit")
	@ApiIgnore
	public String registSubmit() {
		return "collection/regist-submit";
	}
	
	@GetMapping("/regist-complete")
	@ApiIgnore
	public String registComplete() {
		return "collection/regist-complete";
	}
	
	@GetMapping("/request")
	@ApiIgnore
	public String request() {
		return "collection/request";
	}
	
	@GetMapping("/request-submit")
	@ApiIgnore
	public String requestSubmit(HttpServletRequest request) {
		String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);
		
		UserDTO user = userService.readUserByUserId(userId);
		System.out.println(user);
		if (user.isUserCollStatus()) {
			return "collection/request-submit";			
		} else {
			return "collection/regist-submit";
		}
		
	}
	
	@GetMapping("/request-complete")
	@ApiIgnore
	public String requestComplete() {
		return "collection/request-complete";
	}
}