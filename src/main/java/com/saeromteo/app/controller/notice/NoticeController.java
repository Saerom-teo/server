package com.saeromteo.app.controller.notice;

import java.util.List;

import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.dto.notice.NoticeDTO.NoticeRequest;
import com.saeromteo.app.dto.notice.NoticeDTO.NoticeResponse;
import com.saeromteo.app.service.notice.NoticeService;

@RestController
@RequestMapping("/notice/api")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	@GetMapping(value = "/searchAll", produces = "application/json")
	public List<NoticeResponse> readAll() {
		List<NoticeResponse> noticeList = noticeService.readAll();
		return noticeList;
	}
	
	@GetMapping(value = "/searchCategory/{noticeCategory}", produces = "application/json")
	public List<NoticeResponse> readCategory(@PathVariable("noticeCategory") String noticeCategory) {
		List<NoticeResponse> noticeList = noticeService.readCategory(noticeCategory);
		return noticeList;
	}
	
	@GetMapping(value = "/searchDetail/{noticeNum}", produces = "application/json")
	public NoticeResponse readDetail(@PathVariable("noticeNum") Integer noticeId) {
		NoticeResponse noticeDetail = noticeService.readDetail(noticeId);
		return noticeDetail;
	}
	//Insert
	@PostMapping(value = "/noticeInsert", produces =  "text/plain;charset=utf-8", consumes = "application/json")
	public String insertNotice(@RequestBody NoticeRequest noticeDto) {
		int result = noticeService.insertNotice(noticeDto);
		return result + "건 생성되었습니다.";
	}
	
	//Update
	@PutMapping(value = "/noticeUpdate", produces = "text/plain;charset=utf-8", consumes = "application/json")
	public String updateNotice(@RequestBody NoticeRequest noticeDto) {
		int result = noticeService.updateNotice(noticeDto);
		return result + "건 수정되었습니다.";
	}
	
	//Delete
	@DeleteMapping(value = "/noticeDelete/{noticeNum}", produces =  "text/plain;charset=utf-8")
	public String deleteNotice(@PathVariable("noticeNum") Integer noticeId) {
		int result = noticeService.deleteNotice(noticeId);
		return result + "건 삭제되었습니다.";
	}
}
