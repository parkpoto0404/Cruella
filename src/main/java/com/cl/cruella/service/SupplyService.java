package com.cl.cruella.service;

import java.util.List;

import com.cl.cruella.dto.AttachDto;
import com.cl.cruella.dto.PageInfoDto;
import com.cl.cruella.dto.SupplyDto;

public interface SupplyService {

	// 비품 첫화면으로 가기
	// 이건 컨트롤러만 작성하면 됨
	
	// 비품 전체 갯수 조회하기
	int countSupply(String supCategory);
	
	
	
	
	// 비품 카테고리 선택해서 조회하기
	List<SupplyDto> selectSupplyList(String supCategory, PageInfoDto pi);
	
	
	// 비품 추가
	int insertSupply(SupplyDto s, List<AttachDto> list);
	
	// 비품 신청
	int insertRental(SupplyDto s);
	
	
	// 비품 수정
	
	// 비품 삭제
	
	
}
