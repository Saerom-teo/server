package com.saeromteo.app.dao.point;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.point.EarningPointDto;
import com.saeromteo.app.model.point.PointEntity;

@Repository
public class PointDao {

	private final SqlSessionTemplate sqlSession;
	private String namespace = "com.saeromteo.point.";

	@Autowired
	public PointDao(@Qualifier("pointSqlSessionTemplate") SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	// Read
	public List<PointEntity> readAll() {
		List<PointEntity> pointList = sqlSession.selectList(namespace + "readAll");
		return pointList;
	}

	public PointEntity readById(String pointId) {
		PointEntity point = sqlSession.selectOne(namespace + "readById", pointId);
		return point;
	}
	
	public List<PointEntity> readByUserId(int userId) {
		List<PointEntity> pointList = sqlSession.selectList(namespace + "readByUserId", userId);
		return pointList;
	}
	
	public Integer readTotalPoint(EarningPointDto earningPoint) {
		int result = sqlSession.selectOne(namespace + "readByUserIdEarning");
		return result;
	}

	// Insert
	public int insert(PointEntity pointEntity) {
		int result = sqlSession.insert(namespace + "insert", pointEntity);
		return result;
	}
	
	// Update
	public int update(PointEntity pointEntity) {
		int result = sqlSession.update(namespace + "update", pointEntity);
		return result;
	}

	// Delete
	public int delete(String pointId) {
		int result = sqlSession.delete(namespace + "delete", pointId);
		return result;
	}

}
