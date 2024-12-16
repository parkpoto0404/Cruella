package com.cl.cruella.service;

import java.util.List;
import java.util.Map;

import com.cl.cruella.dto.RevenueDto;

public interface ChartService {
    List<RevenueDto> getDeptIncomeByMonth(Map<String, String> params);
    List<RevenueDto> getMonthlySalesByYear(String year);
    List<RevenueDto> getStoreSales(String deptCode, String startDate, String endDate);
}
