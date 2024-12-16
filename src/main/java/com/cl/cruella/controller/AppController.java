package com.cl.cruella.controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cl.cruella.dto.AppdocDto;
import com.cl.cruella.dto.AttachDto;
import com.cl.cruella.dto.DeptDto;
import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.dto.PageInfoDto;
import com.cl.cruella.service.AppService;
import com.cl.cruella.service.MemberService;
import com.cl.cruella.util.FileUtil;
import com.cl.cruella.util.PagingUtil;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/app") // 전자결재
public class AppController {
	
	private final AppService appService;
	private final FileUtil fileUtil;
	private final PagingUtil pagingUtil;
	private final MemberService memberService;
	
	
	
//  결재작성 메인페이지 이동
	@GetMapping("/app_main.do")
	public void appMainPage() {
		
	}
	
//	기안서작성 페이지 이동
	@GetMapping("/form_draft.do")
	public void formDraftPage(Model model,HttpSession session) {
		String userNo = ((MemberDto)session.getAttribute("loginUser")).getMemNo();
		DeptDto m = appService.formDraftPage(userNo);
		model.addAttribute("m",m);
		
	}
	
//	품의서작성 페이지 이동
	@GetMapping("/form_robin.do")
	public void formRobinPage(Model model,HttpSession session) {
		String userNo = ((MemberDto)session.getAttribute("loginUser")).getMemNo();
		DeptDto m = appService.formDraftPage(userNo);
		model.addAttribute("m",m);
		
	}
	
	
//  연차신청서 페이지 이동
	@GetMapping("/form_annual.do")
	public void formAnnualPage(Model model,HttpSession session) {
		String userNo = ((MemberDto)session.getAttribute("loginUser")).getMemNo();
		DeptDto m = appService.formDraftPage(userNo);
		model.addAttribute("m",m);
	}
	
	
//  지각불참사유서 페이지 이동
	@GetMapping("/form_per.do")
	public void formPerPage(Model model,HttpSession session) {
		String userNo = ((MemberDto)session.getAttribute("loginUser")).getMemNo();
		DeptDto m = appService.formDraftPage(userNo);
		model.addAttribute("m",m);
	}
	
	
//  증명서 페이지 이동
	@GetMapping("/form_cer.do")
	public void formCerPage(Model model,HttpSession session) {
		String userNo = ((MemberDto)session.getAttribute("loginUser")).getMemNo();
		DeptDto m = appService.formDraftPage(userNo);
		model.addAttribute("m",m);
	}
	
//  증명서 페이지 이동
	@GetMapping("/form_request.do")
	public void formRequestPage(Model model,HttpSession session) {
		String userNo = ((MemberDto)session.getAttribute("loginUser")).getMemNo();
		DeptDto m = appService.formDraftPage(userNo);
		model.addAttribute("m",m);
	}
	
	
	
//	jstree 조직도 조회
	@ResponseBody
	@GetMapping(value="/jstreeList.do", produces="application/json")
	public List<DeptDto> ajaxJstree(HttpSession session) {
		
		String memNo = ((MemberDto)session.getAttribute("loginUser")).getMemNo();
		
		List<DeptDto> list = appService.ajaxJstree(memNo);
		
		return list;
		
	}
	
	
	
//	전자결재작성 insert
	@PostMapping("/appInsert.do")
	public String appInsert(AppdocDto ad, List<MultipartFile> uploadFile,RedirectAttributes rdAttributes) throws IOException {
		
		List<AttachDto> list = new ArrayList<>();
		
		for(MultipartFile file : uploadFile) {
			if(file != null && !file.isEmpty()) { // 파일이 존재할 경우
				Map<String, String> map = fileUtil.fileupload(file,"appdocFolder");
				list.add(AttachDto.builder()
								  .filePath(map.get("filePath"))
								  .originalName(map.get("originalName"))
								  .filesystemName(map.get("filesystemName"))
								  .build());
			}
		}
		
		
		
		
		int result = appService.insertApp(ad,list);
		
		if(result > 0) {
			log.debug("전자결재 신청 성공");
			rdAttributes.addFlashAttribute("alertMsg", "성공적으로 결재 되었습니다.");
			
		}else {
			log.debug("실패");
			rdAttributes.addFlashAttribute("alertMsg", "전자결재 실패하였습니다.");
			
		}
		
		
		return "redirect:/app/box_main.do";
		
		
		
	}
	
	
	// 결재문서함 메인페이지
	@GetMapping("/box_main.do")
	public void boxpdPage(){}
	
	
	
	
	
	
	
