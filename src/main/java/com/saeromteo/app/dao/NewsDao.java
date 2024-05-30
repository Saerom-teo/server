package com.saeromteo.app.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.news.NewsDto.NewsRequest;
import com.saeromteo.app.dto.news.NewsDto.NewsResponse;

@Repository
public class NewsDao {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saeromteo.news.";

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
