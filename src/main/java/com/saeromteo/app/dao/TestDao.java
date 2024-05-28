package com.saeromteo.app.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.TestDTO;
@Repository
public class TestDao {
	@Autowired
	SqlSession sqlSession;
	String namespace="com.saeromteo.app.testDao.";
	
	public List<TestDTO> test ()throws DataAccessException {
		List<TestDTO> list = sqlSession.selectList(namespace+"test");
		return list;
	}
	
}
