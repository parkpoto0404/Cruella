package com.cl.cruella.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.cl.cruella.dao.MemberDao;
import com.cl.cruella.dto.AppdocDto;
import com.cl.cruella.dto.DeptDto;
import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.dto.PageInfoDto;
import com.cl.cruella.dto.WorkLogDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	final MemberDao memberDao;
	
	@Override
	public MemberDto selectMember(MemberDto m) {
		return memberDao.selectMember(m);
	}

	@Override
	public int resetPwd(String newPwd, String memNo) {
		return memberDao.resetPwd(newPwd, memNo);
	}

	@Override
	public List<MemberDto> selectTeamList(MemberDto m) {
		return memberDao.selectTeamList(m);
	}

	@Override
	public MemberDto checkEmail(String email) {
		return memberDao.checkEmail(email);
	}

	@Override
	public void updatePwd(String email, String str) {
		memberDao.updatePwd(email, str);
	}

	@Override	
	public int insertMember(MemberDto m) {
		return memberDao.insertMember(m);

	}

	@Override
	public String memberNo() {
		return memberDao.memberNo();
		}


	@Override
	public int saveSignPath(MemberDto m) {
		return memberDao.saveSignPath(m);
	}

	@Override
	public int getMemberCount() {
		return memberDao.getMemberCount();
	}

	@Override
	public List<MemberDto> getPagedMemberList(PageInfoDto pi) {
		return memberDao.getPagedMemberList(pi);
	}

	@Override
	public MemberDto selectMemberByNo(String memNo) {
		return memberDao.selectMemberByNo(memNo);
	}

	@Override
	public int updateMember(MemberDto m) {
		return memberDao.updateMember(m);
	}
	
	@Override
	public List<MemberDto> selectAllMemberDept(String memNo, String deptName) {
		return memberDao.selectAllMemberDept(memNo, deptName);
	}

	@Override
	public int insertPayment(MemberDto m) {
		return memberDao.insertPayment(m);
	}
	
	
	
	@Override
	public List<MemberDto> salarypaymentList() {
		return memberDao.salarypaymentList();
	}
	
	@Override
	public List<MemberDto> salarypaymentList2(Map<String,Object> salDate) {
		return memberDao.salarypaymentList2(salDate);
	}
	
	
	

	@Override
	public int payBtn(List<String> memNos) {
		int result = 0;
		for( String no : memNos) {
			result += memberDao.payBtn(no);
			
		}
		return result;
	}
	public int selectVacListCount(String memNo) {
		return memberDao.selectVacListCount(memNo);
	}

	@Override
	public List<AppdocDto> selectVacList(Map<String, Object> params) {
		return memberDao.selectVacList(params);
	}

	@Override
	public List<MemberDto> getSalaryByDate(int year, int month) {
		return memberDao.getSalaryByDate(year, month);
	}

	@Override
	public MemberDto paystub(String memNo) {
		return memberDao.paystub(memNo);
	}

	@Override
	public List<DeptDto> getDeptList() {
		return memberDao.getDeptList();
	}

	@Override
	public List<MemberDto> selectAllMember(String memNo) {
		return memberDao.selectAllMember(memNo);
	}

	@Override
	public int checkPhone(String phone) {
		return memberDao.checkPhone(phone);
	}

	@Override
	public void updateMemberRetire(String memNo) {
		memberDao.updateMemberRetire(memNo, "N");
	}

	@Override
	public List<WorkLogDto> workhoursview(String memNo) {
		return memberDao.workhoursview(memNo);
	}

	@Override
	public MemberDto checksalary(String memNo) {
		return memberDao.checksalary(memNo);
	}





}
