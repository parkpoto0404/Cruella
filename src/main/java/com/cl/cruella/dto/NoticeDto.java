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

public class NoticeDto {
	
	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private String memNo; 
	private String noticeRegistDT;
	private String noticeModifyDT;
	private int noticeCount;
	private String noticeStatus;
	private int isPinned;
	private int attachCount;
	private String memName;
	private List<AttachDto> attachList;
	private List<DeptDto> deptCodes;
	private String profileURL;
}

