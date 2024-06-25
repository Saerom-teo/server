package com.saeromteo.app.dao.news;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.news.NewsDto.NewsRequest;
import com.saeromteo.app.dto.news.NewsDto.NewsResponse;

@Repository
public class NewsDao {
	
	private final SqlSessionTemplate sqlSession;
    private String namespace = "com.saeromteo.news.";

    @Autowired
    public NewsDao(@Qualifier("newsSqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }
	

	// Read
	public List<NewsResponse> readAll() {
		List<NewsResponse> newsList = sqlSession.selectList(namespace + "readAll");
		return newsList;
	}

	public NewsResponse readById(Integer newsId) {
		NewsResponse news = sqlSession.selectOne(namespace + "readById", newsId);
		return news;
	}

	public List<NewsResponse> readByCheck(boolean newsCheck) {
		List<NewsResponse> newsList = sqlSession.selectList(namespace + "readByCheck", newsCheck);
		return newsList;
	}
	
	public List<NewsResponse> readFour() {
		List<NewsResponse> newsList = sqlSession.selectList(namespace + "readFour");
		return newsList;
	}
	
	public List<NewsResponse> readSearch(String keyword) {
		List<NewsResponse> newsList = sqlSession.selectList(namespace + "readSearch", keyword);
		return newsList;
	}
	
	public String readUpdateDate() {
		return sqlSession.selectOne(namespace + "readUpdateDate");
	}
	
	// Update
	public int updateNews(NewsRequest newsDto) {
		int result = sqlSession.update(namespace+"updateNews", newsDto);
		return result;
	}

	// Delete
	public int deleteNews(Integer newsId) {
		int result = sqlSession.delete(namespace+"deleteNews", newsId);
		return result;
	}
	
}
