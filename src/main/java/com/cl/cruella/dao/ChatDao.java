package com.cl.cruella.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.cl.cruella.dto.AlertDto;
import com.cl.cruella.dto.ChatDto;
import com.cl.cruella.dto.ChatListDto;
import com.cl.cruella.dto.ChatProfileDto;
import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.dto.MessageDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ChatDao {
	
	private final SqlSessionTemplate sqlSession;

	public List<ChatDto> chatList(String memNo) {
		return sqlSession.selectList("chatMapper.chatList",memNo);
	}

	public List<ChatProfileDto> chatProFileList() {
		return sqlSession.selectList("chatMapper.chatProFileList");
	}

	public List<MemberDto> memberList() {
		return sqlSession.selectList("chatMapper.memberList");
	}
	
	public int chatCount(int chatNo) {
		return sqlSession.selectOne("chatMapper.chatCount",chatNo);
	}

	public MemberDto memberInfo(String memNo) {
		return sqlSession.selectOne("chatMapper.memberInfo",memNo);
	}

	public ChatProfileDto chatProFileInfo(String memNo) {
		return sqlSession.selectOne("chatMapper.chatProFileInfo",memNo);
	}

	public List<MessageDto> messageList(int chatNo) {
		return sqlSession.selectList("chatMapper.messageList",chatNo);
	}

	public int insertMessage(MessageDto messageDto) {
		return sqlSession.insert("chatMapper.insertMessage",messageDto);
	}


	public int updateNewMsg(MessageDto messageDto) {
		return sqlSession.update("chatMapper.updateNewMsg",messageDto);
	}

	public int startChat(Map<String, Object> map) {
		return sqlSession.insert("chatMapper.startChat",map);
	}

	public int insertChatList(MemberDto m) {
		return sqlSession.insert("chatMapper.insertChatList",m);
	}

	public String checkChatList(List<String> list) {
		return sqlSession.selectOne("chatMapper.checkChatList",list);
	}

	public List<ChatDto> chatInfo(MemberDto cd) {
		return sqlSession.selectList("chatMapper.chatInfo",cd);
	}

	public ChatDto chatTitle(int chatNo) {
		return sqlSession.selectOne("chatMapper.chatTitle",chatNo);
		 
	}

	public List<MemberDto> chatUserList(int chatNo) {
		return sqlSession.selectList("chatMapper.chatUserList",chatNo);
	}

	public int msgNum() {
		return sqlSession.selectOne("chatMapper.msgNum");
	}

	public int deleteMsg(int msgNo) {
		return sqlSession.update("chatMapper.deleteMsg",msgNo);
	}

	public int changeNewMsg(MessageDto messageDto) {
		return sqlSession.update("chatMapper.changeNewMsg",messageDto);
	}

	public int modifyMsg(MessageDto messageDto) {
		return sqlSession.update("chatMapper.modifyMsg",messageDto);
	}

	public String msgStatus(MessageDto messageDto) {
		return sqlSession.selectOne("chatMapper.msgStatus",messageDto);
	}

	public String chatLock(ChatListDto msgDto) {
		return sqlSession.selectOne("chatMapper.chatLock",msgDto);
	}

	public int chatLockUpdate(ChatListDto msgDto) {
		return sqlSession.update("chatMapper.chatLockUpdate",msgDto);
	}

	public int newMsgNo(int chatNo) {
		return sqlSession.selectOne("chatMapper.newMsgNo",chatNo);
	}

	public int titleChange(ChatListDto msgDto) {
		return sqlSession.update("chatMapper.titleChange",msgDto);
	}

	public int inviteMem(Map<String, Object> map3) {
		return sqlSession.insert("chatMapper.inviteMem",map3);
	}

	public int updateChatStatus(Map<String, Object> map3) {
		return sqlSession.update("chatMapper.updateChatStatus",map3);
	}

	public List<String> chatMember(Map<String, Object> map3) {
		return sqlSession.selectList("chatMapper.chatMember",map3);
	}

	public String chatMemberName(String inviteNo) {
		return sqlSession.selectOne("chatMapper.chatMemberName",inviteNo);
	}

	public List<String> memberIMG(List<String> targetMemNo) {
		return sqlSession.selectList("chatMapper.memberIMG",targetMemNo);
	}

	public String chatNewChat(String chatNo) {
		return sqlSession.selectOne("chatMapper.chatNewChat",chatNo);
	}

	public int checkChatListMem(Map<String, Object> map3) {
		return sqlSession.selectOne("chatMapper.checkChatListMem",map3);
	}

	public int deleteChat(Map<String, Object> map4) {
		return sqlSession.delete("chatMapper.deleteChat",map4);
	}

	public List<String> ChatMember2(Map<String, Object> map4) {
		return sqlSession.selectList("chatMapper.ChatMember2",map4);
	}

	public String deleteBtn(int chatNo) {
		return sqlSession.selectOne("chatMapper.deleteBtn",chatNo);
	}

	public int deleteMsgAll(Map<String, Object> map4) {
		return sqlSession.delete("chatMapper.deleteMsgAll",map4);
	}

	public int deleteChatList(Map<String, Object> map4) {
		return sqlSession.delete("chatMapper.deleteChatList",map4);
	}

	public Object noticeMsg(MessageDto messageDto) {
		return sqlSession.selectOne("chatMapper.noticeMsg",messageDto);
	}

	public int insertNoticeNo(MessageDto messageDto) {
		return sqlSession.update("chatMapper.insertNoticeNo",messageDto);
	}

	public String noticeMsgData(MessageDto m) {
		return sqlSession.selectOne("chatMapper.noticeMsgData",m);
	}

	public int deleteNotice(MessageDto m) {
		return sqlSession.update("chatMapper.deleteNotice",m);
	}

	public int statusMsg(ChatProfileDto m) {
		return sqlSession.update("chatMapper.statusMsg",m);
	}

	public List<AlertDto> alertList(MemberDto m) {
		return sqlSession.selectList("chatMapper.alertList",m);
	}

	public int alertDelete(AlertDto a) {
		return sqlSession.delete("chatMapper.alertDelete",a);
	}

	public int countAlert(MemberDto loginUser) {
		return sqlSession.selectOne("chatMapper.countAlert",loginUser);
	}

	public List<MemberDto> memberLink(ChatDto chatDto) {
		return sqlSession.selectList("chatMapper.memberLink",chatDto);
	}

	public MemberDto writerUrl(ChatDto cd) {
		return sqlSession.selectOne("chatMapper.writerUrl",cd);
	}

	public  List<String> writerNo(ChatDto cd) {
		return sqlSession.selectList("chatMapper.writerNo",cd);
	}

	public List<MemberDto> chatMemName(ChatDto cd) {
		return sqlSession.selectList("chatMapper.chatMemName",cd);
	}

	public String writerUrl2(ChatDto chatDt) {
		return sqlSession.selectOne("chatMapper.writerUrl2",chatDt);
	}
	

}
