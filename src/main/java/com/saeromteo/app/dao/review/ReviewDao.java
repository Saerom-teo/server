package com.saeromteo.app.dao.review;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.review.ReviewDto.ReviewRequest;
import com.saeromteo.app.dto.review.ReviewDto.ReviewResponse;

@Repository
public class ReviewDao{
	
	private final SqlSessionTemplate sqlSession;
	private String namespace = "com.saeromteo.review.";
	
	@Autowired
	public ReviewDao(@Qualifier("reviewSqlSessionTemplate")SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	//Read
	public List<ReviewResponse> readProductReview(String productCode) {
		return sqlSession.selectList(namespace + "readProductReview", productCode);
	}

	public ReviewResponse readDetail(int reviewId) {
		return sqlSession.selectOne(namespace + "readDetail", reviewId);
	}

	public List<ReviewResponse> readUserReview(int userCode) {
		return sqlSession.selectList(namespace + "readUserReview", userCode);
	}
	
	public List<ReviewResponse> readScore(int reviewScore){
		return sqlSession.selectList(namespace + "readScore", reviewScore);
	}
	//Create
	public int insertReivew(ReviewRequest reviewId) {
		return sqlSession.insert(namespace + "insertReview", reviewId);
	}

	//Update
	public int updateReview(ReviewRequest reviewId) {
		return sqlSession.update(namespace + "updateReview", reviewId);
	}

	//Delete
	public int deleteReview(int reviewId) {
		return sqlSession.delete(namespace + "deleteReview", reviewId);
	}
	
}
