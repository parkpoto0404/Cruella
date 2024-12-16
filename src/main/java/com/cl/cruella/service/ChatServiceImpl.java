package com.cl.cruella.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.cl.cruella.dao.ChatDao;
import com.cl.cruella.dto.AlertDto;
import com.cl.cruella.dto.ChatDto;
import com.cl.cruella.dto.ChatListDto;
import com.cl.cruella.dto.ChatProfileDto;
import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.dto.MessageDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService{

	
	private final ChatDao chatDao;
	
	
	@Override
	public List<ChatDto> chatList(String memNo) {
		List<ChatDto> list = chatDao.chatList(memNo);
		
		if(!list.isEmpty()) {
			for(int i =0;i<list.size();i++) {
				list.get(i).setChatCount(chatDao.chatCount(list.get(i).getChatNo()));
			}
		}
		
		return list;
	}
	@Override
	public List<ChatProfileDto> chatProFileList() {
		return chatDao.chatProFileList();
	}

	@Override
	public List<MemberDto> memberList() {
		return chatDao.memberList();
	}
	public MemberDto memberInfo(String memNo) {
		return chatDao.memberInfo(memNo);
	}
	public ChatProfileDto chatProFileInfo(String memNo) {
		return chatDao.chatProFileInfo(memNo);
	}
	public List<MessageDto> messageList(int chatNo) {
		return chatDao.messageList(chatNo);
	}
	
	public int chatCount(int chatNo) {
		return chatDao.chatCount(chatNo);
	}
	public int insertMessage(MessageDto messageDto) {
		
		return chatDao.insertMessage(messageDto);

	}
	public int updateNewMsg(MessageDto messageDto) {
		return chatDao.updateNewMsg(messageDto);
	}
	public int startChat(Map<String, Object> map) {
		int result = chatDao.startChat(map);
			if(result >0) {
				List<MemberDto> list = (List<MemberDto>)map.get("list3");
				for(int i =0;i<list.size();i++) {
					result = chatDao.insertChatList(list.get(i));
				}
			}
			
		
		
		return result;
	}
	public String checkChatList(List<String> list) {
		return chatDao.checkChatList(list);
	}
	
	public List<ChatDto> chatInfo(Map<String, Object> map2) {
		List<MemberDto> list = (List<MemberDto>)map2.get("list3");
		List<ChatDto> cl = new ArrayList<>();
		for(int i =0;i<list.size();i++) {
			cl.addAll(chatDao.chatInfo(list.get(i)));
		}
		
		return cl;
	}
	
	public ChatDto chatTitle(int chatNo) {
		return chatDao.chatTitle(chatNo);
	}
	
	public List<MemberDto> chatUserList(int chatNo) {
		return chatDao.chatUserList(chatNo);
	}
	public int msgNum() {
		return chatDao.msgNum();
	}
	public int deleteMsg(int msgNo) {
		return chatDao.deleteMsg(msgNo);
	}
	public int changeNewMsg(MessageDto messageDto) {
		return chatDao.changeNewMsg(messageDto);
	}
	public int modifyMsg(MessageDto messageDto) {
		return chatDao.modifyMsg(messageDto);
	}
	public String msgStatus(MessageDto messageDto) {
		return chatDao.msgStatus(messageDto);
	}
	public String chatLock(ChatListDto msgDto) {
		return chatDao.chatLock(msgDto);
	}
	public int chatLockUpdate(ChatListDto msgDto) {
		return chatDao.chatLockUpdate(msgDto);
	}
	public int newMsgNo(int chatNo) {
		return chatDao.newMsgNo(chatNo);
	}
	public int titleChange(ChatListDto msgDto) {
		return chatDao.titleChange(msgDto);
	}
	public int inviteMem(Map<String, Object> map3) {
		return chatDao.inviteMem(map3);
	}
	public int updateChatStatus(Map<String, Object> map3) {
		return chatDao.updateChatStatus(map3);
	}
	public List<String> chatMember(Map<String, Object> map3) {
		return chatDao.chatMember(map3);
	}
	public String chatMemberName(String inviteNo) {
		return chatDao.chatMemberName(inviteNo);
	}
	public List<String> memberIMG(List<String> targetMemNo) {
		return chatDao.memberIMG(targetMemNo);
	}
	public String chatNewChat(String chatNo) {
		return chatDao.chatNewChat(chatNo);
	}
	public int checkChatListMem(Map<String, Object> map3) {
		return chatDao.checkChatListMem(map3);
	}
	public int deleteChat(Map<String, Object> map4) {
		int result =  chatDao.deleteChat(map4);
		if(result > 0) {
			result = chatDao.deleteMsgAll(map4);
			result =chatDao.deleteChatList(map4);
		}
		
		return result;
	}
	public List<String> chatMember2(Map<String, Object> map4) {
		return chatDao.ChatMember2(map4);
	}
	public String deleteBtn(int chatNo) {
		return chatDao.deleteBtn(chatNo);
	}
	public Object noticeMsg(MessageDto messageDto) {
		return chatDao.noticeMsg(messageDto);
	}
	public int insertNoticeNo(MessageDto messageDto) {
		return chatDao.insertNoticeNo(messageDto);
	}
	public String noticeMsgData(MessageDto m) {
		return chatDao.noticeMsgData(m);
	}
	public int deleteNotice(MessageDto m) {
		return chatDao.deleteNotice(m);
	}
	public int statusMsg(ChatProfileDto m) {
		return chatDao.statusMsg(m);
	}
	public List<AlertDto> alertList(MemberDto m) {
		return chatDao.alertList(m);
	}
	public int alertDelete(AlertDto a) {
		return chatDao.alertDelete(a);
	}
	public int countAlert(MemberDto loginUser) {
		return chatDao.countAlert(loginUser);
	}
	public List<MemberDto> memberLink(List<ChatDto> chatList) {
		List<MemberDto> md = new ArrayList<>();
		for(int i=0;i<chatList.size();i++) {
			md.addAll(chatDao.memberLink(chatList.get(i)));
		}
		log.debug("서비스많이주세요:{}",md);
		return md;
	}
	public MemberDto writerUrl(ChatDto cd) {
		return chatDao.writerUrl(cd);
	}

	public List<String> writerNo(ChatDto cd) {
		return chatDao.writerNo(cd);
	}
	public List<MemberDto> chatMemName(ChatDto cd) {
		return chatDao.chatMemName(cd);
	}
	public String writerUrl2(ChatDto chatDt) {
		return chatDao.writerUrl2(chatDt);
	}



}
