package com.saeromteo.app.service.collection;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.saeromteo.app.dao.collection.CollectionDao;
import com.saeromteo.app.model.collection.AiDto.PredictRequest;
import com.saeromteo.app.model.collection.AiDto.PredictResponse;
import com.saeromteo.app.model.collection.CollectionDto.RegistRequest;
import com.saeromteo.app.model.collection.CollectionEntity;
import com.saeromteo.app.util.S3Util;;

@Service
public class CollectionService {

	private final S3Util s3Util;
	private final RestTemplate restTemplate;

	@Autowired
	public CollectionService(S3Util s3Util, RestTemplate restTemplate) {
		this.s3Util = s3Util;
		this.restTemplate = restTemplate;
	}

	@Autowired
	CollectionDao collectionDao;

	// Registration
//	public int registration(SubmitRequest submitRequest) {
//		return 0;
//	}

	// Request
	public int request(RegistRequest registRequest, List<MultipartFile> images) {
		System.out.println("Name: " + registRequest.getName());
		System.out.println("Phone: " + registRequest.getPhone());
		System.out.println("Address: " + registRequest.getAddress());
		System.out.println("Detail Address: " + registRequest.getDetailAddress());

		// s3에 이미지 저장후 url 반환
		List<String> imageUrls = new ArrayList<>();
		for (MultipartFile file : images) {
			String imageUrl = s3Util.uploadFile(file);
			System.out.println(imageUrl);
			imageUrls.add(imageUrl);
		}
		CollectionEntity collectionEntity = createCollectionEntityFromSubmitRequest(registRequest, imageUrls);
		System.out.println(collectionEntity);
		int result = collectionDao.insertCollection(collectionEntity);
		
		return result;
	}
//
//		return collectionDao.insertCollection(collectionEntity);
//	}

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

	public CollectionEntity createCollectionEntityFromSubmitRequest(RegistRequest registRequest,
			List<String> imageUrls) {
		CollectionEntity collectionEntity = new CollectionEntity();

		collectionEntity.setCollectionId("111");
		collectionEntity.setImage1(imageUrls.size() > 0 ? imageUrls.get(0) : null);
		collectionEntity.setImage2(imageUrls.size() > 1 ? imageUrls.get(1) : null);
		collectionEntity.setImage3(imageUrls.size() > 2 ? imageUrls.get(2) : null);
		collectionEntity.setImage4(imageUrls.size() > 3 ? imageUrls.get(3) : null);
		collectionEntity.setUserId(1);

		return collectionEntity;
	}

	public PredictResponse postDataToApi(PredictRequest requestData) {
		String url = "http://127.0.0.1:8000/api/predict/test";
		HttpHeaders headers = new HttpHeaders();
		headers.set("Content-Type", "application/json");

		HttpEntity<PredictRequest> request = new HttpEntity<>(requestData, headers);
		ResponseEntity<PredictResponse> response = restTemplate.exchange(url, HttpMethod.POST, request,
				PredictResponse.class);

		return response.getBody();
	}
}
