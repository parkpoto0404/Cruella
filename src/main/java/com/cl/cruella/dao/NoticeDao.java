package com.cl.cruella.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.cl.cruella.dto.AttachDto;
import com.cl.cruella.dto.DeptDto;
import com.cl.cruella.dto.NoticeDto;
import com.cl.cruella.dto.PageInfoDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class NoticeDao {

    private final SqlSessionTemplate sqlSession;

    public int insertNotice(NoticeDto n) {
        return sqlSession.insert("noticeMapper.insertNotice", n);
    }

    public int updateIncreaseCount(int noticeNo) {
        return sqlSession.update("noticeMapper.updateIncreaseCount", noticeNo);
    }

    public NoticeDto selectNotice(int noticeNo) {
        return sqlSession.selectOne("noticeMapper.selectNotice", noticeNo);
    }

    public int updateNotice(NoticeDto notice) {
        return sqlSession.update("noticeMapper.updateNotice", notice);
    }

    public List<AttachDto> selectDelAttach(String[] delFileNo) {
        return sqlSession.selectList("noticeMapper.selectDelAttach", delFileNo);
    }

    public int deleteAttachByFileNo(String[] delFileNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("delFileNo", delFileNo);
        return sqlSession.delete("noticeMapper.deleteAttachByFileNo", params);
    }

    public int insertAttach(AttachDto attach) {
        return sqlSession.insert("noticeMapper.insertAttach", attach);
    }

    public int selectNoticeListCount(Map<String, Object> params) {
        return sqlSession.selectOne("noticeMapper.selectNoticeListCount", params);
    }

    public List<NoticeDto> selectNoticeList(Map<String, Object> params) {
        PageInfoDto pi = (PageInfoDto) params.get("pi");
        RowBounds rowBounds = new RowBounds((pi.getCurrentPage() - 1) * pi.getBoardLimit(), pi.getBoardLimit());
        return sqlSession.selectList("noticeMapper.selectNoticeList", params, rowBounds);
    }

    public int selectSearchListCount(Map<String, Object> params) {
        return sqlSession.selectOne("noticeMapper.selectSearchListCount", params);
    }

    public List<NoticeDto> selectSearchList(Map<String, Object> params, PageInfoDto pi) {
        RowBounds rowBounds = new RowBounds((pi.getCurrentPage() - 1) * pi.getBoardLimit(), pi.getBoardLimit());
        return sqlSession.selectList("noticeMapper.selectSearchList", params, rowBounds);
    }

    public int insertNoticeDept(int noticeNo, String deptCode) {
        Map<String, Object> params = new HashMap<>();
        params.put("noticeNo", noticeNo);
        params.put("deptCode", deptCode);
        return sqlSession.insert("noticeMapper.insertNoticeDept", params);
    }


    
    public int deleteNoticeDept(int noticeNo) {
        return sqlSession.delete("noticeMapper.deleteNoticeDept", noticeNo);
    }

    public int deleteNotice(int noticeNo) {
        // 하위 레코드 삭제
        sqlSession.delete("noticeMapper.deleteNoticeDeptByNoticeNo", noticeNo);
        sqlSession.delete("noticeMapper.deleteAttachByNoticeNo", noticeNo);

        // 부모 레코드 삭제
        return sqlSession.delete("noticeMapper.deleteNotice", noticeNo);
    }

    public int deleteAttach(List<Integer> noticeNos) {
        return sqlSession.delete("noticeMapper.deleteAttach", noticeNos);
    }

    public int deleteNotices(List<Integer> noticeNos) {
        return sqlSession.delete("noticeMapper.deleteNotices", noticeNos);
    }

    public int deleteSelectedNoticesDept(List<Integer> noticeNos) {
        Map<String, Object> params = new HashMap<>();
        params.put("noticeNos", noticeNos);
        return sqlSession.delete("noticeMapper.deleteSelectedNoticesDept", params);
    }

    public int deleteSelectedAttach(List<Integer> noticeNos) {
        Map<String, Object> params = new HashMap<>();
        params.put("noticeNos", noticeNos);
        return sqlSession.delete("noticeMapper.deleteSelectedAttach", params);
    }

    public int deleteSelectedPosts(List<Integer> noticeNos) {
        Map<String, Object> params = new HashMap<>();
        params.put("noticeNos", noticeNos);

        int result = 0;
        result += sqlSession.delete("noticeMapper.deleteSelectedNoticesDept", params);
        result += sqlSession.delete("noticeMapper.deleteSelectedAttach", params);
        result += sqlSession.delete("noticeMapper.deleteSelectNotice", params);

        return result;
    }

    public int getLastInsertId() {
        return sqlSession.selectOne("noticeMapper.getLastInsertId");
    }

}
