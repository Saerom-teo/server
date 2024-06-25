package com.saeromteo.app.model.collection;

import java.sql.Date;
import java.sql.Timestamp;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CollectionEntity {

    @ApiModelProperty(notes = "수거번호", example = "C0604001", required = true)
    private String collectionId;

    @ApiModelProperty(notes = "요청 날짜", example = "2024-01-01 10:00:00")
    private Timestamp requestedDate;

    @ApiModelProperty(notes = "승인 날짜", example = "2024-01-02 12:00:00")
    private Timestamp approvedDate;

    @ApiModelProperty(notes = "완료 날짜", example = "2024-01-05 15:00:00")
    private Timestamp completedDate;

    @ApiModelProperty(notes = "무게", example = "10.5")
    private Float weight;

    @ApiModelProperty(notes = "이미지 1 주소", example = "https://images.com/image1.jpg")
    private String image1;

    @ApiModelProperty(notes = "이미지 2 주소", example = "https://images.com/image2.jpg")
    private String image2;

    @ApiModelProperty(notes = "이미지 3 주소", example = "https://images.com/image3.jpg")
    private String image3;

    @ApiModelProperty(notes = "이미지 4 주소", example = "https://images.com/image4.jpg")
    private String image4;

    @ApiModelProperty(notes = "유저 ID", example = "34", required = true)
    private Integer userId;

}
