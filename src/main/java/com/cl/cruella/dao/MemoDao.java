package com.cl.cruella.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.cl.cruella.dto.MemoDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MemoDao {

	private final SqlSessionTemplate sqlSession;

	public List<MemoDto> selectMemoList(String memNo) {
		return sqlSession.selectList("memoMapper.selectMemoList", memNo);
	}
	
	public int insertMemo(MemoDto memo) {
		return sqlSession.insert("memoMapper.insertMemo", memo);
	}
	
	public MemoDto selectMemoByNo(int memoNo) {
		return sqlSession.selectOne("memoMapper.selectMemoByNo", memoNo);
	}
	
	public int modifyMemo(MemoDto memo) {
		return sqlSession.update("memoMapper.modifyMemo", memo);
	}
	
	public void deleteMemo(int memoNo) {
		sqlSession.delete("memoMapper.deleteMemo", memoNo);
	}
}
