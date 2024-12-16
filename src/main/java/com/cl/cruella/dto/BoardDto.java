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

public class BoardDto {
	
	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private String memNo; 
	private String boardRegistDT;
	private String boardModifyDT;
	private int boardCount;
	private String boardStatus;
	private String deptCode;
	private int attachCount;
	private String memName;
	private List<AttachDto> attachList;
	private int replyCount;
	private String profileURL;

}

