package com.cl.cruella.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.cl.cruella.dto.AlertDto;
import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.service.ChatServiceImpl;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MvcController {
	
	
	private final ChatServiceImpl chatServiceImpl;
	
	@GetMapping("/")
	public String maingPage(HttpSession session) {
		
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		if(loginUser != null) {
			return "/dashboard";
		}else {
			return "member/loginPage";
		}
		
	}

	@GetMapping("/dashboard")
	public void testMainPage() {}
}
