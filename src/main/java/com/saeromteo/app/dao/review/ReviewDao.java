package com.saeromteo.app.dao.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	public Integer readCountScore(String productCode){
		return sqlSession.selectOne(namespace + "readCountScore", productCode);
	}
	
	public double readAvgScore(String productCode){
		return sqlSession.selectOne(namespace + "readAvgScore", productCode);
	}
	
	public List<ReviewResponse> readByDate(HashMap<String, Integer> map){
		return sqlSession.selectList(namespace + "readByDate", map);
	}
	
	public List<ReviewResponse> readByDateBetween(HashMap<String, Object> map){
		return sqlSession.selectList(namespace + "readByDateBetween", map);
	}
	
	//Create
	public int insertReview(ReviewRequest reviewId) {
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
	
	public List<ReviewResponse> readAllPaged(int offset, int size) {
        Map<String, Integer> params = new HashMap<>();
        params.put("offset", offset); 
        params.put("size", size);
        return sqlSession.selectList(namespace + "readAllPaged", params);
    }
	
}
