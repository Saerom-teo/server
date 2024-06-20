package com.saeromteo.app.service.envdata;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.envdata.EnvDataDao;
import com.saeromteo.app.dto.envdata.EnvironmentDataDto.EnvDataRequest;
import com.saeromteo.app.dto.envdata.EnvironmentDataDto.EnvDataResponse;;

@Service
public class EnvDataService {

	@Autowired
	EnvDataDao envDao;

	// Create
	public int createEnvData(EnvDataRequest envDto) {
		return envDao.createEnvData(envDto);
	}

	// Read
	public List<EnvDataResponse> readAll() {
		return envDao.readAll();
	}

	public EnvDataResponse readDetail(int env_id) {
		return envDao.readDetail(env_id);
	}

	public List<EnvDataResponse> readByMainCategory(String env_category) {
		return envDao.readByMainCategory(env_category);
	}
	
	public List<EnvDataResponse> readBySubCategory(String env_category) {
		return envDao.readBySubCategory(env_category);
	}

	public List<EnvDataResponse> readByType(String env_type) {
		return envDao.readByType(env_type);
	}

	// Update
	public int updateEnvData(EnvDataRequest envDto) {
		return envDao.updateEnvData(envDto);
	}

	// Delete
	public int deleteEnvData(int env_id) {
		return envDao.deleteEnvData(env_id);
	}

}
