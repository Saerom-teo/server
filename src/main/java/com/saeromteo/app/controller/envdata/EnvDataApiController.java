package com.saeromteo.app.controller.envdata;

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

import com.saeromteo.app.dto.envdata.EnvironmentDataDto.EnvDataRequest;
import com.saeromteo.app.dto.envdata.EnvironmentDataDto.EnvDataResponse;
import com.saeromteo.app.service.envdata.EnvDataService;

@RestController
@RequestMapping("/envdata/api")
public class EnvDataApiController {
	
	@Autowired
	EnvDataService envService;
	
	// Create
	@PostMapping(value="/create", consumes="application/json", produces="text/plain;charset=UTF-8")
	public String create(@RequestBody EnvDataRequest envDto) {
		int result = envService.createEnvData(envDto);
		return result+"�� �Է�";
	}
	
	// Read
	@GetMapping(value="/readAll", produces = "application/json")
	public List<EnvDataResponse> readAll() {
		List<EnvDataResponse> envDataList = envService.readAll();
		return envDataList;
	}
	
	@GetMapping(value="/readDetail/{env_id}", produces = "application/json")
	public EnvDataResponse readDetail(@PathVariable("env_id") Integer env_id) {
		EnvDataResponse envData = envService.readDetail(env_id);
		return envData;
	}
	
	@GetMapping(value="/readByMainCategory/{env_category}", produces = "application/json")
	public List<EnvDataResponse> readByMainCategory(@PathVariable("env_category") String env_category) {
		List<EnvDataResponse> envDataList = envService.readByMainCategory(env_category);
		return envDataList;
	}
	
	@GetMapping(value="/readBySubCategory/{env_category}", produces = "application/json")
	public List<EnvDataResponse> readBySubCategory(@PathVariable("env_category") String env_category) {
		List<EnvDataResponse> envDataList = envService.readBySubCategory(env_category);
		return envDataList;
	}
	
	@GetMapping(value="/readByType/{env_type}", produces = "application/json")
	public List<EnvDataResponse> readByType(@PathVariable("env_type") String env_type) {
		List<EnvDataResponse> envDataList = envService.readByType(env_type);
		return envDataList;
	}
	
	// Update
	@PutMapping(value="/update", consumes = "application/json", produces="text/plain;charset=UTF-8")
	public String update(@RequestBody EnvDataRequest envDto) {
		int result = envService.updateEnvData(envDto);
		return result+"�� ����";
	}
	
	// Delete
	@DeleteMapping(value="/delete/{env_id}", produces="text/plain;charset=UTF-8")
	public String delete(@PathVariable("env_id") Integer env_id) {
		int result = envService.deleteEnvData(env_id);
		return result+"�� ����";
	}
	
}
