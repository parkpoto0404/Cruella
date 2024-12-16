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
import com.cl.cruella.dto.MessageDto;
import com.cl.cruella.service.ChatServiceImpl;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class ChatEchoHandler extends TextWebSocketHandler{
	
	
	private Map<String,WebSocketSession> map = new HashMap<>();
	private final ChatServiceImpl chatServiceImpl;
	
	/**
	 * 1) afterConnectionEstablished : 웹소켓에 클라이언트가 연결되었을 때 처리할 내용 정의
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		String memNo = session.getUri().getQuery();
		map.put(memNo,session);
		
		
	
	}

	
	/**
	 * 2) handlerMessage : 웹소켓으로 데이터(텍스트, 파일 등)가 전송되었을 경우 처리할 내용 정의
	 */
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		log.debug("========== 메세지 들어옴 =========");
		log.debug("WebSocketSession 객체: {}",session);
		log.debug("WebsocketMessage 객체 : {}",message);
		log.debug("메세지 내용 : {}", message.getPayload());
	    
		String loginUser = ((MemberDto)session.getAttributes().get("loginUser")).getMemNo();
		WebSocketSession mySession = map.get(loginUser); // 내 세션 찾기
	    String payload = (String) message.getPayload();
	    JSONObject jsonObject = new JSONObject(payload); 
    	List<String> targetMemNo = new ArrayList<>();
    	String memNo = jsonObject.getString("memNo");
    	String inviteNo = jsonObject.getString("inviteNo");
    	String inviteName = jsonObject.getString("inviteName");
    	String memName = jsonObject.getString("memName");
	    String msgType = jsonObject.getString("msgType");
	    /**
	     * 내가 원하는 대상에게만 보낼 메시지
	     */

	    if(msgType.equals("create")) {
	    	targetMemNo.add(memNo);
	    	targetMemNo.add(inviteNo);
	    	
	    	Map<String,Object> map2 = new HashMap<>();
	    	List<String> list2 = new ArrayList<>();
	    	List<MemberDto> list3 = new ArrayList<>();
	    	
	    	list3.add(MemberDto.builder().memNo(memNo).memName(inviteName).build());
	    	list3.add(MemberDto.builder().memNo(inviteNo).memName(memName).build());
	    	
	    	list2.add(memNo);
	    	list2.add(inviteNo);
	    	
	    	map2.put("memNo", memNo);
	    	map2.put("inviteNo", inviteNo);
	    	map2.put("inviteName",inviteName);
	    	map2.put("list", list2);
	    	map2.put("list3", list3);
	    	
	    	String result = chatServiceImpl.checkChatList(list2);
	    	if(result == null) { // 널일경우 채팅방 생성
	    		result = String.valueOf(chatServiceImpl.startChat(map2)); // 값은 1로담김
	    		if(result.equals("1")) {
	    			// 채팅방 번호랑 채팅방 제목 담아오기
	    			ChatDto cd = new ChatDto();
	    			List<ChatDto> chatList = chatServiceImpl.chatInfo(map2);
	    			
	    			for(int i =0;i<chatList.size();i++) {
	    				cd.setChatNo(chatList.get(0).getChatNo());
	    				cd.setChatTitle(chatList.get(0).getChatTitle());
	    				cd.setChatTitle2(chatList.get(1).getChatTitle());
	    			}
	    			
	    			cd.setType("create");
	    			ChatDto chatDt = new ChatDto();
	    			chatDt.setMemNo(inviteNo);
	    			chatDt.setMemName(memNo);
	    			MemberDto md = chatServiceImpl.writerUrl(chatDt);
	    			md.setProfileURL2(chatServiceImpl.writerUrl2(chatDt));
	    			cd.setProfileURL(md.getProfileURL());
	    			cd.setProfileURL3(md.getProfileURL2());
	    			ObjectMapper objectMapper = new ObjectMapper();
	    			String cdJson = objectMapper.writeValueAsString(cd); 
	    			for(String target : targetMemNo) {
	    				WebSocketSession targetSession = map.get(target);
	    				if (targetSession != null) {
	    					targetSession.sendMessage(new TextMessage(cdJson));
	    				}
	    			}
	    		}
	    	}else { // 이미 존재하는 채팅방일경우
	    		
	    		mySession.sendMessage(new TextMessage("0"));
	    	}
	    
	    }else if(msgType.equals("invite")) {

	    	System.out.println("초대로 들어옴");
	    	System.out.println(memNo);		// 초대하는 사원번호
	    	System.out.println(memName);	// 초대하는 사람이름
	    	System.out.println(inviteNo);	// 초대받는 사원번호
	    	System.out.println(inviteName); // 채팅방 번호
	    	
	    	Map<String,Object> map3 = new HashMap<>();
	    	
	    	map3.put("inviteNo", inviteNo);
	    	map3.put("memNo", memNo);
	    	map3.put("memName", memName);
	    	map3.put("chatNo", inviteName);
	    	
	    	if(memNo.equals(inviteNo)) {
	    		mySession.sendMessage(new TextMessage("1"));
	    	}
	    	else{
	    		int check = chatServiceImpl.checkChatListMem(map3);
	    		if(check == 1) {
	    			mySession.sendMessage(new TextMessage("2"));
	    		}else {
		    			// chat_list 테이블에 초대한 인원정보 추가
		    			int result = chatServiceImpl.inviteMem(map3);
		    			if(result > 0) {
		    				// chat_list 해당 채팅방 종류 'G' 로 변경
		    				result = 0;
		    				result = chatServiceImpl.updateChatStatus(map3);
		    				// 해당 채팅방에 있는 멤버 정보 다불러오기
		    				targetMemNo = chatServiceImpl.chatMember(map3);
		    				log.debug("타겟타켃타켓ㅁ맴:{}",targetMemNo);
		    				List<String> imgURL = chatServiceImpl.memberIMG(targetMemNo);
		    				
		    				ChatDto cd = new ChatDto();
		    				cd.setChatNo(Integer.parseInt(inviteName));
		    				cd.setChatTitle(memName+" 단체방");
		    				cd.setChatTitle2(chatServiceImpl.chatMemberName(inviteNo));
		    				cd.setType("invite");
		    				map3.put("type", "invite");
		    				map3.put("chatTitle", memName+"단체방");
		    				map3.put("chatTitle2",chatServiceImpl.chatMemberName(inviteNo));
		    				// 맵에 채팅방 맴버 이미지 경로 받아오기
		    				map3.put("memIMG", imgURL);
		    				// 맵에 채팅방 최신메시지 받아오기
		    				map3.put("newMsg", chatServiceImpl.chatNewChat(inviteName));
		    				log.debug("맵맵맵맵맴맴ㅁ맴:{}",map3);
		    				ObjectMapper objectMapper = new ObjectMapper();
		    				String cdJson = objectMapper.writeValueAsString(map3); 
		    				for(String target : targetMemNo) {
		    					WebSocketSession targetSession = map.get(target);
		    					if (targetSession != null) {
		    						targetSession.sendMessage(new TextMessage(cdJson));
								}
							}

						}

					}

				}
	    		
	    	
	    	
	    }else if(msgType.equals("delete")) {
	    	
	   
	    	System.out.println(memNo);		// 초대하는 사원번호
	    	System.out.println(memName);	// 초대하는 사람이름
	    	System.out.println(inviteNo);	// 초대받는 사원번호
	    	System.out.println(inviteName); // 채팅방 번호
	    	
	    	
	    	Map<String,Object> map4 = new HashMap<>();
	    	map4.put("memNo", memNo);
	    	map4.put("chatNo", inviteNo);
	    	map4.put("type", "delete");
	    	targetMemNo = chatServiceImpl.chatMember(map4);
	    	map4.put("target", targetMemNo);
			int result = chatServiceImpl.deleteChat(map4);
			ObjectMapper objectMapper = new ObjectMapper();
			String cdJson = objectMapper.writeValueAsString(map4); 
			System.out.println(targetMemNo);
			if(result > 0) {
				for(String target : targetMemNo) {
					WebSocketSession targetSession = map.get(target);
					if (targetSession != null) {
						targetSession.sendMessage(new TextMessage(cdJson));
					
				}
			}
			}
	    }
	    
	    
	    

	
		
	}
	
	/*
	 * 3) afterConnectionClosed : 웹소켓에 클라이언트가 연결이 끊겼을 때 처리할 내용 정의
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		String loginUser = ((MemberDto)session.getAttributes().get("loginUser")).getMemNo();
		map.remove(loginUser);
		 
		
		
	}
	

}
