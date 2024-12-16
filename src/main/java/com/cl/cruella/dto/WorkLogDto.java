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
public class WorkLogDto {
	
	private int workNo;
	private String memNo;
	private String clockInTime;
	private String clockOutTime;
	private String status;
	private Date modifyDate;
	private int workTime;
	private Date workDate;
	
	private String color;
	
	private String workDate2;
	private int workDay;
	private int totalWorkTime;
	
}
