package com.saeromteo.app.service.order;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.model.GetObjectRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Properties;

public class awstest{

    public static void main(String[] args) throws IOException {
        // aws.properties 파일에서 AWS 자격 증명 로드
        Properties properties = new Properties();
        try (InputStream input = awstest.class.getClassLoader().getResourceAsStream("aws.properties")) {
            if (input == null) {
                System.err.println("Unable to find aws.properties file!");
                return;
            }
            properties.load(input);
        }

        // AWS 자격 증명 설정
        String accessKey = properties.getProperty("cloud.aws.credentials.access-key");
        String secretKey = properties.getProperty("cloud.aws.credentials.secret-key");
        String region = properties.getProperty("cloud.aws.region.static");
        String bucketName = properties.getProperty("cloud.aws.s3.bucket-name");

        BasicAWSCredentials awsCredentials = new BasicAWSCredentials(accessKey, secretKey);

        // AmazonS3 클라이언트 생성
        AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
                                .withCredentials(new AWSStaticCredentialsProvider(awsCredentials))
                                .withRegion(region)
                                .build();

        // 가져올 파일 이름
        String fileName = "EmpDTO.java";

        // S3 버킷에서 파일 가져오기
        S3Object object = s3Client.getObject(new GetObjectRequest(bucketName, fileName));

        // 파일 내용 읽기
        InputStream inputStream = object.getObjectContent();
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
        String line;
        while ((line = reader.readLine()) != null) {
            System.out.println(line);
        }

        // 자원 정리
        reader.close();
        inputStream.close();
        object.close();
    }
}