	// 결재대기함 조회
	@GetMapping("/box_standby.do")
	public void boxStandbyPage(@RequestParam(value="page", defaultValue="1") int currentPage
								,HttpSession session
								,Model model) {
		
		String memNo = ((MemberDto)session.getAttribute("loginUser")).getMemNo();
		
		int listCount = appService.selectStandbyCount(memNo);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 8);
		
		List<AppdocDto> list = appService.selectStandby(memNo,pi);
		
		model.addAttribute("list",list);
		model.addAttribute("pi",pi);
		
	}
	
	
	// 결재반려함 조회
	@GetMapping("/box_companion.do")
	public void companionSelect(@RequestParam(value="page", defaultValue="1") int currentPage
			,HttpSession session
			,Model model) {
		
		String memNo = ((MemberDto)session.getAttribute("loginUser")).getMemNo();
		
		int listCount = appService.selectCompanionCount(memNo);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 8);
		
		List<AppdocDto> list = appService.selectCompanion(memNo,pi);
		
		model.addAttribute("list",list);
		model.addAttribute("pi",pi);
		
	}
	
	
	
	// 결재진행함 조회
	@GetMapping("/box_progress.do")
	public void progressSelect(@RequestParam(value="page", defaultValue="1") int currentPage
			,HttpSession session
			,Model model) {
		
		String memNo = ((MemberDto)session.getAttribute("loginUser")).getMemNo();
		
		int listCount = appService.selectProgressCount(memNo);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 8);
		
		List<AppdocDto> list = appService.selectProgress(memNo,pi);
		
		model.addAttribute("list",list);
		model.addAttribute("pi",pi);
		
	}
	
	
	
	
	// 참조열람함 조회
	@GetMapping("/box_view.do")
	public void boxViewPage(@RequestParam(value="page", defaultValue="1") int currentPage
						,HttpSession session
						,Model model) {
		
		String memNo = ((MemberDto)session.getAttribute("loginUser")).getMemNo();
		
		int listCount = appService.selectViewCount(memNo);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 8);
		
		List<AppdocDto> list = appService.selectView(memNo,pi);
		
		model.addAttribute("list",list);
		model.addAttribute("pi",pi);
		
	}
	
	
	// 결재완료함 조회
	@GetMapping("/box_complete.do")
	public void boxCompletePage(@RequestParam(value="page", defaultValue="1") int currentPage
			,HttpSession session
			,Model model) {
		
		String memNo = ((MemberDto)session.getAttribute("loginUser")).getMemNo();
		
		int listCount = appService.selectSuccessCount(memNo);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 8);
		
		List<AppdocDto> list = appService.selectSuccess(memNo,pi);
		
		model.addAttribute("list",list);
		model.addAttribute("pi",pi);
		
	}
	
	
	
	
	
//	결재문서함(대기,반려,진행,참조,완료) 상세조회
	@GetMapping("/detail.do")
	public void detailPage(AppdocDto docNo,Model model,HttpSession session) {
		
		AppdocDto appdoc = appService.detailPage(docNo);
		
		
		String memNo = ((MemberDto)session.getAttribute("loginUser")).getMemNo();
		
		model.addAttribute("app",appdoc);
		model.addAttribute("memNo",memNo);
		
		
	}
	
	
	
//	결재시 update
	@ResponseBody
	@PostMapping("/ajaxSuccess.do")
	public int detailClear(@RequestBody AppdocDto ad, HttpSession session) throws IOException {
		
		
		int result = appService.detailClear(ad);
		
	
		
		
		return result;
	}
	
	
//	반려시 update
	@ResponseBody
	@PostMapping("/ajaxCompanion.do")
	public int detailFail(@RequestBody AppdocDto ad) {
		
		int result = appService.detailFail(ad);
		
		return result;
	}
	
	
//	회수버튼 클릭시
	@ResponseBody
	@PostMapping("/ajaxAppDeleteBack.do")
	public int appDeleteBack(AppdocDto ad) {
		int result = appService.appDeleteBack(ad);
		
		return result;
	}
	
	
	
//	체크한 기안서 삭제
	@ResponseBody
	@PostMapping("/deleteApp.do")
	public int ajaxDeleteCheckApp(@RequestBody Map<String, List<String> >requestBody) {
		
		
		List<String> docNos = requestBody.get("docNos");
		
		log.debug("docNos : {}",requestBody.get("docNos"));
		log.debug("docNos : {}",docNos);
		
		int result = appService.ajaxDeleteCheckApp(docNos);
		
		
		return result;
	}
	
	
	
	
	
	
	
	
	

}
