package com.saeromteo.app.controller.notification;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.model.notification.NotificationEntity;
import com.saeromteo.app.service.notification.NotificationService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

@RestController
@RequestMapping("/notification")
@Api(tags = "Notification Management")
public class NotificationController {

	@Autowired
	NotificationService notificationService;

	@PostMapping("/insert")
	@ApiOperation(value = "알림 등록", notes = "알림을 등록한다.")
	public String insertCollection(@RequestBody NotificationEntity notificationEntity) {
		int result = notificationService.insert(notificationEntity);
		return result + "건 입력됨";
	}

	@GetMapping(value = "/read-all", produces = "application/json")
	@ApiOperation(value = "알림 전부 조회", notes = "전체 알림 내역을 조회한다.")
	public List<NotificationEntity> readAll() {
		List<NotificationEntity> notificationList = notificationService.readAll();
		return notificationList;
	}

	@GetMapping("/read-by-user/{userId}")
	@ApiOperation(value = "사용자별 알림 조회", notes = "사용자별 알림을 조회한다.")
	public List<NotificationEntity> readByUser(
			@ApiParam(value = "사용자 ID", required = true) @PathVariable("userId") int userId) {
		List<NotificationEntity> notificationList = notificationService.readByUserId(userId);
		return notificationList;
	}

	@PutMapping(value = "/update", consumes = "application/json", produces = "text/plain;charset=UTF-8")
	@ApiOperation(value = "알림 수정", notes = "알림을 수정한다.")
	public String updateCollection(@RequestBody NotificationEntity notificationEntity) {
		int result = notificationService.update(notificationEntity);
		return result + "건 수정됨";
	}

	@DeleteMapping("/delete/{notificationId}")
	@ApiOperation(value = "알림 삭제", notes = "알림을 삭제한다.")
	public String deleteCollection(@PathVariable("notificationId") String notificationId) {
		int result = notificationService.delete(notificationId);
		return result + "건 삭제됨";
	}

}
