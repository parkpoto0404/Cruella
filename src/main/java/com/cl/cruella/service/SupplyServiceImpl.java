package com.cl.cruella.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cl.cruella.dao.SupplyDao;
import com.cl.cruella.dto.AttachDto;
import com.cl.cruella.dto.PageInfoDto;
import com.cl.cruella.dto.SupplyDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SupplyServiceImpl implements SupplyService {
	
	private final SupplyDao supplyDao;
	
	@Override
	public List<SupplyDto> selectSupplyList(String supCategory, PageInfoDto pi) {
		return supplyDao.selectSupplyList(supCategory, pi);
	}

	@Override
	public int countSupply(String supCategory) {
		return  supplyDao.countSupply(supCategory);
	}


	@Override
	public int insertSupply(SupplyDto s, List<AttachDto> list) {
		
		// list에 담긴 첨부파일들 빼서 담기
		
		int result = supplyDao.insertSupply(s); // 비품관련 insert
		
		
		if(result > 0 && !list.isEmpty()) {
			for(AttachDto attach : list) {
				result += supplyDao.insertAttach(attach);
			}
		}
		
		
		return result;
		
	}

	@Override
	public int insertRental(SupplyDto s) {
		return supplyDao.insertRental(s);
	}

	
	
	
	


}
