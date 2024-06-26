package com.saeromteo.app.model.collection;

import java.util.List;

import lombok.Getter;
import lombok.Setter;


public class AiDto {

	@Setter
	@Getter
	static public class PredictRequest {
		private String modelName;
	    private List<String> images;
	}
	
	@Setter
	@Getter
	static public class PredictResponse {
		private String result;
	    private List<String> images;
	}
}
