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

public class MessageDto {
	
	 private int msgNo;
	 private int chatNo;
	 private String memNo;
	 private String msgContent;
	 private String  msgRegistDate;
	 private int msgCheck;
	 private String msgStatus;
	 private Date msgModifyDate;
	 private String msgType;
	 private String type;
	 private String profileURL;
	 private String memName;
}
