package com.saeromteo.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.EnvDataDao;
import com.saeromteo.app.dto.EnvironmentDataDto;

@Service
public class EnvDataService {
	
	@Autowired
	EnvDataDao envDao;
	
	// Create
	public int createEnvData(EnvironmentDataDto.Request envDto) {
		return envDao.createEnvData(envDto);
	}
	
	// Read
	public List<EnvironmentDataDto.Response> readAll() {
		return envDao.readAll();
	}
	
	public EnvironmentDataDto.Response readDetail(int env_id) {
		return envDao.readDetail(env_id);
	}
	
	public List<EnvironmentDataDto.Response> readByCategory(String env_category) {
		return envDao.readByCategory(env_category);
	}
	
	public List<EnvironmentDataDto.Response> readByType(String env_type) {
		return envDao.readByType(env_type);
	}
	
	// Update
	public int updateEnvData(EnvironmentDataDto.Request envDto) {
		return envDao.updateEnvData(envDto);
	}
	
	// Delete
	public int deleteEnvData(int env_id) {
		return envDao.deleteEnvData(env_id);
	}
	
	
}
