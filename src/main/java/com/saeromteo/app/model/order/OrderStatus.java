package com.saeromteo.app.model.order;

public enum OrderStatus {
    STANDBY, // 주문 초기 상태 대기 중
    PAYMENT_REQUESTED, // 결제 버튼 누른 상태
    PAYMENT_PREPARING, // 결제 시스템 확인 후 결제 준비 완료 상태
    PAYMENT_COMPLETED, // 결제 완료
    PAYMENT_FAILED, // 결제 실패
    ORDER_COMPLETED, // 주문 완료
    ORDER_FAILED, // 주문 실패
    ORDER_CANCELLED, // 주문 취소
    SHIPPING, // 배송 중
    DELIVERED // 배송 완료
}
