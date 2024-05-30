package com.saeromteo.app.model.order;

public enum OrderStatus {
	STANDBY, // 주문 창에 처음 들어왔을 때
	PAYMENT_REQUESTED,// 결제 버튼 눌렀을 때
	PAYMENT_PREPARING, // 결제 시스템 정보 확인 후 전송 데이터 준비 완료 후
	PAYMENT_COMPLETED, // 결제 완료
	PAYMENT_FAILED, // 결제 실패
	ORDER_COMPLETED, // 주문 완료
	ORDER_CANCELLED,   // 주문 취소
	SHIPPING, // 배송중 
	DELIVERED, // 배송 완료

}
