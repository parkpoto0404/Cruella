package com.cl.cruella.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cl.cruella.dto.RevenueDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ChartDao {

    private final SqlSession sqlSession;
    private static final String NAMESPACE = "com.cl.cruella.mapper.ChartMapper";

    public List<RevenueDto> findDeptIncomeByMonth(Map<String, String> params) {
        return sqlSession.selectList(NAMESPACE + ".findDeptIncomeByMonth", params);
    }

    public List<RevenueDto> findMonthlySalesByYear(String year) {
        return sqlSession.selectList(NAMESPACE + ".findMonthlySalesByYear", year);
    }

    public List<RevenueDto> findStoreSales(String deptCode, String startDate, String endDate) {
        Map<String, String> params = Map.of("deptCode", deptCode, "startDate", startDate, "endDate", endDate);
        return sqlSession.selectList(NAMESPACE + ".findStoreSales", params);
    }
}
