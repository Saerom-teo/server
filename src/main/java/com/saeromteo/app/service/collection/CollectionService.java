package com.saeromteo.app.service.collection;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.saeromteo.app.dao.collection.CollectionDao;
import com.saeromteo.app.model.collection.CollectionDto.SubmitRequest;
import com.saeromteo.app.model.collection.CollectionEntity;
import com.saeromteo.app.util.S3Util;;

@Service
public class CollectionService {

	private final S3Util s3Util;

	@Autowired
	public CollectionService(S3Util s3Util) {
		this.s3Util = s3Util;
	}

	@Autowired
	CollectionDao collectionDao;

	// Registration
	public int registration(SubmitRequest submitRequest) {
		return 0;
	}

	// Request
	public int request(SubmitRequest submitRequest, List<MultipartFile> images) {
		System.out.println("Name: " + submitRequest.getName());
		System.out.println("Phone: " + submitRequest.getPhone());
		System.out.println("Address: " + submitRequest.getAddress());
		System.out.println("Detail Address: " + submitRequest.getDetailAddress());

		// s3에 이미지 저장후 url 반환
		List<String> imageUrls = new ArrayList<>();
		for (MultipartFile file : images) {
			String imageUrl = s3Util.uploadFile(file);
			System.out.println(imageUrl);
			imageUrls.add(imageUrl);
		}

		CollectionEntity collectionEntity = createCollectionEntityFromSubmitRequest(submitRequest, imageUrls);
		return collectionDao.insertCollection(collectionEntity);
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

	public CollectionEntity createCollectionEntityFromSubmitRequest(SubmitRequest submitRequest, List<String> imageUrls) {
		CollectionEntity collectionEntity = new CollectionEntity();

		collectionEntity.setCollectionId("111");
	    collectionEntity.setImage1(imageUrls.size() > 0 ? imageUrls.get(0) : null);
	    collectionEntity.setImage2(imageUrls.size() > 1 ? imageUrls.get(1) : null);
	    collectionEntity.setImage3(imageUrls.size() > 2 ? imageUrls.get(2) : null);
	    collectionEntity.setImage4(imageUrls.size() > 3 ? imageUrls.get(3) : null);
		collectionEntity.setUserId(1);

		return collectionEntity;
	}
}
