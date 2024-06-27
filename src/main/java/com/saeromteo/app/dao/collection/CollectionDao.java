package com.saeromteo.app.dao.collection;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.model.collection.CollectionDto.ReadAllDto;
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
		return collectionList;
	}
	
	public List<ReadAllDto> readAllForAdmin() {
		List<ReadAllDto> collectionList = sqlSession.selectList(namespace + "readAllForAdmin");
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
        if (result > 0) {
            return collectionEntity.getCollectionId(); // 반환된 collectionId 가져오기
        } else {
            return -1; // 삽입 실패 시 -1 반환
        }
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
