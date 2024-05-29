package com.saeromteo.app.dao.order;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
@Repository
public class TestDao {
	@Autowired
	SqlSession sqlSession;
	String namespace="com.saeromteo.app.testDao.";
	
	public List<Integer> test ()throws DataAccessException {
		List<Integer> list = sqlSession.selectList(namespace+"test");
		return list;
	}
	
}
