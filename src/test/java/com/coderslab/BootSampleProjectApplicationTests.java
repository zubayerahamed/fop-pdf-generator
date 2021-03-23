package com.coderslab;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.junit.Test;


public class BootSampleProjectApplicationTests {

	@Test
	public void contextLoads() throws ParseException {

		String dateString = "2021-04";

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		Date date = sdf.parse(dateString);
		Calendar currentMonth = Calendar.getInstance();
		Calendar nextMonth = Calendar.getInstance();
		nextMonth.add(Calendar.MONTH, 1);
		Calendar actualMonth = Calendar.getInstance();
		actualMonth.setTime(date);

		if(currentMonth.get(Calendar.YEAR) == actualMonth.get(Calendar.YEAR)) {
			if((currentMonth.get(Calendar.MONTH) == actualMonth.get(Calendar.MONTH)) || (nextMonth.get(Calendar.MONTH) == actualMonth.get(Calendar.MONTH))) {
				System.out.println(true);
			}
		}

	}

}
