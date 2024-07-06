package com.saeromteo.app.model.notification;

import java.sql.Date;
import java.time.LocalDateTime;

import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NotificationEntity {

	@ApiModelProperty(notes = "알림 ID", example = "N001", required = true)
	private String notificationId;

	@ApiModelProperty(notes = "알림 타입", example = "info", required = true)
	private String notificationType;

	@ApiModelProperty(notes = "알림 제목", example = "Welcome", required = true)
	private String notificationTitle;

	@ApiModelProperty(notes = "알림 내용", example = "Welcome to our service!")
	private String notificationBody;

	@ApiModelProperty(notes = "생성 시간", example = "2024-06-01T10:00:00", required = true)
	private String createdAt;

	@ApiModelProperty(notes = "읽은 시간", example = "2024-06-03T12:00:00")
	private Date readAt;

	@ApiModelProperty(notes = "유저 ID", example = "1", required = true)
	private int userId;

	@ApiModelProperty(notes = "관련 수거 ID", example = "C001")
	private Integer relatedCollectionId;

	@ApiModelProperty(notes = "관련 주문 ID", example = "O001")
	private String relatedOrderId;
	
	@ApiModelProperty(notes = "관련 주문 ID", example = "O001")
	private Integer relatedPointId;

	public String getNotificationId() {
		return notificationId;
	}

	public void setNotificationId(String notificationId) {
		this.notificationId = notificationId;
	}

	public String getNotificationType() {
		return notificationType;
	}

	public void setNotificationType(String notificationType) {
		this.notificationType = notificationType;
	}

	public String getNotificationTitle() {
		return notificationTitle;
	}

	public void setNotificationTitle(String notificationTitle) {
		this.notificationTitle = notificationTitle;
	}

	public String getNotificationBody() {
		return notificationBody;
	}

	public void setNotificationBody(String notificationBody) {
		this.notificationBody = notificationBody;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public Date getReadAt() {
		return readAt;
	}

	public void setReadAt(Date readAt) {
		this.readAt = readAt;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Integer getRelatedCollectionId() {
		return relatedCollectionId;
	}

	public void setRelatedCollectionId(Integer relatedCollectionId) {
		this.relatedCollectionId = relatedCollectionId;
	}

	public String getRelatedOrderId() {
		return relatedOrderId;
	}

	public void setRelatedOrderId(String relatedOrderId) {
		this.relatedOrderId = relatedOrderId;
	}
}
