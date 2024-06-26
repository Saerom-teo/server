package com.saeromteo.app.service.point;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.point.PointDao;
import com.saeromteo.app.model.point.PointEntity;;

@Service
public class PointService {

	@Autowired
	PointDao pointDao;

	// Read
	public List<PointEntity> readAll() {
		return pointDao.readAll();
	}

	public PointEntity readById(String pointId) {
		return pointDao.readById(pointId);
	}
	
	public List<PointEntity> readByUserId(int userId) {
		return pointDao.readByUserId(userId);
	}

	// Insert
	public int insert(PointEntity pointEntity) {
		return pointDao.insert(pointEntity);
	}

	// Update
	public int update(PointEntity pointEntity) {
		return pointDao.update(pointEntity);
	}

	// Delete
	public int delete(String pointId) {
		return pointDao.delete(pointId);
	}

}
