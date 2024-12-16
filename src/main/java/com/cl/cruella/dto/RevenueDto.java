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
public class RevenueDto {
    private String memNo;       // 회원 번호
    private int rvValue;        // 매출 값
    private String rvRegistDate; // 등록 날짜
    private String rvStore;     // 매장 이름
    private String posCode;     // 직위 코드
    private String deptCode;    // 부서 코드
    private String month;       // 월
    private int sumValue;
    private int sumStore;
    private String memName;
}
