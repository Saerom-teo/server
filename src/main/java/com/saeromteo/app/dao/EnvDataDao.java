package com.saeromteo.app.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.envdata.EnvironmentDataDto.EnvDataRequest;
import com.saeromteo.app.dto.envdata.EnvironmentDataDto.EnvDataResponse;

@Repository
public class EnvDataDao {
	
	private final SqlSessionTemplate sqlSession;
    private String namespace = "com.saeromteo.envdata.";

    @Autowired
    public EnvDataDao(@Qualifier("envDataSqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

	// Create
	public int createEnvData(EnvDataRequest envDto) {
		int result = sqlSession.insert(namespace + "createEnvData", envDto);
		return result;
	}

	// Read
	public List<EnvDataResponse> readAll() {
		List<EnvDataResponse> envDataList = sqlSession.selectList(namespace + "readAll");
		System.out.println(envDataList);
		return envDataList;
	}

	public EnvDataResponse readDetail(int env_id) {
		EnvDataResponse envData = sqlSession.selectOne(namespace + "readDetail", env_id);
		return envData;
	}

	public List<EnvDataResponse> readByCategory(String env_category) {
		List<EnvDataResponse> envDataList = sqlSession.selectList(namespace + "readByCategory", env_category);
		return envDataList;
	}

	public List<EnvDataResponse> readByType(String env_type) {
		List<EnvDataResponse> envDataList = sqlSession.selectList(namespace + "readByType", env_type);
		return envDataList;
	}

	// Read
	public int updateEnvData(EnvDataRequest envDto) {
		int result = sqlSession.update(namespace + "updateEnvData", envDto);
		return result;
	}

	// Delete
	public int deleteEnvData(int env_id) {
		int result = sqlSession.delete(namespace + "deleteEnvData", env_id);
		return result;
	}

}
