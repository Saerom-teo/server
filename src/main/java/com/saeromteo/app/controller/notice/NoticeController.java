package com.saeromteo.app.controller.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.saeromteo.app.dto.notice.NoticeDTO.NoticeRequest;
import com.saeromteo.app.dto.notice.NoticeDTO.NoticeResponse;
import com.saeromteo.app.service.notice.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	 @GetMapping(value = "/readAll", produces = "application/json")
	    public String readAll(Model model,
	                          @RequestParam(defaultValue = "1") int page,
	                          @RequestParam(defaultValue = "10") int pageSize,
	                          @RequestParam(name = "filter", required = false, defaultValue = "all") String filter,
	                          @RequestParam(name = "query", required = false, defaultValue = "") String query) {
	        List<NoticeResponse> noticeList;
	        int totalNotices;

	        if ("title".equals(filter) && !query.isEmpty()) {
	            totalNotices = noticeService.getTotalNoticeCountByTitle(query);
	            noticeList = noticeService.findNoticesByTitle(query, page, pageSize);
	        } else if ("content".equals(filter) && !query.isEmpty()) {
	            totalNotices = noticeService.getTotalNoticeCountByContent(query);
	            noticeList = noticeService.findNoticesByContent(query, page, pageSize);
	        } else {
	            totalNotices = noticeService.getTotalNoticeCount();
	            noticeList = noticeService.findAllNotices(page, pageSize);
	        }

	        int totalPages = (int) Math.ceil((double) totalNotices / pageSize);

	        model.addAttribute("noticeList", noticeList);
	        model.addAttribute("currentPage", page);
	        model.addAttribute("totalPages", totalPages);
	        model.addAttribute("filter", filter);
	        model.addAttribute("query", query);

	        return "notice/notice";
	    }
	
	@GetMapping(value = "/readCategory/{noticeCategory}", produces = "application/json")
	public List<NoticeResponse> readCategory(@PathVariable("noticeCategory") String noticeCategory) {
		List<NoticeResponse> noticeList = noticeService.readCategory(noticeCategory);
		return noticeList;
	}
	
	@GetMapping(value = "/readDetail/{noticeId}", produces = "application/json")
	public void readDetail(Model model,@PathVariable("noticeId") Integer noticeId) {
		model.addAttribute("noticeId",noticeId);
	}
	//Insert
	@PostMapping(value = "/insertNotice", produces =  "text/plain;charset=utf-8", consumes = "application/json")
	public String insertNotice(@RequestBody NoticeRequest noticeRequest) {
		int result = noticeService.insertNotice(noticeRequest);
		return result + "건 생성되었습니다.";
	}
	
	//Update
	@PutMapping(value = "/updateNotice", produces = "text/plain;charset=utf-8", consumes = "application/json")
	public String updateNotice(@RequestBody NoticeRequest noticeRequest) {
		int result = noticeService.updateNotice(noticeRequest);
		return result + "건 수정되었습니다.";
	}
	
	//Delete
	@DeleteMapping(value = "/deleteNotice/{noticeNum}", produces =  "text/plain;charset=utf-8")
	public String deleteNotice(@PathVariable("noticeNum") Integer noticeId) {
		int result = noticeService.deleteNotice(noticeId);
		return result + "건 삭제되었습니다.";
	}
}
