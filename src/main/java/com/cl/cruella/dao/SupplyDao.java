package com.cl.cruella.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.cl.cruella.dto.AttachDto;
import com.cl.cruella.dto.PageInfoDto;
import com.cl.cruella.dto.SupplyDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class SupplyDao {

	
	private final SqlSessionTemplate sqlSession;
	
	public List<SupplyDto> selectSupplyList(String supCategory, PageInfoDto pi){
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage() - 1) * pi.getBoardLimit() , pi.getBoardLimit());

		return sqlSession.selectList("supplyMapper.selectSupplyList", supCategory, rowBounds);
	}
	
	
	public int countSupply(String supCategory) {
		return sqlSession.selectOne("supplyMapper.countSupply", supCategory);
	}
	
	public int insertSupply(SupplyDto s) {
		return sqlSession.insert("supplyMapper.insertSupply", s);
				
	}
	
	public int insertAttach(AttachDto attach) {
		return sqlSession.insert("supplyMapper.insertAttach", attach);
	}
	
	public int insertRental(SupplyDto s) {
		return sqlSession.insert("supplyMapper.insertRental", s);
	}
	
}
