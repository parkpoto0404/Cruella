package com.cl.cruella.service;

import java.util.List;
import java.util.Map;

import com.cl.cruella.dto.CalendarDto;

public interface CalendarService {

	// 일정 목록 불러오기
	List<CalendarDto> selectCalendarList(Map<String, String> map);
	// 일정 추가하기
	int insertCalendar(CalendarDto c);
	// 일정 수정하기
	int updateCalendar(CalendarDto c);
	// 일정 삭제하기
	int deleteCalender(CalendarDto c);
	
}
