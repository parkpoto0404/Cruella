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
public class AppRefDto { // 참조자
	
	
	private int docNo; // 문서번호
	private String refNo; // 참조자 사번
	private String refStatus; // 참조상태 = "참조"

}
