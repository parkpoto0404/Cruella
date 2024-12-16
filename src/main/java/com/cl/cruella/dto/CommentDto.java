package com.cl.cruella.dto;

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

public class CommentDto {
	
	private int comNo;
	private String comContent;
	private String memNo; 
	private int boardNo;
	private int comType;
	private String comRegistDT;
	private String comModifyDT;
	private int comRef;

}

