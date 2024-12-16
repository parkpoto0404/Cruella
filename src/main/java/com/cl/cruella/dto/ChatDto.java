package com.cl.cruella.dto;



import java.util.Date;
import java.util.List;

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
public class ChatDto {

	private int chatNo;
	private String chatTitle;
	private Date chatRegistDate;
	private String chatCreater;
	private String chatNewMsg;
	private int chatCount;
	private String strDate;
	private String chatTitle2;
	private int msgNo;
	private String type;
	private String memNo;
	private String profileURL;
	private String memName;
	private String profileURL3;
	
	private List<MemberDto> profileURL2;
	
	
}
