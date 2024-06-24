package com.saeromteo.app.service.user;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender emailSender;
    
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

    // 이메일 전송
    public void sendSimpleMessage(String to, String subject, String text) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(to);
            message.setSubject(subject);
            message.setText(text);
            emailSender.send(message);
        } catch (MailException ex) {
            // 이메일 전송 실패 시 예외 처리
            throw new RuntimeException("이메일 전송에 실패했습니다.", ex);
        }
    }
}
