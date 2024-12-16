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
public class VacationDto {
	
	private int vacNo;
	private int vacDate;
	private Date vacStartDate;
	private Date vacEndDate;
	private String memNo;

}
