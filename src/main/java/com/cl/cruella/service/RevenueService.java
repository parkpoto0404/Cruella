package com.cl.cruella.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.cl.cruella.dao.RevenueDao;
import com.cl.cruella.dto.RevenueDto;

@Service
public class RevenueService {

    private final RevenueDao revenueDao;

    public RevenueService(RevenueDao revenueDao) {
        this.revenueDao = revenueDao;
    }

    public void registerAllRevenues(String memNo, List<String> rvStores, List<Integer> rvValues) {
        if (rvStores.size() != rvValues.size()) {
            throw new IllegalArgumentException("매장과 매출 데이터가 일치하지 않습니다.");
        }

        List<RevenueDto> revenueList = new ArrayList<>();
        for (int i = 0; i < rvStores.size(); i++) {
            RevenueDto revenueDto = RevenueDto.builder()
                .memNo(memNo)
                .rvStore(rvStores.get(i))
                .rvValue(rvValues.get(i))
                .rvRegistDate(LocalDate.now().toString())
                .build();
            revenueList.add(revenueDto);
        }

        // 필터링된 데이터를 DAO에 전달
        revenueDao.saveOrUpdateRevenues(revenueList);
    }


    // 매출 리스트 조회
    public List<RevenueDto> getRevenueList() {
        return revenueDao.findAllRevenues();
    }
    
    public List<RevenueDto> getPagedRevenueList(int currentPage, int limit, String searchKeyword, String startDate, String endDate) {
        int startRow = (currentPage - 1) * limit + 1;
        int endRow = currentPage * limit;
        return revenueDao.findRevenuesWithPaging(startRow, endRow, searchKeyword, startDate, endDate);
    }

    public int getTotalRevenueCount(String searchKeyword, String startDate, String endDate) {
        return revenueDao.getTotalRevenueCount(searchKeyword, startDate, endDate);
    }



}
