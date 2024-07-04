package com.saeromteo.app.model.point;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.sql.Timestamp;

@Data
public class PointEntity {

    @ApiModelProperty(notes = "포인트 ID", example = "1", required = true)
    private int pointId;

    @ApiModelProperty(notes = "발행 날짜", example = "2024-06-01", required = false)
    private Timestamp dateIssued;

    @ApiModelProperty(notes = "포인트 타입", example = "earned", required = true)
    private String type;

    @ApiModelProperty(notes = "포인트 금액", example = "100", required = true)
    private int amount;

    @ApiModelProperty(notes = "적립 소스", example = "referral", required = false)
    private String earningSource;

    @ApiModelProperty(notes = "사용 소스", example = "purchase", required = false)
    private String spendingSource;

    @ApiModelProperty(notes = "유저 ID", example = "1", required = true)
    private int userId;

    @ApiModelProperty(notes = "주문 코드", example = "ORD123456", required = false)
    private String orderCode;

    @ApiModelProperty(notes = "코멘트", example = "First purchase bonus", required = false)
    private String comment;
    
    private String userRealName;
}
