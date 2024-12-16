package com.cl.cruella.dto;

import java.sql.Date;
import java.util.ArrayList;
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
public class AppdocDto { // 기안문서
	
	
	
	private int docNo; // 문서번호
	private String memNo; //  사번
	private String docType; // 문서종류
	private String docTitle; // 제목
	private String docContent; // 내용
	private String docImpo; // 중요도
	private Date docDt; // 작성일
	private Date docModifyDt; // 수정일 // 이건 안쓸듯
	private String docStatus; // 문서 상태 = 대기/진행/최종승인/반려
	private int docOrder; // 기안문서의 결재선 순서
	private String status; // 존재 여부 : Y , N
	private String reason; // 반려사유
	
	private String memName; // 기안자 이름
	private String deptName; // 부서명
	private String posName; // 직급명
	
	
	private String signPath; // 전자서명 
	
	private int appLevel; // 현재 결재자의 순서
	
	private int maxOrder; // 기안문서의 결재선 마지막 순서
	
	private String refStatus; // 상태: 참조
	
	
	private String docMemNo; // 기안서의 사원번호
	
	private int attachCount; // 첨부파일 갯수
	
	
//	연차신청서
	private Date appDateStart; // 시작일
	private Date appDateEnd; // 끝일
	private long daysBetween; // 연차사용갯수
	
//	증명서신청서
	private Date appCoreDt; // 발행날짜
	
//	결재자 리스트 
	private List<AppRovalDto> rovalList;
	
//	참조자 리스트
	private List<AppRefDto> refList = new ArrayList<>();
	
//	파일첨부 리스트
	private List<AttachDto> attachList;
	
	
	
	
}
