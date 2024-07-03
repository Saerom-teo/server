package com.saeromteo.app.service.point;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.point.PointDao;
import com.saeromteo.app.model.point.PointDto.PointResponse;
import com.saeromteo.app.model.point.PointDto.PointUpdateResponse;
import com.saeromteo.app.model.point.PointEntity;;

@Service
public class PointService {

	@Autowired
	PointDao pointDao;

    public List<PointResponse> getPointsByUserId(int userId, int page, int size, String type) {
        int limit = size;
        int offset = (page - 1) * limit;
        
		List<PointEntity> pointList = pointDao.readByUserId(userId, limit, offset, type);
		
		List<PointResponse> pointResponses = new ArrayList<>();
		for (PointEntity point:pointList) {
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
	
	//============================================
	// Read
	public List<PointEntity> readAll() {
		return pointDao.readAll();
	}

	public PointEntity readById(String pointId) {
		return pointDao.readById(pointId);
	}
	

	// Insert
	public int insert(PointEntity pointEntity) {
		return pointDao.insert(pointEntity);
	}
	
	public int insertToCollection(Integer collectionId, int point) {
		PointEntity pointEntity = new PointEntity();
		
		pointEntity.setType("earned");
		pointEntity.setAmount(point);
		pointEntity.setEarningSource("collection");
		pointEntity.setUserId(1);
		pointEntity.setComment("수거 완료 포인트");
		
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

}
