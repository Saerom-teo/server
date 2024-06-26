package com.saeromteo.app.service.user;

import java.util.Random;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Service("messageService") // Spring에서 이 클래스를 서비스로 인식할 수 있도록 설정
@PropertySource("classpath:security.properties") // security.properties 파일에서 값을 읽어옴
public class MessageService {
	private DefaultMessageService messageService; // 메시지 서비스 객체

	@Value("${sms.key}") // security.properties에서 sms.key 값을 읽어옴
	private String smsKey;

	@Value("${sms.secret}") // security.properties에서 sms.secret 값을 읽어옴
	private String smsSecret;

	@Value("${sms.number}") // security.properties에서 sms.number 값을 읽어옴
	private String number;

	// 6자리의 랜덤 숫자를 생성하는 메소드
	public String randomNumber() {
		Random random = new Random(); // 랜덤 객체 생성
		int createNum = 0; // 생성할 난수 변수
		String ranNum = ""; // 난수 문자열 변수
		int letter = 6; // 생성할 난수 자릿수
		String resultNum = ""; // 최종 결과 난수 문자열

		// 6자리 난수 생성
		for (int i = 0; i < letter; i++) {
			createNum = random.nextInt(9); // 0부터 9까지 난수 생성
			ranNum = Integer.toString(createNum); // 생성한 난수를 문자열로 변환
			resultNum += ranNum; // 결과 난수에 추가
		}

		System.out.println(resultNum); // 생성한 난수 출력

		return resultNum; // 생성한 6자리 난수 반환
	}

	@PostConstruct // 객체 생성 후 초기화 메소드
	public void init() {
		// SMS API 키와 시크릿 키가 null이거나 비어 있으면 예외 발생
		if (smsKey == null || smsKey.isEmpty() || smsSecret == null || smsSecret.isEmpty()) {
			throw new IllegalArgumentException("API key and secret must be provided");
		}
		// NurigoApp을 사용하여 메시지 서비스 초기화
		this.messageService = NurigoApp.INSTANCE.initialize(smsKey, smsSecret, "https://api.coolsms.co.kr");
	}

	// 인증번호를 받는 사람에게 SMS를 보내는 메소드
	public String sendMessage(String toNumber) {
		// 랜덤 번호 6자리 생성
		String num = randomNumber();
		// SMS 메시지 객체 생성
		Message message = new Message();
		message.setFrom(number); // 보내는 사람 번호 설정
		message.setTo(toNumber); // 받는 사람 번호 설정
		message.setText("새롬터 본인 인증 번호 입니다." + num); // 메시지 내용 설정
		// SMS 메시지 전송 요청
		SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
		System.out.println(response); // 전송 결과 출력

		return num; // 생성한 인증번호 반환
	}
}
