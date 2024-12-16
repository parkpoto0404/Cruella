package com.cl.cruella.dto;


import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
@Builder
public class DeptDto { // 부서객체
	
	private String memNo; // 사원번호
	private String memName; // 사원이름
	private String deptCode; // 부서번호
	private String posCode; // 직급번호
	private String deptName; // 부서이름
	private String posName; // 직급이름
	
	private List<MemberDto> memList; // has many 

}
