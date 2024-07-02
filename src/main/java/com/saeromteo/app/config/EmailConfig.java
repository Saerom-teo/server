package com.saeromteo.app.config;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
@PropertySource("classpath:security.properties")
public class EmailConfig {

    // Gmail SMTP 서버를 사용하기 위한 비밀 키 (앱 비밀번호)
    @Value("${google.smtp.key}")
    private String key;

    /**
     * JavaMailSender 빈을 생성합니다.
     * 
     * @return JavaMailSender 인스턴스
     */
    @Bean
    public JavaMailSender javaMailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        // SMTP 서버 호스트 설정
        mailSender.setHost("smtp.gmail.com");
        // SMTP 서버 포트 설정
        mailSender.setPort(587);
        // Gmail 계정 사용자 이름 설정
        mailSender.setUsername("kimsh142536@gmail.com");
        // Gmail 앱 비밀번호 설정
        mailSender.setPassword(key);
        
        // JavaMailSender 설정
        Properties props = mailSender.getJavaMailProperties();
        // SMTP 프로토콜 설정
        props.put("mail.transport.protocol", "smtp");
        // SMTP 인증 사용 설정
        props.put("mail.smtp.auth", "true");
        // TLS 사용 설정
        props.put("mail.smtp.starttls.enable", "true");
        // 디버그 모드 활성화
        props.put("mail.debug", "true");

        return mailSender;
    }
}
