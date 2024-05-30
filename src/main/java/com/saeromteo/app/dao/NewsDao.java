package com.saeromteo.app.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.news.NewsDto.NewsRequest;
import com.saeromteo.app.dto.news.NewsDto.NewsResponse;

@Repository
public class NewsDao {

	public List<NewsResponse> readAll() {
		// TODO Auto-generated method stub
		return null;
	}

	public NewsResponse readById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<NewsResponse> readByCheck(boolean check) {
		// TODO Auto-generated method stub
		return null;
	}

	public int updateNews(NewsRequest newsDto) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int deleteNews(int id) {
		// TODO Auto-generated method stub
		return 0;
	}
}
