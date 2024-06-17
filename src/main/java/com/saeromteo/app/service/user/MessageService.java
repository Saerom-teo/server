package com.saeromteo.app.service.user;
import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Service("messageService")
@PropertySource("classpath:security.properties")
public class MessageService {
    private DefaultMessageService messageService;
    
    @Value("${sms.key}")
    private String smsKey;
    
    @Value("${sms.secret}")
    private String smsSecret;

    @PostConstruct
    public void init() {
        if (smsKey == null || smsKey.isEmpty() || smsSecret == null || smsSecret.isEmpty()) {
            throw new IllegalArgumentException("API key and secret must be provided");
        }
        this.messageService = NurigoApp.INSTANCE.initialize(smsKey, smsSecret, "https://api.coolsms.co.kr");
    }

    public void sendMessage() {
    	//랜덤 번호 6자리 생성하고 , 
    	//그거 controller 로 보내고 , 
    	//model 저장후 프론트로 넘겨주고 거기서 맞는지 안맞는지 판단 .
    	
        Message message = new Message();
        message.setFrom("15881588"); // 보내는 사람 번호
        message.setTo("01082408896"); // 받는 사람 번호
        message.setText("SMS Test");
        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
        System.out.println(response);
    }
}
