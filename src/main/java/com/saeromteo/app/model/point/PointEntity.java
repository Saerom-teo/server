package com.saeromteo.app.model.point;

import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PointEntity {

	@ApiModelProperty(notes = "포인트 ID", example = "P001", required = true)
	private String pointId;

	@ApiModelProperty(notes = "발행 날짜", example = "2024-06-01", required = true)
	private java.sql.Date dateIssued;

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

	public String getPointId() {
		return pointId;
	}

	public void setPointId(String pointId) {
		this.pointId = pointId;
	}

	public java.sql.Date getDateIssued() {
		return dateIssued;
	}

	public void setDateIssued(java.sql.Date dateIssued) {
		this.dateIssued = dateIssued;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getEarningSource() {
		return earningSource;
	}

	public void setEarningSource(String earningSource) {
		this.earningSource = earningSource;
	}

	public String getSpendingSource() {
		return spendingSource;
	}

	public void setSpendingSource(String spendingSource) {
		this.spendingSource = spendingSource;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

}
