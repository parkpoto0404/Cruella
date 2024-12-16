package com.cl.cruella.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cl.cruella.dao.NoticeDao;
import com.cl.cruella.dto.AttachDto;
import com.cl.cruella.dto.DeptDto;
import com.cl.cruella.dto.NoticeDto;
import com.cl.cruella.dto.PageInfoDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {

    private final NoticeDao noticeDao;

    @Transactional
    @Override
    public int insertNotice(NoticeDto n) {
        int result = noticeDao.insertNotice(n);

        if (result > 0) {
            int noticeNo = noticeDao.getLastInsertId(); // 삽입된 notice_no 값을 가져옵니다.
            
            List<AttachDto> list = n.getAttachList();
            if (!list.isEmpty()) {
                for (AttachDto at : list) {
                    at.setRefNo(noticeNo); // 첨부 파일의 refNo를 noticeNo로 설정
                    noticeDao.insertAttach(at);
                }
            }

            for (DeptDto dept : n.getDeptCodes()) {
                noticeDao.insertNoticeDept(noticeNo, dept.getDeptCode());
            }
        }

        return result;
    }

    @Override
    public int updateIncreaseCount(int noticeNo) {
        return noticeDao.updateIncreaseCount(noticeNo);
    }

    @Override
    public NoticeDto selectNotice(int noticeNo) {
        return noticeDao.selectNotice(noticeNo);
    }

    @Transactional
    @Override
    public int updateNotice(NoticeDto notice, String[] delFileNo) {
        // 공지사항 업데이트
        int result = noticeDao.updateNotice(notice);

        // 삭제할 첨부파일 처리
        if (delFileNo != null && delFileNo.length > 0) {
            result += noticeDao.deleteAttachByFileNo(delFileNo);
        }

        // 새로운 첨부파일 삽입
        List<AttachDto> attachList = notice.getAttachList();
        if (attachList != null && !attachList.isEmpty()) {
            for (AttachDto attach : attachList) {
                result += noticeDao.insertAttach(attach);
            }
        }

        return result;
    }

    @Override
    public void updateNoticeDept(NoticeDto notice) {
        // 기존 부서 코드를 삭제하고 새로운 부서 코드 추가
        noticeDao.deleteNoticeDept(notice.getNoticeNo());
        for (DeptDto dept : notice.getDeptCodes()) {
            noticeDao.insertNoticeDept(notice.getNoticeNo(), dept.getDeptCode());
        }
    }

    @Override
    public List<AttachDto> selectDelAttach(String[] delFileNo) {
        return delFileNo == null ? new ArrayList<>() : noticeDao.selectDelAttach(delFileNo);
    }
    
    @Override
    public int deleteNotice(int noticeNo) {
        return noticeDao.deleteNotice(noticeNo);
    }
    
    @Transactional
    @Override
    public int deleteSelectedPosts(List<Integer> noticeNos) {
        return noticeDao.deleteSelectedPosts(noticeNos);
    }

    @Override
    public int selectNoticeListCount(Map<String, Object> params) {
        return noticeDao.selectNoticeListCount(params);
    }

    @Override
    public List<NoticeDto> selectNoticeList(Map<String, Object> params) {
        return noticeDao.selectNoticeList(params);
    }

    @Override
    public int selectSearchListCount(Map<String, Object> params) {
        return noticeDao.selectSearchListCount(params);
    }

    @Override
    public List<NoticeDto> selectSearchList(Map<String, Object> params, PageInfoDto pi) {
        return noticeDao.selectSearchList(params, pi);
    }
}
