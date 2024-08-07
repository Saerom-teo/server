package com.saeromteo.app.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;

public class DateUtil {

	public static Date getUtilDate(String d) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date result = null;
		try {
			result = sdf.parse(d);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public static java.sql.Date getSQLDate(String d) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.sql.Date result = null;
		try {
			Date d2 = sdf.parse(d);
			result = new java.sql.Date(d2.getTime());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public static Timestamp localDateTimeToTimeStamp(LocalDateTime ldt) {
		return Timestamp.valueOf(ldt);
	}

	public static LocalDateTime timeStampToLocalDateTime(Timestamp ts) {
		return ts.toLocalDateTime();
	}

}
