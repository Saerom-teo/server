package com.saeromteo.app.controller.collection;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.model.collection.CollectionDto;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

@RestController
@RequestMapping("/collection")
@Api(tags = "Collection Management")
public class CollectionController {

	@GetMapping("/test")
	@ApiOperation(value = "my test", notes = "testtest")
	public String test() {
		return "test";
	}

	@PostMapping("/insert-collection")
	@ApiOperation(value = "수거 등록", notes = "수거 정보를 등록한다.")
	public String insertCollection(@RequestBody CollectionDto collectionDto) {
		return "insertCollection";
	}

	@GetMapping("/read-all")
	@ApiOperation(value = "수거목록 조회", notes = "전체 수거내역을 조회한다.")
	public String readAll() {
		return "readAll";
	}

	@GetMapping("/read-by-user/{userId}")
	@ApiOperation(value = "사용자별 수거내역 조회", notes = "사용자별 수거내역을 조회한다.")
	public int readByUser(@ApiParam(value = "사용자 ID", required = true) @PathVariable("userId") int userId) {
		return userId;
	}

	@PutMapping("/update-collection")
	@ApiOperation(value = "수거 수정", notes = "수거 정보를 수정한다.")
	public String updateCollection() {
		return "updateCollection";
	}

	@DeleteMapping("/delete-collection")
	@ApiOperation(value = "수거 삭제", notes = "수거 정보를 삭제한다.")
	public String deleteCollection() {
		return "deleteCollection";
	}
}
