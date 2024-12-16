package com.cl.cruella.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.cl.cruella.dto.AppdocDto;
import com.cl.cruella.dto.DeptDto;
import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.dto.PageInfoDto;
import com.cl.cruella.dto.WorkLogDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MemberDao {

	private final SqlSessionTemplate sqlSession;
	
	public MemberDto selectMember(MemberDto m) {
		return sqlSession.selectOne("memberMapper.selectMember", m);
	}
	
	public int resetPwd(String newPwd, String memNo) {
		
	    Map<String, Object> params = new HashMap<>();
	    params.put("newPwd", newPwd);
	    params.put("memNo", memNo);
		
		return sqlSession.update("memberMapper.resetPwd", params);
	}

	public int insertMember(MemberDto m) {

		int result =  sqlSession.insert("memberMapper.insertMember", m);
		if(result > 0) {
			result = 0;
			result = sqlSession.insert("memberMapper.chatProfile", m);
		}
		return result;
	}
	
	public List<MemberDto> selectTeamList(MemberDto m) {
		return sqlSession.selectList("memberMapper.selectTeamList", m);
	}
	
	public MemberDto checkEmail(String email) {
		return sqlSession.selectOne("memberMapper.checkEmail", email);
	}
	
	public void updatePwd(String email, String str) {
		
		Map<String, String> params = new HashMap<>();
		params.put("str", str);
		params.put("email", email);
		
		sqlSession.update("memberMapper.updatePwd", params);
	}

	public String memberNo() {
		return sqlSession.selectOne("memberMapper.selectMemNo");
	}
	
	public int saveSignPath(MemberDto m) {
		return sqlSession.update("memberMapper.saveSignPath", m);
	}

	public int getMemberCount() {
		return sqlSession.selectOne("memberMapper.getMemberCount");
	}

	public List<MemberDto> getPagedMemberList(PageInfoDto pi) {
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage() - 1) * pi.getBoardLimit() , pi.getBoardLimit());		
		return sqlSession.selectList("memberMapper.getPagedMemberList",null, rowBounds);
	}

	public MemberDto selectMemberByNo(String memNo) {
		return sqlSession.selectOne("memberMapper.selectMember2", memNo);
	}

	public int updateMember(MemberDto m) {
		return sqlSession.update("memberMapper.updateMember", m);
	
	}
	public List<MemberDto> selectAllMemberDept(String memNo, String deptName) {
		
		
	    Map<String, Object> params = new HashMap<>();
	    params.put("memNo", memNo);
	    params.put("deptName", deptName);
		
		return sqlSession.selectList("memberMapper.selectAllMemberDept", params);
	}

	public List<AppdocDto> selectVacList(Map<String, Object> params) {
        PageInfoDto pi = (PageInfoDto) params.get("pi");
        RowBounds rowBounds = new RowBounds((pi.getCurrentPage() - 1) * pi.getBoardLimit(), pi.getBoardLimit());
        return sqlSession.selectList("memberMapper.selectVacList", params, rowBounds);
	}
	
	public int selectVacListCount(String memNo) {
		return sqlSession.selectOne("memberMapper.selectVacListCount", memNo);
	}
	
	public List<Map<String, String>> getAllDepartments() {
		return sqlSession.selectList("memberMapper.getAllDepartments");
	}

	public List<Map<String, String>> getEmployeesByDeptCode(String deptCode) {
		return sqlSession.selectList("memberMapper.getEmployeesByDeptCode", deptCode);
	}

	public int insertPayment(MemberDto m) {
		return sqlSession.insert("memberMapper.insertPayment", m);
	}
	
	
	
	

	public List<MemberDto> salarypaymentList() {
		return sqlSession.selectList("memberMapper.salarypayment");
	}
	public List<MemberDto> salarypaymentList2(Map<String,Object> salDate) {
		return sqlSession.selectList("memberMapper.salarypayment",salDate);
	}

	
	
	
	
	
	public int payBtn(String no) {
		return sqlSession.update("memberMapper.payBtn", no);
	}

	public List<MemberDto> getSalaryByDate(int year, int month) {
        Map<String, Integer> params = new HashMap<>();
        params.put("year", year);
        params.put("month", month);
        return sqlSession.selectList("memberMapper.getSalaryByDate", params);
	}

	public MemberDto paystub(String memNo) {
		return sqlSession.selectOne("memberMapper.paystub",memNo);
	}
	
	public List<DeptDto> getDeptList(){
		return sqlSession.selectList("memberMapper.getDeptList");
	}
	
	public List<MemberDto> selectAllMember(String memNo) {
		return sqlSession.selectList("memberMapper.selectAllMember", memNo);
	}

	public int checkPhone(String phone) {
		return sqlSession.selectOne("memberMapper.checkPhone", phone);
	}

	public int updateMemberRetire(String memNo, String string) {
		return sqlSession.update("memberMapper.updateMemberRetire", memNo);
	}

	public List<WorkLogDto> workhoursview(String memNo) {
		return sqlSession.selectList("wlMapper.workhoursview", memNo);
	}

	public MemberDto checksalary(String memNo) {
		return sqlSession.selectOne("memberMapper.checksalary", memNo);
	}





}


