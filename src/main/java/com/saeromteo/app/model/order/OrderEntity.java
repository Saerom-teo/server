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

	// �⺻ ������
	public OrderEntity() {
	}

	// �����ڿ��� orderCode�� �����ϴ� ���� �߰�
	public OrderEntity(LocalDateTime orderDate, String orderStatus, Integer userCode) {
		this.orderDate = orderDate;
		this.orderStatus = orderStatus;
		this.userCode = userCode;
		this.orderCode = generateOrderCode(orderDate, userCode);
	}

	// orderCode�� �����ϴ� �޼���
	private String generateOrderCode(LocalDateTime orderDate, Integer userCode) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmmss");
		return orderDate.format(formatter) + "-" + userCode;
	}
}
