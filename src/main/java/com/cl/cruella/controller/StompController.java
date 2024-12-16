package com.cl.cruella.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.dto.MessageDto;
import com.cl.cruella.service.ChatServiceImpl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class StompController {

	
	private final SimpMessagingTemplate template; // 특정 broker로 메시지를 전달
	private final ChatServiceImpl chatserviceImpl;
	
	/*
	@MessageMapping("/chat/enter")
	public void enter(MessageDto message,ChatDto chat,MemberDto m){
		

		message.setMsgContent(m.getMemName() + "님이 채팅방에 입장하였습니다.");
		template.convertAndSend("/sub/chat/chatNo/" + message.getChatNo(), message);
		
	}
	
	@MessageMapping("/chat/message")
	public void message(MessageDto message) {
		log.debug("Message111 : {}",message);
		template.convertAndSend("/sub/chat/chatNo/" + message.getChatNo(), message); // 전달받은 메시지를 여기로 전송
	}
	*/
	
	@MessageMapping("/{chatNo}")
	@SendTo("/sub/{chatNo}")
	public MessageDto message(@DestinationVariable String chatNo,@RequestBody MessageDto messageDto, @RequestBody MemberDto member) throws ParseException {
		
		log.debug("번호허허헣 {}",chatNo);
		if(messageDto.getMsgType().equals("message")) {
			// 채팅방 인원수 확인
			int chatCount = chatserviceImpl.chatCount(messageDto.getChatNo());
			if(chatCount > 0) {
				// 날짜처리
				String isoDate  = messageDto.getMsgRegistDate();
				SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
				isoFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
				Date date = isoFormat.parse(isoDate);
				SimpleDateFormat desiredFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				desiredFormat.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
				String formattedDate = desiredFormat.format(date);
				messageDto.setMsgRegistDate(formattedDate);
				messageDto.setMsgCheck(chatCount-1);
				// 메시지 인서트
				int result = chatserviceImpl.insertMessage(messageDto);
				messageDto.setType("message");
				// 메시지 넘버 넘어주기
				messageDto.setMsgNo(chatserviceImpl.msgNum());
				log.debug("메시지 디티오 : {}",messageDto);
			}
		}else if(messageDto.getMsgType().equals("delete")) {
			
			// 메시지 삭제
			
			int result = chatserviceImpl.deleteMsg(messageDto.getMsgNo());
			if(result > 0) {
				// 최근 메시지 변경
				result = 0;
				result = chatserviceImpl.newMsgNo(messageDto.getChatNo());
				if(result == messageDto.getMsgNo()) {
					messageDto.setMsgContent("삭제된 메시지입니다.");
					result = chatserviceImpl.changeNewMsg(messageDto);					
				}
			}
			messageDto.setType("delete");
		}else if(messageDto.getMsgType().equals("modify")) {
			// 메시지 수정
			messageDto.setMsgStatus(chatserviceImpl.msgStatus(messageDto));
			int result = chatserviceImpl.modifyMsg(messageDto);
			if(result > 0) {
				// 최근 메시지 변경
				result = 0;
				result = chatserviceImpl.newMsgNo(messageDto.getChatNo());
				if(result == messageDto.getMsgNo()) {
					result = chatserviceImpl.changeNewMsg(messageDto);
					messageDto.setType("modify");				
				}
			}
			
			messageDto.setType("modify");
			
		}else if(messageDto.getMsgType().equals("notice")) {
			// 공지사항 등록할 메시지 가져오기
			messageDto.setMsgContent(String.valueOf(chatserviceImpl.noticeMsg(messageDto)));
			// 공지사항 chat_list에 등록
			int result = chatserviceImpl.insertNoticeNo(messageDto);
			messageDto.setType("notice");
		}
		
		return messageDto;
	}
	

	
	
}
