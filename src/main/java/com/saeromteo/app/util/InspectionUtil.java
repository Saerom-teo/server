package com.saeromteo.app.util;

import java.util.concurrent.CompletableFuture;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.saeromteo.app.model.collection.AiDto.PredictRequest;
import com.saeromteo.app.model.collection.AiDto.PredictResponse;

@Component
public class InspectionUtil {
	
	private final RestTemplate restTemplate;
	
	@Autowired
	public InspectionUtil(RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
	}
	
	@Async
    public CompletableFuture<PredictResponse> postDataToApi(PredictRequest requestData) {
        String url = "http://122.128.54.136:8000/api/predict/test";
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");

        HttpEntity<PredictRequest> request = new HttpEntity<>(requestData, headers);
        ResponseEntity<PredictResponse> response = restTemplate.exchange(url, HttpMethod.POST, request,
                PredictResponse.class);

        return CompletableFuture.completedFuture(response.getBody());
    }
}
