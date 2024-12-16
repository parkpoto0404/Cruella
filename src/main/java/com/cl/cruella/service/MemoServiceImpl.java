package com.cl.cruella.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cl.cruella.dao.MemoDao;
import com.cl.cruella.dto.MemoDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemoServiceImpl implements MemoService {

	private final MemoDao memoDao;

	@Override
	public List<MemoDto> selectMemoList(String memNo) {
		return memoDao.selectMemoList(memNo);
	}

	@Override
	public int insertMemo(MemoDto memo) {
		return memoDao.insertMemo(memo);
	}

	@Override
	public MemoDto selectMemoByNo(int memoNo) {
		return memoDao.selectMemoByNo(memoNo);
	}

	@Override
	public int modifyMemo(MemoDto memo) {
		return memoDao.modifyMemo(memo);
	}

	@Override
	public void deleteMemo(int memoNo) {
		memoDao.deleteMemo(memoNo);
	}
	
}
