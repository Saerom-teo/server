package com.saeromteo.app.service.envdata;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.envdata.EnvDataDao;
import com.saeromteo.app.dto.envdata.EnvironmentDataDto.Request;
import com.saeromteo.app.dto.envdata.EnvironmentDataDto.Response;;

@Service
public class EnvDataService {

	@Autowired
	EnvDataDao envDao;

	// Create
	public int createEnvData(Request envDto) {
		return envDao.createEnvData(envDto);
	}

	// Read
	public List<Response> readAll() {
		return envDao.readAll();
	}

	public Response readDetail(int env_id) {
		return envDao.readDetail(env_id);
	}

	public List<Response> readByCategory(String env_category) {
		return envDao.readByCategory(env_category);
	}

	public List<Response> readByType(String env_type) {
		return envDao.readByType(env_type);
	}

	// Update
	public int updateEnvData(Request envDto) {
		return envDao.updateEnvData(envDto);
	}

	// Delete
	public int deleteEnvData(int env_id) {
		return envDao.deleteEnvData(env_id);
	}

}
