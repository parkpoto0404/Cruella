package com.cl.cruella.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class CalendarDto {

	
	private int calNo;
	private String calTitle;
	private String calContent;
	private String calStartDt;
	private String calEndDt;
	private String calStatus;
	private String calRegistDt;
	private String calModifyDt;
	private String calCategory;
	private String memNo;
	private String calRgb;
	

	
}
