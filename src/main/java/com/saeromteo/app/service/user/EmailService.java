package com.saeromteo.app.service.user;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
    public void sendSimpleMessage(String to, String subject, String verificationCode) {
        try {
        	
        	 ClassPathResource resource = new ClassPathResource("email-template.html");
             String htmlContent = new String(Files.readAllBytes(resource.getFile().toPath()));

             //String htmlContent = "<h1>Welcome to Java Mail</h1>"
             //        + "<p>This is a <b>HTML</b> email.</p>";
             System.out.println("===============================================");
             System.out.println(htmlContent);
             System.out.println("===============================================");
             htmlContent = htmlContent.replace("{{verificationCode0}}", verificationCode.substring(0, 1));
             htmlContent = htmlContent.replace("{{verificationCode1}}", verificationCode.substring(1, 2));
             htmlContent = htmlContent.replace("{{verificationCode2}}", verificationCode.substring(2, 3));
             htmlContent = htmlContent.replace("{{verificationCode3}}", verificationCode.substring(3, 4));
             htmlContent = htmlContent.replace("{{verificationCode4}}", verificationCode.substring(4, 5));
             htmlContent = htmlContent.replace("{{verificationCode5}}", verificationCode.substring(5, 6));
             
             MimeMessage  message = emailSender.createMimeMessage();
             MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
             helper.setTo(to);
             helper.setSubject(subject);
             helper.setText(htmlContent,true);
            emailSender.send(message);
        } catch (Exception ex) {
            // 이메일 전송 실패 시 예외 처리
            throw new RuntimeException("이메일 전송에 실패했습니다.", ex);
        }
//        catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
    }
}
