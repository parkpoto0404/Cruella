package com.cl.cruella.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.cl.cruella.dto.ChatDto;
import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.service.ChatServiceImpl;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class ChatEchoHandler2 extends TextWebSocketHandler{
	
	
	private List<WebSocketSession> list = new ArrayList<>();

	
	/**
	 * 1) afterConnectionEstablished : 웹소켓에 클라이언트가 연결되었을 때 처리할 내용 정의
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		list.add(session);
		
	}

	
	/**
	 * 2) handlerMessage : 웹소켓으로 데이터(텍스트, 파일 등)가 전송되었을 경우 처리할 내용 정의
	 */
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		
		
	
		
	}
	
	/*
	 * 3) afterConnectionClosed : 웹소켓에 클라이언트가 연결이 끊겼을 때 처리할 내용 정의
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		
		 list.remove(session);
		
		
	}
	
	
	
	public List<WebSocketSession> getSessionList() {
		return list;
	}
	
	
	
	
	
	

}
