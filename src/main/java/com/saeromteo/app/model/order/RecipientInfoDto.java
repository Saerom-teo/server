package com.saeromteo.app.model.order;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RecipientInfoDto {
	
		String recipient;
		String userEmail;
		String phoneNumber;
		String address;
		String detailAddress;
		String zipCode;

}
