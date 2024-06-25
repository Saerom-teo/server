package com.saeromteo.app.controller.news;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.dto.news.NewsDto.NewsRequest;
import com.saeromteo.app.dto.news.NewsDto.NewsResponse;
import com.saeromteo.app.service.news.NewsService;

@RestController
@RequestMapping("/news/api")
public class NewsApiController {

	@Autowired
	NewsService newsService;

	// Read
	@GetMapping(value = "/readAll", produces = "application/json")
	public List<NewsResponse> readAll() {
		List<NewsResponse> newsList = newsService.readAll();
		return newsList;
	}

	@GetMapping(value = "/readById/{newsId}", produces = "application/json")
	public NewsResponse readById(@PathVariable("newsId") Integer newsId) {
		NewsResponse news = newsService.readById(newsId);
		return news;
	}

	@GetMapping(value = "/readByCheck/{newsCheck}", produces = "application/json")
	public List<NewsResponse> readByCheck(@PathVariable("newsId") boolean newsCheck) {
		List<NewsResponse> newsList = newsService.readByCheck(newsCheck);
		return newsList;
	}
	
	@GetMapping(value = "/search/{keyword}", produces = "application/json")
	public List<NewsResponse> readSearch(@PathVariable("keyword") String keyword) {
		List<NewsResponse> newsList = newsService.readSearch(keyword);
		return newsList;
	}

	// Update
	@PutMapping(value = "/updateNews", consumes = "application/json", produces = "text/plain;charset=UTF-8")
	public String updateNews(@RequestBody NewsRequest newsDto) {
		int result = newsService.updateNews(newsDto);
		return result + "건 수정";
	}

	// Delete
	@DeleteMapping(value = "/deleteNews/{newsId}", produces = "text/plain;charset=UTF-8")
	public String deleteNews(@PathVariable("newsId") Integer newsId) {
		int result = newsService.deleteNews(newsId);
		return result + "건 삭제";
	}

}
