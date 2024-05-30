package com.saeromteo.app.model.order;

public enum OrderStatus {
	STANDBY, // �ֹ� â�� ó�� ������ ��
	PAYMENT_REQUESTED,// ���� ��ư ������ ��
	PAYMENT_PREPARING, // ���� �ý��� ���� Ȯ�� �� ���� ������ �غ� �Ϸ� ��
	PAYMENT_COMPLETED, // ���� �Ϸ�
	PAYMENT_FAILED, // ���� ����
	ORDER_COMPLETED, // �ֹ� �Ϸ�
	ORDER_CANCELLED,   // �ֹ� ���
	SHIPPING, // ����� 
	DELIVERED, // ��� �Ϸ�

}
