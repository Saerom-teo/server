package com.saeromteo.app.model.collection;

import java.sql.Date;

import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CollectionEntity {

    @ApiModelProperty(notes = "수거번호", example = "C0604001", required = true)
    private String collectionId;

    @ApiModelProperty(notes = "요청 날짜", example = "2024-01-01")
    private Date requestedDate;

    @ApiModelProperty(notes = "승인 날짜", example = "2024-01-02")
    private Date approvedDate;

    @ApiModelProperty(notes = "완료 날짜", example = "2024-01-05")
    private Date completedDate;

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

	public String getCollectionId() {
		return collectionId;
	}

	public void setCollectionId(String collectionId) {
		this.collectionId = collectionId;
	}

	public Date getRequestedDate() {
		return requestedDate;
	}

	public void setRequestedDate(Date requestedDate) {
		this.requestedDate = requestedDate;
	}

	public Date getApprovedDate() {
		return approvedDate;
	}

	public void setApprovedDate(Date approvedDate) {
		this.approvedDate = approvedDate;
	}

	public Date getCompletedDate() {
		return completedDate;
	}

	public void setCompletedDate(Date completedDate) {
		this.completedDate = completedDate;
	}

	public Float getWeight() {
		return weight;
	}

	public void setWeight(Float weight) {
		this.weight = weight;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getImage2() {
		return image2;
	}

	public void setImage2(String image2) {
		this.image2 = image2;
	}

	public String getImage3() {
		return image3;
	}

	public void setImage3(String image3) {
		this.image3 = image3;
	}

	public String getImage4() {
		return image4;
	}

	public void setImage4(String image4) {
		this.image4 = image4;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}
}
