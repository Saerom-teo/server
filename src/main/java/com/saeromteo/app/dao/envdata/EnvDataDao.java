package com.saeromteo.app.dao.envdata;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.envdata.EnvironmentDataDto.Request;
import com.saeromteo.app.dto.envdata.EnvironmentDataDto.Response;

@Repository
public class EnvDataDao {

	@Autowired
	SqlSession sqlSession;

	String namespace = "com.saerom.envdata.";

	public int createEnvData(Request envDto) {
		int result = sqlSession.insert(namespace + "createEnvData", envDto);
		return result;
	}

	public List<Response> readAll() {
		List<Response> envDataList = sqlSession.selectList(namespace + "readAll");
		return envDataList;
	}

	public Response readDetail(int env_id) {
		Response envData = sqlSession.selectOne(namespace + "readDetail", env_id);
		return envData;
	}

	public List<Response> readByCategory(String env_category) {
		List<Response> envDataList = sqlSession.selectList(namespace + "readByCategory", env_category);
		return envDataList;
	}

	public List<Response> readByType(String env_type) {
		List<Response> envDataList = sqlSession.selectList(namespace + "readByType", env_type);
		return envDataList;
	}

	public int updateEnvData(Request envDto) {
		int result = sqlSession.update(namespace + "updateEnvData", envDto);
		return result;
	}

	public int deleteEnvData(int env_id) {
		int result = sqlSession.delete(namespace + "deleteEnvData", env_id);
		return result;
	}

}
