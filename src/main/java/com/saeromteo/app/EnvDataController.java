package com.saeromteo.app;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.dto.EnvironmentDataDto.Request;
import com.saeromteo.app.dto.EnvironmentDataDto.Response;;
import com.saeromteo.app.service.EnvDataService;

@RestController
@RequestMapping("/envdata/api/*")
public class EnvDataController {
	
	@Autowired
	EnvDataService envService;
	
	// Create
	@PostMapping(value="/create", consumes="application/json", produces="text/plain;charset=UTF-8")
	public int create(@RequestBody Request envDto) {
		int result = envService.createEnvData(envDto);
		return result;
	}
	
	// Read
	
	// Update
	
	// Delete
	
}
