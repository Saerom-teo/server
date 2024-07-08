package com.saeromteo.app.service.point;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.point.PointDao;
import com.saeromteo.app.model.point.PointDto.PointResponse;
import com.saeromteo.app.model.point.PointDto.PointUpdateResponse;
import com.saeromteo.app.service.notification.NotificationService;
import com.saeromteo.app.model.notification.NotificationEntity;
import com.saeromteo.app.model.point.PointEntity;;

@Service
public class PointService {

	@Autowired
	PointDao pointDao;
	
	@Autowired
	NotificationService notificationService;

	public List<PointResponse> getPointsByUserId(int userId, int page, int size, String type) {
		int limit = size;
		int offset = (page - 1) * limit;

		List<PointEntity> pointList = pointDao.readByUserId(userId, limit, offset, type);

		List<PointResponse> pointResponses = new ArrayList<>();
		for (PointEntity point : pointList) {
			PointResponse pointResponse = new PointResponse();

			pointResponse.setPointId(point.getPointId());
			pointResponse.setAmount(point.getAmount());
			pointResponse.setAccrualType(point.getComment());
			pointResponse.setDateIssued(point.getDateIssued());

			pointResponses.add(pointResponse);
		}

		return pointResponses;
	}

	public int getTotalPointsByUserId(int userId, String type) {
		return pointDao.countPointsByUserId(userId, type);
	}

	// ============================================
	// Read
	public List<PointEntity> readAll() {
		return pointDao.readAll();
	}

	public PointEntity readById(int pointId) {
		return pointDao.readById(pointId);
	}

	// Insert
	public int insert(PointEntity pointEntity) {
		int result = pointDao.insert(pointEntity);
		
		// notice to user
		NotificationEntity notification = new NotificationEntity();
		
		notification.setNotificationType("알림");
		notification.setNotificationTitle("포인트");
		notification.setNotificationBody("포인트가 지급되었습니다.");
		notification.setUserId(pointEntity.getUserId());
		notification.setRelatedPointId(result);
		
		System.out.println("포인트: " + result);
		
		notificationService.insert(notification);
		
		return result;
	}
	
	public int insertPoint(PointEntity pointEntity) {
		int result = pointDao.insert(pointEntity);
		return result;
	}

	public int insertToCollection(Integer collectionId, int point, Integer userId) {
		PointEntity pointEntity = new PointEntity();

		pointEntity.setType("earned");
		pointEntity.setAmount(point);
		pointEntity.setEarningSource("collection");
		pointEntity.setUserId(userId);
		pointEntity.setComment("수거 완료 포인트");

		return pointDao.insert(pointEntity);
	}
	
	public int insertPoint(Integer userId, int point,String type,String earningSource,String comment) {
		PointEntity pointEntity = new PointEntity();
		pointEntity.setUserId(userId);
		pointEntity.setAmount(point);
		pointEntity.setType(type);
		pointEntity.setEarningSource(earningSource);
		pointEntity.setComment(comment);
		
		return pointDao.insert(pointEntity);
	}

	// Update
	public int update(PointUpdateResponse pointUpdateResponse) {
		PointEntity pointEntity = new PointEntity();

		if (pointUpdateResponse.getSource().equals("purchase")) {
			pointEntity.setSpendingSource(pointUpdateResponse.getSource());
		} else {
			pointEntity.setEarningSource(pointUpdateResponse.getSource());
		}

		pointEntity.setPointId(pointUpdateResponse.getPointId());
		pointEntity.setAmount(pointUpdateResponse.getAmount());
		pointEntity.setComment(pointUpdateResponse.getComment());

		System.out.println("=================================================");
		System.out.println(pointEntity);
		System.out.println("=================================================");

		return pointDao.update(pointEntity);
	}

	// Delete
	public int delete(String pointId) {
		return pointDao.delete(pointId);
	}

	public int getUserRank(int userId) {
		int totalPoint = pointDao.readEarnedTotalByUserId(userId);
		
		if (totalPoint >= 1000 && totalPoint < 3000) {
			return 2;
		} else if (totalPoint >= 3000 && totalPoint < 5000) {
			return 3;
		} else if (totalPoint >= 5000 && totalPoint < 7000) {
			return 4;
		} else if (totalPoint >= 7000) {
			return 5;
		} else {
			return 1;
		}
	}

}
