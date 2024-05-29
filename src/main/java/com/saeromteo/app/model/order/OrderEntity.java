package com.saeromteo.app.model.order;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderEntity {

	private String orderCode;
	private LocalDateTime orderDate;
	private String orderStatus;
	private Integer userCode;

	// 기본 생성자
	public OrderEntity() {
	}

	// 생성자에서 orderCode를 생성하는 로직 추가
	public OrderEntity(LocalDateTime orderDate, String orderStatus, Integer userCode) {
		this.orderDate = orderDate;
		this.orderStatus = orderStatus;
		this.userCode = userCode;
		this.orderCode = generateOrderCode(orderDate, userCode);
	}

	// orderCode를 생성하는 메서드
	private String generateOrderCode(LocalDateTime orderDate, Integer userCode) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmmss");
		return orderDate.format(formatter) + "-" + userCode;
	}
}
