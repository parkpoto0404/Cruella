package com.cl.cruella.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.cl.cruella.dto.CalendarDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class CalendarDao {

	private final SqlSessionTemplate sqlSession;
	
	public List<CalendarDto> selectCalenderList(Map<String, String> map){
		log.debug("map{}", map);
		return sqlSession.selectList("calendarMapper.selectCalendarList", map); // 쿼리문에서 map 에 담긴 맵 이름값으로 불러오면 됨. ex) deptCode 이렇게 적으면 됨.
	}
	
	public int insertCalendar(CalendarDto c) {
		return sqlSession.insert("calendarMapper.insertCalendar", c);
	}
	
	public int updateCalendar(CalendarDto c) {
		return sqlSession.update("calendarMapper.updateCalendar", c);
	}
	
	public int deleteCalender(CalendarDto c) {
		return sqlSession.delete("calendarMapper.deleteCalender", c);
	}
}
