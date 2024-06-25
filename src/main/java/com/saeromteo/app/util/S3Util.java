package com.saeromteo.app.util;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.saeromteo.app.config.S3Config;

@Component
public class S3Util {

	private final AmazonS3 amazonS3Client;
	private final S3Config s3Config;

	@Autowired
	public S3Util(AmazonS3 amazonS3Client, S3Config s3Config) {
		this.amazonS3Client = amazonS3Client;
		this.s3Config = s3Config;
	}

	public String uploadFile(MultipartFile file, String type)  {
		if (file == null || file.getOriginalFilename() == null) {
			throw new IllegalArgumentException("파일이 null이거나 파일명이 null입니다.");
		}

		String bucketName = s3Config.getBucketName();
		String originalFilename = file.getOriginalFilename();
		String fileExtension = "";

		if (originalFilename != null) {
			int dotIndex = originalFilename.lastIndexOf('.');
			if (dotIndex >= 0) {
				fileExtension = originalFilename.substring(dotIndex);
			}
		}

		String fileName = type + "/" + System.currentTimeMillis() + fileExtension;

		ObjectMetadata metadata = new ObjectMetadata();
		metadata.setContentLength(file.getSize());
		metadata.setContentType(file.getContentType());

		try {
			amazonS3Client.putObject(bucketName, fileName, file.getInputStream(), metadata);
		} catch (AmazonServiceException e) {
			e.printStackTrace();
		} catch (SdkClientException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return amazonS3Client.getUrl(bucketName, fileName).toString();
	}
}
