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

	
}
