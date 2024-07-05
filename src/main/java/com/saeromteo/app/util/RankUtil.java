package com.saeromteo.app.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.saeromteo.app.dao.point.PointDao;

@Component
public class RankUtil {
	
	@Autowired
	PointDao pointDao;
	
	public String calcRank(int userId) {
		int totalPoint = pointDao.readEarnedTotalByUserId(userId);
		
		if (totalPoint >= 1000 && totalPoint < 3000) {
			return "사과";
		} else if (totalPoint >= 3000 && totalPoint < 5000) {
			return "황금사과";
		} else if (totalPoint >= 5000) {
			return "무지개사과";
		} else {
			return "풋사과";
		}
		
	}
	
	public String getRankImage(String rank) {
		
		if (rank.equals("사과")) {
			return "static/icon/apple-rank2.svg";
		} else if (rank.equals("황금사과")) {
			return "static/icon/apple-rank3.svg";
		} else if (rank.equals("무지개사과")) {
			return "static/icon/apple-rank4.svg";
		} else {
			return "static/icon/apple-rank1.svg";			
		}
		
	}
}
