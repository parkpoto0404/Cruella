package com.cl.cruella.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cl.cruella.dto.AttachDto;
import com.cl.cruella.dto.DeptDto;
import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.dto.NoticeDto;
import com.cl.cruella.dto.PageInfoDto;
import com.cl.cruella.service.NoticeService;
import com.cl.cruella.util.FileUtil;
import com.cl.cruella.util.PagingUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/notice")
@RequiredArgsConstructor
public class NoticeController {

    private final NoticeService noticeService;
    private final PagingUtil pagingUtil;
    private final FileUtil fileUtil;

    @GetMapping("/noticeList.do")
    public String list(@RequestParam(value = "page", defaultValue = "1") int currentPage,
                       @RequestParam(value = "deptCode", required = false) String deptCode,
                       Model model, HttpSession session) {
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/signin.do";
        }

        String loggedInDeptCode = deptCode != null ? deptCode : loginUser.getDeptCode();
        if (loggedInDeptCode == null) {
            model.addAttribute("error", "부서 코드가 설정되지 않았습니다.");
            return "errorPage"; // 에러 페이지로 리디렉션
        }
        
        Map<String, Object> params = new HashMap<>();
        params.put("deptCode", loggedInDeptCode);

        int listCount = noticeService.selectNoticeListCount(params);

        PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
        params.put("pi", pi);

        List<NoticeDto> list = noticeService.selectNoticeList(params);

        model.addAttribute("pi", pi);
        model.addAttribute("list", list);

