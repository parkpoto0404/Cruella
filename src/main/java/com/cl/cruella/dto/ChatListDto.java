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
@Getter
@Setter
@ToString
@Builder
public class ChatListDto {
	
	 private int chatNo;
	 private String memNo;
	 private Date clRegistDate;
	 private String chatNoticeNo;
	 private String clLock;
	 private String clAlram;
	 private String type;
	 private String clTitle;

}
