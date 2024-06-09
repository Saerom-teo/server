package com.saeromteo.app.controller.collection;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.dto.envdata.EnvironmentDataDto.EnvDataRequest;
import com.saeromteo.app.dto.envdata.EnvironmentDataDto.EnvDataResponse;
import com.saeromteo.app.model.collection.CollectionDto;
import com.saeromteo.app.model.collection.CollectionEntity;
import com.saeromteo.app.service.collection.CollectionService;
import com.saeromteo.app.service.envdata.EnvDataService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

@RestController
@RequestMapping("/collection")
@Api(tags = "Collection Management")
public class CollectionController {

	@Autowired
	CollectionService collectionService;

	@GetMapping("/test")
	@ApiOperation(value = "my test", notes = "testtest")
	public String test() {
		return "test";
	}

	@PostMapping("/insert")
	@ApiOperation(value = "수거 등록", notes = "수거 정보를 등록한다.")
	public String insertCollection(@RequestBody CollectionEntity collectionEntity) {
		int result = collectionService.insertCollection(collectionEntity);
		return result + "건 입력됨";
	}

	@GetMapping(value = "/read-all", produces = "application/json")
	@ApiOperation(value = "수거목록 조회", notes = "전체 수거내역을 조회한다.")
	public List<CollectionEntity> readAll() {
		List<CollectionEntity> collectionList = collectionService.readAll();
		return collectionList;
	}

	@GetMapping("/read-by-user/{userId}")
	@ApiOperation(value = "사용자별 수거내역 조회", notes = "사용자별 수거내역을 조회한다.")
	public List<CollectionEntity> readByUser(
			@ApiParam(value = "사용자 ID", required = true) @PathVariable("userId") int userId) {
		List<CollectionEntity> collectionList = collectionService.readByUserId(userId);
		return collectionList;
	}

	@PutMapping(value = "/update", consumes = "application/json", produces = "text/plain;charset=UTF-8")
	@ApiOperation(value = "수거 수정", notes = "수거 정보를 수정한다.")
	public String updateCollection(@RequestBody CollectionEntity collectionEntity) {
		int result = collectionService.updateCollection(collectionEntity);
		return result + "건 수정됨";
	}

	@DeleteMapping("/delete/{collectionId}")
	@ApiOperation(value = "수거 삭제", notes = "수거 정보를 삭제한다.")
	public String deleteCollection(@PathVariable("collectionId") String collectionId) {
		int result = collectionService.deleteCollection(collectionId);
		return result + "건 삭제됨";
	}

}
