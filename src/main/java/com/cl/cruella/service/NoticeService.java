package com.cl.cruella.service;

import java.util.List;
import java.util.Map;

import com.cl.cruella.dto.AttachDto;
import com.cl.cruella.dto.NoticeDto;
import com.cl.cruella.dto.PageInfoDto;

public interface NoticeService {
    // 게시글 목록 조회 (페이징 처리)
    int selectNoticeListCount(Map<String, Object> params);
    List<NoticeDto> selectNoticeList(Map<String, Object> params);

    // 게시글 검색 조회 (페이징 처리)
    int selectSearchListCount(Map<String, Object> params);
    List<NoticeDto> selectSearchList(Map<String, Object> params, PageInfoDto pi);

    // 게시글 등록
    int insertNotice(NoticeDto n);

    // 게시글 상세 - 조회수 증가
    int updateIncreaseCount(int noticeNo);

    // 게시글 상세 - 게시글 조회
    NoticeDto selectNotice(int noticeNo);

    // 게시글 수정
    List<AttachDto> selectDelAttach(String[] delFileNo);
    int updateNotice(NoticeDto n, String[] delFileNo);
    void updateNoticeDept(NoticeDto notice); // 추가된 메서드

    // 게시글 삭제
    int deleteNotice(int noticeNo);
    int deleteSelectedPosts(List<Integer> noticeNos);
}

