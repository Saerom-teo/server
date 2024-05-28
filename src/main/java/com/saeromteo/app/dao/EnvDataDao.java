package com.saeromteo.app.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EnvDataDao {
	
	@Autowired
	SqlSession sqlSession;

	String namespace = "com.saerom.envdata.";
	
	
}
