package com.saeromteo.app.controller.collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.service.collection.CollectionService;

import io.swagger.annotations.Api;
import springfox.documentation.annotations.ApiIgnore;

@Controller
@RequestMapping("/collection")
@Api(tags = "Collection Management")
public class CollectionController {

	@Autowired
	CollectionService collectionService;

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
	
	@GetMapping("/request-submit")
	@ApiIgnore
	public String requestSubmit() {
		return "collection/request-submit";
	}
	
	@GetMapping("/request")
	@ApiIgnore
	public String request() {
		return "collection/request";
	}
}