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

	public List<NewsResponse> readAll() {
		List<NewsResponse> newsList = sqlSession.selectList(namespace + "readAll");
		return newsList;
	}

	public NewsResponse readById(int id) {
		NewsResponse news = sqlSession.selectOne(namespace + "readById", id);
		return news;
	}

	public List<NewsResponse> readByCheck(boolean check) {
		List<NewsResponse> newsList = sqlSession.selectList(namespace + "readByCheck", check);
		return newsList;
	}

	public int updateNews(NewsRequest newsDto) {
		int result = sqlSession.update(namespace+"updateNews", newsDto);
		return result;
	}

	public int deleteNews(int id) {
		int result = sqlSession.delete(namespace+"deleteNews", id);
		return result;
	}
	
}
