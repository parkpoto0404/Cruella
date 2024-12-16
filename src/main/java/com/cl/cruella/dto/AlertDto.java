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

public class AlertDto {
	
		private int alertNo;
		private String alertType;
		private String alertContent;
		private String alertStatus;
		private String memNo;
		private String alertRegistDate;
		private String alertLink;

}
