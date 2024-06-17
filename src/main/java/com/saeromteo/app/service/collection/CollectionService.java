package com.saeromteo.app.service.collection;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.collection.CollectionDao;
import com.saeromteo.app.model.collection.CollectionDto.SubmitRequest;
import com.saeromteo.app.model.collection.CollectionEntity;;

@Service
public class CollectionService {

	@Autowired
	CollectionDao collectionDao;

	// Registration
	public int registration(SubmitRequest submitRequest) {
		CollectionEntity collectionEntity = createCollectionEntityFromSubmitRequest(submitRequest);
		return collectionDao.insertCollection(collectionEntity);
	}
	
	// Request
	public int request(SubmitRequest submitRequest) {
		return 1;
	}
	
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

    public CollectionEntity createCollectionEntityFromSubmitRequest(SubmitRequest submitRequest) {
        CollectionEntity collectionEntity = new CollectionEntity();

        collectionEntity.setCollectionId("111");
        collectionEntity.setImage1("image1");
        collectionEntity.setImage2("image2");
        collectionEntity.setImage3("image3");
        collectionEntity.setImage4("image4");
        collectionEntity.setUserId(1);

        return collectionEntity;
    }
}
