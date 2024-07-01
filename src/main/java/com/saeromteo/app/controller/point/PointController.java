package com.saeromteo.app.controller.point;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.model.point.PointDto.PointResponse;
import com.saeromteo.app.model.point.PointEntity;
import com.saeromteo.app.service.point.PointService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/api/point")
@Api(tags = "Point Management")
public class PointController {

	@Autowired
	PointService pointService;

	
	@GetMapping("/read-by-user")
	@ApiOperation(value = "사용자별 포인트 내역 조회", notes = "사용자별 포인트 내역을 조회한다.")
	public List<PointResponse> readByUser(@RequestParam int page) {
		System.out.println("=====================");
		System.out.println(page);
		System.out.println("=====================");
//		List<PointResponse> pointResponses = pointService.getPointsByUserId(1, page, 10);
		return null;
	}
	
	// ==================================
	
	@PostMapping("/insert")
	@ApiOperation(value = "포인트 등록", notes = "포인트 정보를 등록한다.")
	public String insertCollection(@RequestBody PointEntity pointEntity) {
		int result = pointService.insert(pointEntity);
		return result + "건 입력됨";
	}

	@GetMapping(value = "/read-all", produces = "application/json")
	@ApiOperation(value = "포인트목록 조회", notes = "전체 포인트 내역을 조회한다.")
	public List<PointEntity> readAll() {
		List<PointEntity> pointList = pointService.readAll();
		return pointList;
	}

//	@GetMapping("/read-by-user/{userId}")
//	@ApiOperation(value = "사용자별 포인트 내역 조회", notes = "사용자별 포인트 내역을 조회한다.")
//	public List<PointEntity> readByUser(
//			@ApiParam(value = "사용자 ID", required = true) @PathVariable("userId") int userId) {
//		List<PointEntity> pointList = pointService.readByUserId(userId);
//		return pointList;
//	}

	@PutMapping(value = "/update", consumes = "application/json", produces = "text/plain;charset=UTF-8")
	@ApiOperation(value = "포인트 내역 수정", notes = "포인트 내역을 수정한다.")
	public String updateCollection(@RequestBody PointEntity pointEntity) {
		int result = pointService.update(pointEntity);
		return result + "건 수정됨";
	}

	@DeleteMapping("/delete/{pointId}")
	@ApiOperation(value = "포인트 내역 삭제", notes = "포인트 내역을 삭제한다.")
	public String deleteCollection(@PathVariable("pointId") String pointId) {
		int result = pointService.delete(pointId);
		return result + "건 삭제됨";
	}

}
