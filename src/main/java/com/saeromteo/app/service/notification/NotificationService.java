package com.saeromteo.app.service.notification;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.notification.NotificationDao;
import com.saeromteo.app.model.notification.NotificationEntity;;

@Service
public class NotificationService {

	@Autowired
	NotificationDao notificationDao;

	// Read
	public List<NotificationEntity> readAll() {
		return notificationDao.readAll();
	}

	public NotificationEntity readById(String notificationId) {
		return notificationDao.readById(notificationId);
	}
	
	public List<NotificationEntity> readByUserId(int userId) {
		return notificationDao.readByUserId(userId);
	}

	// Insert
	public int insert(NotificationEntity notificationEntity) {
		return notificationDao.insert(notificationEntity);
	}

	// Update
	public int update(NotificationEntity notificationEntity) {
		return notificationDao.update(notificationEntity);
	}

	// Delete
	public int delete(String notificationId) {
		return notificationDao.delete(notificationId);
	}

}
