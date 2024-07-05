package com.saeromteo.app.service.question;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.saeromteo.app.util.S3Util;

@Service
public class FileService {

    private final S3Util s3Util;

    @Autowired
    public FileService(S3Util s3Util) {
        this.s3Util = s3Util;
    }

    public String uploadImage(MultipartFile image) {
        if (image.isEmpty()) {
            throw new IllegalArgumentException("업로드된 이미지가 없습니다.");
        }

        try {
            // S3에 파일 업로드
            return s3Util.uploadFile(image, "images"); // "images"는 파일 타입으로 폴더를 구분하기 위해 사용
        } catch (Exception e) {
            throw new RuntimeException("파일 업로드 중 오류가 발생했습니다.", e);
        }
    }
}
