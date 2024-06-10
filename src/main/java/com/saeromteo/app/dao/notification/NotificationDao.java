package com.saeromteo.app.dao.notification;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.model.notification.NotificationEntity;

@Repository
public class NotificationDao {

	private final SqlSessionTemplate sqlSession;
	private String namespace = "com.saeromteo.notification.";

	@Autowired
	public NotificationDao(@Qualifier("notificationSqlSessionTemplate") SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	// Read
	public List<NotificationEntity> readAll() {
		List<NotificationEntity> notificationList = sqlSession.selectList(namespace + "readAll");
		return notificationList;
	}

	public NotificationEntity readById(String notificationId) {
		NotificationEntity notification = sqlSession.selectOne(namespace + "readById", notificationId);
		return notification;
	}
	
	public List<NotificationEntity> readByUserId(int userId) {
		List<NotificationEntity> notification = sqlSession.selectList(namespace + "readByUserId", userId);
		return notification;
	}

	// Insert
	public int insert(NotificationEntity notificationEntity) {
		int result = sqlSession.insert(namespace + "insert", notificationEntity);
		return result;
	}
	
	// Update
	public int update(NotificationEntity notificationEntity) {
		int result = sqlSession.update(namespace + "update", notificationEntity);
		return result;
	}

	// Delete
	public int delete(String notificationId) {
		int result = sqlSession.delete(namespace + "delete", notificationId);
		return result;
	}

}
