package com.saeromteo.app.service.news;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.news.NewsDao;
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
	
	public NewsResponse readById(Integer newsId) {
		return newsDao.readById(newsId);
	}
	
	public List<NewsResponse> readByCheck(boolean newsCheck) {
		return newsDao.readByCheck(newsCheck);
	}
	
	public List<NewsResponse> readFour() {
		return newsDao.readFour();
	}
	
	// Update
	public int updateNews(NewsRequest newsDto) {
		return newsDao.updateNews(newsDto);
	}
	
	// Delete
	public int deleteNews(Integer newsId) {
		return newsDao.deleteNews(newsId);
	}
	
}
