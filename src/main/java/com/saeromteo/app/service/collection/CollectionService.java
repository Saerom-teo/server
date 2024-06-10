package com.saeromteo.app.service.collection;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.collection.CollectionDao;
import com.saeromteo.app.dao.envdata.EnvDataDao;
import com.saeromteo.app.dto.envdata.EnvironmentDataDto.EnvDataRequest;
import com.saeromteo.app.dto.envdata.EnvironmentDataDto.EnvDataResponse;
import com.saeromteo.app.model.collection.CollectionEntity;;

@Service
public class CollectionService {

	@Autowired
	CollectionDao collectionDao;

	// Read
	public List<CollectionEntity> readAll() {
		return collectionDao.readAll();
	}

	public CollectionEntity readById(String collectionId) {
		return collectionDao.readById(collectionId);
	}
	
	public List<CollectionEntity> readByUserId(int userId) {
		return collectionDao.readByUserId(userId);
	}

	// Insert
	public int insertCollection(CollectionEntity collectionEntity) {
		return collectionDao.insertCollection(collectionEntity);
	}

	// Update
	public int updateCollection(CollectionEntity collectionEntity) {
		return collectionDao.updateCollection(collectionEntity);
	}

	// Delete
	public int deleteCollection(String collectionId) {
		return collectionDao.deleteCollection(collectionId);
	}

}
