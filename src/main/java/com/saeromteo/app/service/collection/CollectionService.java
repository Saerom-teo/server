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
import com.saeromteo.app.model.collection.CollectionDto.ReadAllDto;
import com.saeromteo.app.model.collection.CollectionDto.ReadCollectionResponse;
import com.saeromteo.app.model.collection.CollectionDto.RegistRequest;
import com.saeromteo.app.model.notification.NotificationEntity;
import com.saeromteo.app.model.collection.CollectionEntity;
import com.saeromteo.app.service.notification.NotificationService;
import com.saeromteo.app.service.point.PointService;
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
	
	@Autowired
	PointService pointService;
	
	@Autowired
	NotificationService notificationService;

	// Request
	public int request(int userId, RegistRequest registRequest, List<MultipartFile> images) {
		// s3에 이미지 저장후 url 반환
		List<String> imageUrls = new ArrayList<>();
		for (MultipartFile file : images) {
			String imageUrl = s3Util.uploadFile(file, "collection");
			System.out.println(imageUrl);
			imageUrls.add(imageUrl);
		}

		// 수거 데이터 입력
		CollectionEntity collectionEntity = createCollectionEntityFromSubmitRequest(userId, registRequest, imageUrls);
		int result = collectionDao.insertCollection(collectionEntity);

		if (result != -1) {
			// Fastapi로 요청 전송
			PredictRequest requestData = createPredictRequestEntity("yolov8n_0531_e30_b16.onnx", imageUrls);
			CompletableFuture<PredictResponse> futureResponse = inspectionUtil.postDataToApi(requestData);

			// 비동기 작업이 완료된 후 수행할 작업
			futureResponse.thenAccept(response -> {
				System.out.println("=======================");
				System.out.println(response.getResult());
				System.out.println("=======================");
				CollectionEntity resultCollectionEntity = createCollectionEntityFromSubmitRequest(result,
						response.getResult(), response.getImages());
				System.out.println(resultCollectionEntity);
				int result2 = collectionDao.updateCollection(resultCollectionEntity);
			});

		}

		return result;
	}

	// Approve
	public void approve(Integer collectionId) {
		CollectionEntity collectionEntity = createCollectionEntity(collectionId, "approve");
		
		CollectionEntity collection = collectionDao.readById(collectionId);
		
		NotificationEntity notification = new NotificationEntity();
		notification.setNotificationTitle("수거");
		notification.setNotificationBody("수거 요청이 승인되었습니다.");
		notification.setNotificationType("알림");
		notification.setRelatedCollectionId(collectionId);
		notification.setUserId(collection.getUserId());
		
		notificationService.insert(notification);
		
		collectionDao.updateCollection(collectionEntity);
	}

	// Complete
	public void complete(Integer collectionId) {
		CollectionEntity collectionEntity = createCollectionEntity(collectionId, "complete");
		
		CollectionEntity collection = collectionDao.readById(collectionId);
		
		NotificationEntity notification = new NotificationEntity();
		notification.setNotificationTitle("수거");
		notification.setNotificationBody("수거가 완료되었습니다.");
		notification.setNotificationType("알림");
		notification.setRelatedCollectionId(collectionId);
		notification.setUserId(collection.getUserId());
		
		notificationService.insert(notification);
		
		
		collectionDao.updateCollection(collectionEntity);
	}
	
	// Weight
	public void inputWeight(Integer collectionId, Float weight) {
		CollectionEntity collectionEntity = createCollectionEntity(collectionId, weight);
		collectionDao.updateCollection(collectionEntity);
		
		CollectionEntity collection = collectionDao.readById(collectionId);
		
		int point = calculatePoint(weight);		
		pointService.insertToCollection(collectionId, point, collection.getUserId());
	}

	// Read
	public List<ReadAllDto> readAllForAdmin() {
		return collectionDao.readAllForAdmin();
	}

	public List<ReadCollectionResponse> readByUserId(int userId) {
		List<ReadAllDto> collectionList = collectionDao.readByUserId(userId);
		List<ReadCollectionResponse> readCollectionResponse = createReadCollectionResponse(collectionList);

		return readCollectionResponse;
	}

	public CollectionEntity readById(int collectionId) {
		return collectionDao.readById(collectionId);
	}

	// Insert
	public int insertCollection(CollectionEntity collectionEntity) {
		return collectionDao.insertCollection(collectionEntity);
	}

	// Update
	public int updateCollection(CollectionEntity collectionEntity) {
		return collectionDao.updateCollection(collectionEntity);
	}
	
	public int cancelCollection(Integer collectionId) {
		CollectionEntity collectionEntity = new CollectionEntity();
		collectionEntity.setCollectionId(collectionId);
		collectionEntity.setCollectionStatus(false);
		return collectionDao.updateCollection(collectionEntity);
	}

	// Delete
	public int deleteCollection(String collectionId) {
		return collectionDao.deleteCollection(collectionId);
	}

	public CollectionEntity createCollectionEntity(Integer collectionId, String type) {
		CollectionEntity collectionEntity = new CollectionEntity();

		collectionEntity.setCollectionId(collectionId);
		
		if (type.equals("approve")) {			
			collectionEntity.setApprovedDate(Timestamp.from(Instant.now()));
		}
		if (type.equals("complete")) {			
			collectionEntity.setCompletedDate(Timestamp.from(Instant.now()));
		}

		return collectionEntity;
	}

	public CollectionEntity createCollectionEntity(Integer collectionId, Float weight) {
		CollectionEntity collectionEntity = new CollectionEntity();

		collectionEntity.setCollectionId(collectionId);
		collectionEntity.setWeight(weight);
		collectionEntity.setCompletedDate(Timestamp.from(Instant.now()));

		return collectionEntity;
	}

	public CollectionEntity createCollectionEntityFromSubmitRequest(int userId, RegistRequest registRequest,
			List<String> imageUrls) {
		CollectionEntity collectionEntity = new CollectionEntity();

		collectionEntity.setImage1(imageUrls.size() > 0 ? imageUrls.get(0) : null);
		collectionEntity.setImage2(imageUrls.size() > 1 ? imageUrls.get(1) : null);
		collectionEntity.setImage3(imageUrls.size() > 2 ? imageUrls.get(2) : null);
		collectionEntity.setImage4(imageUrls.size() > 3 ? imageUrls.get(3) : null);
		collectionEntity.setAddress(registRequest.getAddress() + "/" + registRequest.getDetailAddress());
		collectionEntity.setUserId(userId);

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

	public List<ReadCollectionResponse> createReadCollectionResponse(List<ReadAllDto> collectionList) {
		List<ReadCollectionResponse> readCollectionResponse = new ArrayList<>();

		for (ReadAllDto collection : collectionList) {
			ReadCollectionResponse responseData = new ReadCollectionResponse();

			Float weight = collection.getWeight();
			int point = calculatePoint(weight);

			String status = "검사중";
			int highlight = 1;

			String inspectionResult = collection.getInspectionResult();
			if (inspectionResult != null) {
				if (inspectionResult.equals("clear")) {
					status = "승인 대기";
					highlight = 2;
				}
				if (inspectionResult.equals("deny")) {
					status = "검사 실패";
					highlight = 1;
				}
			}
			if (collection.getApprovedDate() != null) {
				status = "수거중";
				highlight = 3;
			}
			if (collection.getCompletedDate() != null) {
				status = "수거 완료";
				highlight = 4;
			}
			if (collection.getWeight() != null) {
				status = "포인트 지급 완료";
				highlight = 5;
			}
			if (collection.getCollectionStatus() == false) {
				status = "취소";
			}
			

			responseData.setCollectionId(collection.getCollectionId());
			responseData.setRequestedDate(collection.getRequestedDate());
			responseData.setWeight(collection.getWeight());
			responseData.setPoint(point);
			responseData.setStatus(status);
			responseData.setHighlight(highlight);
			responseData.setCollectionStatus(collection.getCollectionStatus());

			responseData.setResultImage1(collection.getResultImage1());
			responseData.setResultImage2(collection.getResultImage2());
			responseData.setResultImage3(collection.getResultImage3());
			responseData.setResultImage4(collection.getResultImage4());

			readCollectionResponse.add(responseData);

		}

		return readCollectionResponse;
	}
	
	public int calculatePoint(Float weight) {
		int point = (weight != null) ? (int) Math.floor(weight * 1000 * 10) / 10 : 0;
		return point;
	}

}
