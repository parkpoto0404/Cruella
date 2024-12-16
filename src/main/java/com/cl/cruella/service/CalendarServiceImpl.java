package com.cl.cruella.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.cl.cruella.dao.CalendarDao;
import com.cl.cruella.dto.CalendarDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CalendarServiceImpl implements CalendarService {

	private final CalendarDao calendarDao;
	
	@Override
	public List<CalendarDto> selectCalendarList(Map<String, String> map) {
		return calendarDao.selectCalenderList(map);
	}

	@Override
	public int insertCalendar(CalendarDto c) {
		return calendarDao.insertCalendar(c);
	}

	@Override
	public int updateCalendar(CalendarDto c) {
		return calendarDao.updateCalendar(c);
	}

	public int deleteCalender(CalendarDto c) {
		return calendarDao.deleteCalender(c);
	}
}
