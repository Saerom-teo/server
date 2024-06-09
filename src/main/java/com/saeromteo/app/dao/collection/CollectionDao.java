package com.saeromteo.app.dao.collection;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.envdata.EnvironmentDataDto.EnvDataRequest;
import com.saeromteo.app.dto.news.NewsDto.NewsRequest;
import com.saeromteo.app.dto.news.NewsDto.NewsResponse;
import com.saeromteo.app.model.collection.CollectionEntity;

@Repository
public class CollectionDao {

	private final SqlSessionTemplate sqlSession;
	private String namespace = "com.saeromteo.collection.";

	@Autowired
	public CollectionDao(@Qualifier("collectionSqlSessionTemplate") SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	// Read
	public List<CollectionEntity> readAll() {
		List<CollectionEntity> collectionList = sqlSession.selectList(namespace + "readAll");
		System.out.println(collectionList);
		return collectionList;
	}

	public CollectionEntity readById(String collectionId) {
		CollectionEntity collection = sqlSession.selectOne(namespace + "readById", collectionId);
		return collection;
	}
	
	public List<CollectionEntity> readByUserId(int userId) {
		List<CollectionEntity> collection = sqlSession.selectList(namespace + "readByUserId", userId);
		return collection;
	}

	// Insert
	public int insertCollection(CollectionEntity collectionEntity) {
		int result = sqlSession.insert(namespace + "insert", collectionEntity);
		return result;
	}
	
	// Update
	public int updateCollection(CollectionEntity collectionEntity) {
		int result = sqlSession.update(namespace + "update", collectionEntity);
		return result;
	}

	// Delete
	public int deleteCollection(String collectionId) {
		int result = sqlSession.delete(namespace + "delete", collectionId);
		return result;
	}

}
