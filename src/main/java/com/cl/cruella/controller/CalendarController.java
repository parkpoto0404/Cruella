package com.cl.cruella.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cl.cruella.dto.CalendarDto;
import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.service.CalendarServiceImpl;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Controller
@RequestMapping("/calendar")
@Slf4j

public class CalendarController {

	private final CalendarServiceImpl calendarServiceImpl;
	
	
	// 캘린더 조회
	@GetMapping("/calendar.do")
	public String selectCalenderList(String company, Model model, HttpSession session) {
		
		Map<String, String> map = new HashMap<>();
		map.put("deptCode", ((MemberDto)session.getAttribute("loginUser")).getDeptCode());
		map.put("memNo", ((MemberDto)session.getAttribute("loginUser")).getMemNo());

		map.put("company", "T");
		map.put("team", "T");
		map.put("personal", "T");
		
		List<CalendarDto> list = calendarServiceImpl.selectCalendarList(map);
		
		model.addAttribute("list", list);
		
		log.debug("결과값{}", list);
		
		
		return "/calendar/calendar"; // 이 jsp를 실행 할 때 위에있는 list를 가지고 간다. 그래서 jsp 에서 list를 쓸 수 있음
	}
	
	
	
	// 캘린더 조회
		@ResponseBody
		@GetMapping("/calendar2.do")
		public List<CalendarDto> selectCalenderList2(
				@RequestParam String company, 
				@RequestParam String team,
				@RequestParam String personal,
				Model model, 
				HttpSession session) {
			
			Map<String, String> map = new HashMap<>();
			
			map.put("deptCode", ((MemberDto)session.getAttribute("loginUser")).getDeptCode());
			map.put("memNo", ((MemberDto)session.getAttribute("loginUser")).getMemNo());
			map.put("company", company);
			map.put("team", team);
			map.put("personal", personal);
			
			//System.out.println(company);
			
			List<CalendarDto> list = new ArrayList<>();
			
			if(company.equals("F") && team.equals("F") && personal.equals("F")) {
				return list;
			}else {
				list = calendarServiceImpl.selectCalendarList(map);

			}
			
			
			return list; // 이 jsp를 실행 할 때 위에있는 list를 가지고 간다. 그래서 jsp 에서 list를 쓸 수 있음
		}
	
	
	
	
	
	
	// 캘린더 추가
	@ResponseBody
	@PostMapping("/insertCalendar.do")
	public int insertCalendar(@RequestBody CalendarDto c) {
//		log.debug("log{}",c);
		int result = calendarServiceImpl.insertCalendar(c);
		return result;
	}
	
	
	// 캘린더 수정
	@ResponseBody
	@GetMapping(value="/updateCalendar.do", produces="application/json") // produces 쓰는 이유 : 값을 돌려줄 때 어쩌고 타입으로 필요한... 영욱님이 얘기하심..
	public int updateCalendar(CalendarDto c) {
		//log.debug("###### controller 실행 c: {}", c);
		int result = calendarServiceImpl.updateCalendar(c);
		return result;
	}
	
	
	// 캘린더 삭제
	
	@ResponseBody
	@GetMapping("/deleteCalendar.do")
	public int deleteCalender(CalendarDto c) {
		int result = calendarServiceImpl.deleteCalender(c);
		return result;
	}
	
	
	
	
	
	
}
