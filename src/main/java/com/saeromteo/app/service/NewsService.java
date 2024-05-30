package com.saeromteo.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.NewsDao;
import com.saeromteo.app.dto.news.NewsDto.NewsRequest;
import com.saeromteo.app.dto.news.NewsDto.NewsResponse;

@Service
public class NewsService {
	
	@Autowired
	NewsDao newsDao;
	
	// Read
	public List<NewsResponse> readAll() {
		return newsDao.readAll();
	}
	
	public NewsResponse readById(int id) {
		return newsDao.readById(id);
	}
	
	public List<NewsResponse> readByCheck(boolean check) {
		return newsDao.readByCheck(check);
	}
	
	// Update
	public int updateNews(NewsRequest newsDto) {
		return newsDao.updateNews(newsDto);
	}
	
	// Delete
	public int deleteNews(int id) {
		return newsDao.deleteNews(id);
	}
	
}