        return "notice/noticeList";
    }

    @GetMapping("/increase.do")
    public String increaseCount(int no) {
        noticeService.updateIncreaseCount(no);
        return "redirect:/notice/noticeDetail.do?no=" + no;
    }

    @GetMapping("/noticeDetail.do")
    public void detail(@RequestParam("no") int no, Model model) {
        NoticeDto n = noticeService.selectNotice(no);
        model.addAttribute("n", n);
    }

    @GetMapping("/noticeRegist.do")
    public void noticeRegistPage() { }

    @PostMapping("/noticeInsert.do")
    public String regist(NoticeDto notice, @RequestParam("deptCode") List<String> deptCodes, 
                         List<MultipartFile> uploadFiles, HttpSession session, HttpServletRequest request, RedirectAttributes rdAttributes) {
        notice.setMemNo(String.valueOf(((MemberDto) session.getAttribute("loginUser")).getMemNo()));

        // 상단 고정 여부 설정
        notice.setIsPinned(Integer.parseInt(request.getParameter("isPinned")));

        // DeptDto 객체로 변환
        Set<String> uniqueDeptCodes = new HashSet<>(deptCodes);
        uniqueDeptCodes.add("S2"); // 인사팀 코드 고정 추가
        List<DeptDto> deptDtoList = uniqueDeptCodes.stream()
                                                   .map(code -> DeptDto.builder().deptCode(code).build())
                                                   .collect(Collectors.toList());
        notice.setDeptCodes(deptDtoList); // 부서 코드 설정

        List<AttachDto> attachList = new ArrayList<>();
        for (MultipartFile file : uploadFiles) {
            if (file != null && !file.isEmpty()) {
                Map<String, String> map = fileUtil.fileupload(file, "notice");
                attachList.add(AttachDto.builder()
                                        .filePath(map.get("filePath"))
                                        .originalName(map.get("originalName"))
                                        .filesystemName(map.get("filesystemName"))
                                        .refType("N")
                                        .build());
            }
        }
        notice.setAttachList(attachList);

        int result = noticeService.insertNotice(notice);

        if (result > 0) {
            rdAttributes.addFlashAttribute("alertMsg", "게시글 등록 성공");
        } else {
            rdAttributes.addFlashAttribute("alertMsg", "게시글 등록 실패");
        }

        return "redirect:/notice/noticeList.do";
    }


    @PostMapping("/noticeModify.do")
    public String modifyPage(@RequestParam("no") int no, Model model) {
        model.addAttribute("n", noticeService.selectNotice(no));
        return "notice/noticeModify";
    }

    @PostMapping("/noticeUpdate.do")
    public String modify(NoticeDto notice, @RequestParam(value = "delFileNo", required = false) String[] delFileNo, 
                         @RequestParam("deptCode") List<String> deptCodes, List<MultipartFile> uploadFiles, RedirectAttributes rdAttributes) {
        // 삭제할 첨부파일 목록을 가져옵니다.
        List<AttachDto> delAttachList = noticeService.selectDelAttach(delFileNo);

        // 새로운 첨부파일 목록을 준비합니다.
        List<AttachDto> attachList = new ArrayList<>();
        for (MultipartFile file : uploadFiles) {
            if (file != null && !file.isEmpty()) {
                Map<String, String> map = fileUtil.fileupload(file, "notice");
                attachList.add(AttachDto.builder()
                                        .filePath(map.get("filePath"))
                                        .originalName(map.get("originalName"))
                                        .filesystemName(map.get("filesystemName"))
                                        .refType("N")
                                        .refNo(notice.getNoticeNo())
                                        .build());
            }
        }
        notice.setAttachList(attachList);

        // DeptDto 객체로 변환
        List<DeptDto> deptDtoList = deptCodes.stream()
                                              .map(code -> DeptDto.builder().deptCode(code).build())
                                              .collect(Collectors.toList());
        notice.setDeptCodes(deptDtoList); // 부서 코드 설정

        // 공지사항을 업데이트합니다.
        int result = noticeService.updateNotice(notice, delFileNo);

        // notice_dept 업데이트 로직 추가
        if (result > 0) {
            noticeService.updateNoticeDept(notice);
            rdAttributes.addFlashAttribute("alertMsg", "성공적으로 수정되었습니다.");
            for (AttachDto at : delAttachList) {
                new File(at.getFilePath() + "/" + at.getFilesystemName()).delete();
            }
        } else {
            rdAttributes.addFlashAttribute("alertMsg", "게시글 수정에 실패했습니다.");
        }

        return "redirect:/notice/noticeDetail.do?no=" + notice.getNoticeNo();
    }



    @GetMapping("/noticeSearch.do")
    public String search(@RequestParam(value = "page", defaultValue = "1") int currentPage,
                         @RequestParam Map<String, Object> search, Model model, HttpSession session) {
        if (!search.containsKey("deptCode")) {
            MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
            search.put("deptCode", loginUser.getDeptCode());
        }

        int listCount = noticeService.selectSearchListCount(search);
        PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
        List<NoticeDto> list = noticeService.selectSearchList(search, pi);

        model.addAttribute("pi", pi);
        model.addAttribute("list", list);
        model.addAttribute("search", search);

        return "notice/noticeList";
    }

    @PostMapping("/noticeDelete.do")
    public String remove(@RequestParam("no") int no, RedirectAttributes rdAttributes) {
        int result = noticeService.deleteNotice(no);

        if (result > 0) {
            rdAttributes.addFlashAttribute("alertMsg", "성공적으로 삭제되었습니다.");
        } else {
            rdAttributes.addFlashAttribute("alertMsg", "게시글 삭제에 실패하였습니다.");
        }

        return "redirect:/notice/noticeList.do";
    }

    @PostMapping("/deleteSelectedPosts.do")
    public String deleteSelectedPosts(@RequestParam("noticeNos") List<Integer> noticeNos, RedirectAttributes rdAttributes) {
        int result = noticeService.deleteSelectedPosts(noticeNos);

        if (result > 0) {
            rdAttributes.addFlashAttribute("alertMsg", "선택된 게시글이 성공적으로 삭제되었습니다.");
        } else {
            rdAttributes.addFlashAttribute("alertMsg", "게시글 삭제에 실패하였습니다.");
        }
        return "redirect:/notice/noticeList.do";
    }



}

