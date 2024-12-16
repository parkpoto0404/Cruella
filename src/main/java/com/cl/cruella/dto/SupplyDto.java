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
public class SupplyDto {

	private int supNo;
	private String supCategory;
	private String supName;
	private String supStatus;
	private String supDt;
	private String supModel;
	private String supRepair;
	private String supRepairDetail;
	private String supType;
	private String supUrl;

	private int totalSupply;
	private int leftSupply;
	private int repairSupply;
	private int rentSupply;
	
	private String memNo;
	
	
	
}
