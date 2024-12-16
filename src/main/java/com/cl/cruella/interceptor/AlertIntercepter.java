package com.cl.cruella.interceptor;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.cl.cruella.dto.AlertDto;
import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.service.ChatServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class AlertIntercepter implements HandlerInterceptor{
	
	 private final ChatServiceImpl chatServiceImpl;
	 
	 
	 
	  @Override
	    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	        HttpSession session = request.getSession();
	        if (session != null) {
	            MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
	            if (loginUser != null) {
	                List<AlertDto> alert = chatServiceImpl.alertList(loginUser);
	                //int count = chatServiceImpl.countAlert(loginUser);
	                session.setAttribute("alert", alert);
	                //session.setAttribute("count", count);
	            }
	        }
	        return true; // 요청을 계속 진행하도록 설정
	    }
	 
	 
	 
	 
	 
	 

}
