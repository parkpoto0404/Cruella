package com.cl.cruella.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.cl.cruella.dao.ChartDao;
import com.cl.cruella.dto.RevenueDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChartServiceImpl implements ChartService {

    private final ChartDao chartDao;

    @Override
    public List<RevenueDto> getDeptIncomeByMonth(Map<String, String> params) {
        return chartDao.findDeptIncomeByMonth(params);
    }

    @Override
    public List<RevenueDto> getMonthlySalesByYear(String year) {
        return chartDao.findMonthlySalesByYear(year);
    }

    @Override
    public List<RevenueDto> getStoreSales(String deptCode, String startDate, String endDate) {
        return chartDao.findStoreSales(deptCode, startDate, endDate);
    }

}


