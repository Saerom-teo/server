package com.saeromteo.app.dao.review;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.review.ReviewDto.ReviewRequest;
import com.saeromteo.app.dto.review.ReviewDto.ReviewResponse;

@Repository
public abstract class ReviewDao implements ReviewInterface{
	
//	@Autowired
//	SqlSession sqlSession;
//	
//	String namespace = "com.saeromteo.app.review";
//
//	//Read
//	public List<ReviewResponse> readProductReview(String productCode) {
//		return sqlSession.selectList(namespace + "readProductReview", productCode);
//	}
//
//	public ReviewResponse readDetail(int reviewId) {
//		return sqlSession.selectOne(namespace + "readDetail", reviewId);
//	}
//
//	public List<ReviewResponse> readUserReview(int userCode) {
//		return sqlSession.selectList(namespace + "readUserReview", userCode);
//	}
//	
//	//Create
//	public int insertReivew(ReviewRequest reviewId) {
//		return sqlSession.insert(namespace + "insertReview", reviewId);
//	}
//
//	//Update
//	public int updateReview(ReviewRequest reviewId) {
//		return sqlSession.update(namespace + "updateReview", reviewId);
//	}
//
//	//Delete
//	public int deleteReview(int reviewId) {
//		return sqlSession.delete(namespace + "deleteReview", reviewId);
//	}
	
}
