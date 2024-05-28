package com.saeromteo.app;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.dto.EnvironmentDataDto.Request;
import com.saeromteo.app.dto.EnvironmentDataDto.Response;
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
	@GetMapping(value="/readAll", produces = "application/json")
	public List<Response> readAll() {
		List<Response> envDataList = envService.readAll();
		return envDataList;
	}
	
	@GetMapping(value="/readDetail/{env_id}", produces = "application/json")
	public Response readDetail(@PathVariable("env_id") Integer env_id) {
		Response envData = envService.readDetail(env_id);
		return envData;
	}
	
	@GetMapping(value="/readByCategory/{env_category}", produces = "application/json")
	public List<Response> readByCategory(@PathVariable("env_category") String env_category) {
		List<Response> envDataList = envService.readByCategory(env_category);
		return envDataList;
	}
	
	@GetMapping(value="/readByType/{env_type}", produces = "application/json")
	public List<Response> readByType(@PathVariable("env_type") String env_type) {
		List<Response> envDataList = envService.readByType(env_type);
		return envDataList;
	}
	
	// Update
	@PutMapping(value="/update", consumes = "application/json", produces="text/plain;charset=UTF-8")
	public int update(@RequestBody Request envDto) {
		int result = envService.updateEnvData(envDto);
		return result;
	}
	
	// Delete
	@DeleteMapping(value="/delete/{env_id}", produces="text/plain;charset=UTF-8")
	public int delete(@PathVariable("env_id") Integer env_id) {
		int result = envService.deleteEnvData(env_id);
		return result;
	}
	
}
