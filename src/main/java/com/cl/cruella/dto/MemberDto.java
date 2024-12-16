package com.cl.cruella.dto;

import java.sql.Date;


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

public class MemberDto {
	
	
		private String memNo;
		private String memName;
		private String memPwd;
		private String phone;
		private String email;
		private String address;
		private String hireDate;
		private Date endDate;
		private String status;
		private String gender;
		private String memSSN;
		private String account;
		private String profileURL;
		private String bankName;
		private int vacCount;
		private String deptCode;
		private String posCode;
		private String posName;
		private int salary;
		
		
		private String signPath;
		private String deptName;
		private String wlStatus;
		
		// 예빈(급여지급 jsp에서 쓸거)
	    private int pension;         // 국민연금
	    private int health;         // 건강보험
	    private int employment;     // 고용보험
	    private int care;   // 장기요양보험
	    private int totalSalary;               // 실지급액
	    private String paymentDate;            // 지급 날짜
	    private String salStatus;
	    private Date hireDate2;// 지급 여부
		
	    
	    
	    
	    
	    
	    // 영욱
	    private int chatNo;
	    private String profileURL2;
	    
	    
	    
	    
	    
	    
}
