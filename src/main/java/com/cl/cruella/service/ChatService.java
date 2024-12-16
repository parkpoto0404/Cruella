package com.cl.cruella.service;

import java.util.List;
import java.util.Map;

import com.cl.cruella.dto.ChatDto;
import com.cl.cruella.dto.ChatProfileDto;
import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.dto.MessageDto;

public interface ChatService {
	
	// 채팅방 목록 불러오기
	List<ChatDto> chatList(String memNo);
	// 채팅 프로필 불러오기
	List<ChatProfileDto> chatProFileList();
	// 사원 목록 불러오기
	List<MemberDto> memberList();
	// 사원 한사람만 조회
	MemberDto memberInfo(String memNo);	
	// 채팅 프로필 조회
	ChatProfileDto chatProFileInfo(String memNo);
	// 채팅방 메시지 목록 가져오기
	List<MessageDto> messageList(int chatNo);
	// 채팅 시작
	int startChat(Map<String,Object> map);
	// 채팅방 중복검사
	String checkChatList(List<String> list);
	
}
