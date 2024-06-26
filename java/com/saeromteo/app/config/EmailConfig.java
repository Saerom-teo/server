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
	
	@Value("${google.smtp.key}")
	private String key;

    @Bean
    public JavaMailSender javaMailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.gmail.com");
        mailSender.setPort(587);
        mailSender.setUsername("kimsh142536@gmail.com"); // Gmail 계정
        mailSender.setPassword(key); // Gmail 앱 비밀번호
        
        Properties props = mailSender.getJavaMailProperties();
        
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.debug", "true"); // 디버그 모드 활성화

        return mailSender;
    }
}
