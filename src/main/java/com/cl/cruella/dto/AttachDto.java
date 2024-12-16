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
public class AttachDto {
	
	private int fileNo;
	private String filePath;
	private String filesystemName;
	private String originalName;
	private Date uploadDt;
	private String refType;
	private int refNo;
	
	

}

