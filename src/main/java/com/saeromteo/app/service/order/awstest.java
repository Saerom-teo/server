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
        // aws.properties 
        Properties properties = new Properties();
        try (InputStream input = awstest.class.getClassLoader().getResourceAsStream("aws.properties")) {
            if (input == null) {
                System.err.println("Unable to find aws.properties file!");
                return;
            }
            properties.load(input);
        }

        // AWS 
        String accessKey = properties.getProperty("cloud.aws.credentials.access-key");
        String secretKey = properties.getProperty("cloud.aws.credentials.secret-key");
        String region = properties.getProperty("cloud.aws.region.static");
        String bucketName = properties.getProperty("cloud.aws.s3.bucket-name");

        BasicAWSCredentials awsCredentials = new BasicAWSCredentials(accessKey, secretKey);

        // AmazonS3
        AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
                                .withCredentials(new AWSStaticCredentialsProvider(awsCredentials))
                                .withRegion(region)
                                .build();

        // 
        String fileName = "EmpDTO.java";

     
        S3Object object = s3Client.getObject(new GetObjectRequest(bucketName, fileName));


        InputStream inputStream = object.getObjectContent();
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
        String line;
        while ((line = reader.readLine()) != null) {
            System.out.println(line);
        }


        reader.close();
        inputStream.close();
        object.close();
    }
}
