package com.cl.cruella.dao;

import com.cl.cruella.dto.RevenueDto;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class RevenueDao {

    private final JdbcTemplate jdbcTemplate;

    public RevenueDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

 // 매출 데이터가 이미 있는지 확인 (날짜와 매장명만 비교)
    private boolean isRevenueExist(String rvStore, String rvRegistDate) {
        String sql = "SELECT COUNT(*) FROM REVENUE WHERE RV_STORE = ? AND RV_REGIST_DATE = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, rvStore, rvRegistDate);
        return count != null && count > 0;
    }

    // 매출 등록 또는 업데이트
    public void saveOrUpdateRevenues(List<RevenueDto> revenueList) {
        for (RevenueDto revenueDto : revenueList) {
            if (isRevenueExist(revenueDto.getRvStore(), revenueDto.getRvRegistDate())) {
                updateRevenue(revenueDto);
            } else {
                insertRevenue(revenueDto);
            }
        }
    }

    // 매출 업데이트 (현재 memNo로 업데이트)
    private void updateRevenue(RevenueDto revenueDto) {
        String updateSql = "UPDATE REVENUE SET MEM_NO = ?, RV_VALUE = ? WHERE RV_STORE = ? AND RV_REGIST_DATE = ?";
        jdbcTemplate.update(updateSql,
            revenueDto.getMemNo(),
            revenueDto.getRvValue(),
            revenueDto.getRvStore(),
            revenueDto.getRvRegistDate()
        );
    }

    // 매출 삽입
    private void insertRevenue(RevenueDto revenueDto) {
        String insertSql = "INSERT INTO REVENUE (MEM_NO, RV_VALUE, RV_REGIST_DATE, RV_STORE) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(insertSql,
            revenueDto.getMemNo(),
            revenueDto.getRvValue(),
            revenueDto.getRvRegistDate(),
            revenueDto.getRvStore()
        );
    }


    // 오라클 DB에서 날짜 문자열을 TO_DATE로 변환하여 정렬
    public List<RevenueDto> findAllRevenues() {
        String sql = "SELECT r.*, m.MEM_NAME FROM REVENUE r " +
                     "JOIN MEMBER m ON r.MEM_NO = m.MEM_NO " +
                     "ORDER BY TO_DATE(r.RV_REGIST_DATE, 'YYYY-MM-DD') DESC";  // 최신 날짜가 먼저 나오도록 내림차순 정렬
        return jdbcTemplate.query(sql, this::mapRowToRevenueDto);
    }

    private RevenueDto mapRowToRevenueDto(ResultSet rs, int rowNum) throws SQLException {
        return RevenueDto.builder()
                .memNo(rs.getString("MEM_NO"))
                .rvValue(rs.getInt("RV_VALUE"))
                .rvRegistDate(rs.getString("RV_REGIST_DATE"))
                .rvStore(rs.getString("RV_STORE"))
                .memName(rs.getString("MEM_NAME"))  // MEMBER 테이블에서 가져온 memName
                .build();
    }

    // 매출 데이터 페이징 조회 (회원 정보 포함)
    public List<RevenueDto> findRevenuesWithPaging(int startRow, int endRow, String searchKeyword, String startDate, String endDate) {
        String sql = "SELECT * FROM ( " +
                     "    SELECT r.*, m.MEM_NAME, ROW_NUMBER() OVER (ORDER BY TO_DATE(r.RV_REGIST_DATE, 'YYYY-MM-DD') DESC) AS rn " +
                     "    FROM REVENUE r " +
                     "    JOIN MEMBER m ON r.MEM_NO = m.MEM_NO " +
                     "    WHERE (LOWER(m.MEM_NAME) LIKE LOWER(?) OR LOWER(r.RV_STORE) LIKE LOWER(?)) " +
                     "    AND TO_DATE(r.RV_REGIST_DATE, 'YYYY-MM-DD') BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') " +
                     ") WHERE rn BETWEEN ? AND ?";
        String keyword = "%" + searchKeyword + "%";
        return jdbcTemplate.query(sql, this::mapRowToRevenueDto, keyword, keyword, startDate, endDate, startRow, endRow);
    }

    public int getTotalRevenueCount(String searchKeyword, String startDate, String endDate) {
        String sql = "SELECT COUNT(*) FROM REVENUE r " +
                     "JOIN MEMBER m ON r.MEM_NO = m.MEM_NO " +
                     "WHERE (LOWER(m.MEM_NAME) LIKE LOWER(?) OR LOWER(r.RV_STORE) LIKE LOWER(?)) " +
                     "AND TO_DATE(r.RV_REGIST_DATE, 'YYYY-MM-DD') BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')";
        String keyword = "%" + searchKeyword + "%";
        return jdbcTemplate.queryForObject(sql, Integer.class, keyword, keyword, startDate, endDate);
    }
}
