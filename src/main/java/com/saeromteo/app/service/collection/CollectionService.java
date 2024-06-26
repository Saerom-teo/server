package com.saeromteo.app.service.collection;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.saeromteo.app.dao.collection.CollectionDao;
import com.saeromteo.app.model.collection.AiDto.PredictRequest;
import com.saeromteo.app.model.collection.AiDto.PredictResponse;
import com.saeromteo.app.model.collection.CollectionDto.RegistRequest;
import com.saeromteo.app.model.collection.CollectionEntity;
import com.saeromteo.app.util.InspectionUtil;
import com.saeromteo.app.util.S3Util;;

@Service
public class CollectionService {

	private final S3Util s3Util;
	private final InspectionUtil inspectionUtil;

	@Autowired
	public CollectionService(S3Util s3Util, InspectionUtil inspectionUtil) {
		this.s3Util = s3Util;
		this.inspectionUtil = inspectionUtil;
	}

	@Autowired
	CollectionDao collectionDao;

	// Request
	public int request(RegistRequest registRequest, List<MultipartFile> images) {
		// s3에 이미지 저장후 url 반환
		List<String> imageUrls = new ArrayList<>();
		for (MultipartFile file : images) {
			String imageUrl = s3Util.uploadFile(file, "collection");
			System.out.println(imageUrl);
			imageUrls.add(imageUrl);
		}

		// 수거 데이터 입력
		CollectionEntity collectionEntity = createCollectionEntityFromSubmitRequest(registRequest, imageUrls);
		int result = collectionDao.insertCollection(collectionEntity);

		if (result != -1) {
			// Fastapi로 요청 전송
			PredictRequest requestData = createPredictRequestEntity("yolov8n_0531_e30_b16.onnx", imageUrls);
			CompletableFuture<PredictResponse> futureResponse = inspectionUtil.postDataToApi(requestData);

			// 비동기 작업이 완료된 후 수행할 작업
			futureResponse.thenAccept(response -> {
				System.out.println(response.getResult());
				CollectionEntity resultCollectionEntity = createCollectionEntityFromSubmitRequest(result,
						response.getResult(), response.getImages());
				int result2 = collectionDao.updateCollection(resultCollectionEntity);
			});

		}

		return result;
	}

	// Approve
	public void approve(Integer collectionId) {
		CollectionEntity collectionEntity = createCollectionEntity(collectionId);
		int result = collectionDao.updateCollection(collectionEntity);
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

	public CollectionEntity createCollectionEntity(Integer collectionId) {
		CollectionEntity collectionEntity = new CollectionEntity();

		collectionEntity.setCollectionId(collectionId);
		collectionEntity.setApprovedDate(Timestamp.from(Instant.now()));

		return collectionEntity;
	}

	public CollectionEntity createCollectionEntityFromSubmitRequest(RegistRequest registRequest,
			List<String> imageUrls) {
		CollectionEntity collectionEntity = new CollectionEntity();

		collectionEntity.setImage1(imageUrls.size() > 0 ? imageUrls.get(0) : null);
		collectionEntity.setImage2(imageUrls.size() > 1 ? imageUrls.get(1) : null);
		collectionEntity.setImage3(imageUrls.size() > 2 ? imageUrls.get(2) : null);
		collectionEntity.setImage4(imageUrls.size() > 3 ? imageUrls.get(3) : null);
		collectionEntity.setAddress(registRequest.getAddress() + "/" + registRequest.getDetailAddress());
		collectionEntity.setUserId(1);

		return collectionEntity;
	}

	public CollectionEntity createCollectionEntityFromSubmitRequest(int collectionId, String result,
			List<String> imageUrls) {
		CollectionEntity collectionEntity = new CollectionEntity();

		collectionEntity.setCollectionId(collectionId);
		collectionEntity.setInspectionResult(result);
		collectionEntity.setResultImage1(imageUrls.size() > 0 ? imageUrls.get(0) : null);
		collectionEntity.setResultImage2(imageUrls.size() > 1 ? imageUrls.get(1) : null);
		collectionEntity.setResultImage3(imageUrls.size() > 2 ? imageUrls.get(2) : null);
		collectionEntity.setResultImage4(imageUrls.size() > 3 ? imageUrls.get(3) : null);

		return collectionEntity;
	}

	public PredictRequest createPredictRequestEntity(String modelName, List<String> imageUrls) {
		PredictRequest requestData = new PredictRequest();

		requestData.setModelName(modelName);
		requestData.setImages(imageUrls);

		return requestData;
	}

}
