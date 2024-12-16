package com.cl.cruella.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.cl.cruella.dto.CalendarDto;
import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.dto.WorkLogDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Repository
@RequiredArgsConstructor
public class WorkLogDao {

	private final SqlSessionTemplate sqlSession;

	
	public int clockIn(WorkLogDto workLog) {

		return sqlSession.insert("wlMapper.clockIn", workLog);
	}
	
	public String selectClockInTime(String memNo) {
		return sqlSession.selectOne("wlMapper.selectClockInTime", memNo);
	}
	
	public int clockOut(WorkLogDto workLog) {
		return sqlSession.update("wlMapper.clockOut", workLog);
	}
	
	public List<CalendarDto> loadWorkLog(String memNo) {
		return sqlSession.selectList("wlMapper.loadWorkLog", memNo);
	}
	
	public List<WorkLogDto> allWorkTime(String memNo) {
		return sqlSession.selectList("wlMapper.allWorkTime", memNo);
	}
	
	public void updateAbsences() {
		sqlSession.update("wlMapper.updateAbsences");
	}
	
	public void insertAbsences() {
		sqlSession.insert("wlMapper.insertAbsences");
	}

	public List<WorkLogDto> checkinrecordview(Map<String,Object> wlDate) {
		
		
		return sqlSession.selectList("wlMapper.checkinrecordview", wlDate);
	}

	public List<WorkLogDto> checkinrecordview2(Map<String, Object> wlDate) {
		return sqlSession.selectList("wlMapper.checkinrecordview", wlDate);
	}


	
}
