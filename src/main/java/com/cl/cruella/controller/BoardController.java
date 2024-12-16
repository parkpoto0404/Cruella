package com.cl.cruella.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cl.cruella.dto.AttachDto;
import com.cl.cruella.dto.BoardDto;
import com.cl.cruella.dto.MemberDto;
import com.cl.cruella.dto.PageInfoDto;
import com.cl.cruella.dto.ReplyDto;
import com.cl.cruella.service.BoardService;
import com.cl.cruella.util.FileUtil;
import com.cl.cruella.util.PagingUtil;
import com.cl.cruella.util.StringUtil;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {
	
	private final BoardService boardService;
	private final PagingUtil pagingUtil;
	private final FileUtil fileUtil;
	
	@GetMapping("/boardList.do")
    public String list(@RequestParam(value = "page", defaultValue = "1") int currentPage, Model model, HttpSession session) {
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/signin.do"; // 로그인 페이지로 리디렉션
        }

        String loggedInDeptCode = loginUser.getDeptCode();
        if (loggedInDeptCode == null) {
            model.addAttribute("error", "부서 코드가 설정되지 않았습니다.");
            return "errorPage"; // 에러 페이지로 리디렉션
        }

        int listCount = boardService.selectBoardListCount(loggedInDeptCode);

        PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);

        Map<String, Object> params = new HashMap<>();
        params.put("pi", pi);
        params.put("deptCode", loggedInDeptCode);

        List<BoardDto> list = boardService.selectBoardList(params);

        model.addAttribute("pi", pi);
        model.addAttribute("list", list);

        return "board/boardList";
    }


	@GetMapping("/increase.do") // 조회수 증가용 (타인의 글일 경우 호출) => /board/detail.do 재요청
	public String increaseCount(int no) {
		boardService.updateIncreaseCount(no);
		return "redirect:/board/boardDetail.do?no=" + no;
	}
	
	@GetMapping("/boardDetail.do")
	public void detail(int no, Model model) {
		// 상세페이지에 필요한 데이터
		// 게시글(제목,작성자,작성일,내용) 데이터, 첨부파일(원본명,저장경로,실
		BoardDto b = boardService.selectBoard(no);
		// boardNo, boardTitle, boardContent, boardWriter, registDt, attachList
		
		model.addAttribute("b", b);
	}
		
	@GetMapping("/boardRegist.do")
	public void boardRegistPage() {
		
	}
	
	@PostMapping("/boardInsert.do")
	public String regist(BoardDto board
					   , List<MultipartFile> uploadFiles
					   , HttpSession session
					   , RedirectAttributes rdAttributes) {
		
		// board테이블에 insert할 데이터 
		board.setMemNo( String.valueOf( ((MemberDto)session.getAttribute("loginUser")).getMemNo() ) );
		
		// 첨부파일 업로드 후에 
		// attachment테이블에 insert할 데이터
		List<AttachDto> attachList = new ArrayList<>();
		for(MultipartFile file : uploadFiles) {
			if(file != null && !file.isEmpty()) {
				Map<String, String> map = fileUtil.fileupload(file, "board");
				attachList.add(AttachDto.builder()
										.filePath(map.get("filePath"))
										.originalName(map.get("originalName"))
										.filesystemName(map.get("filesystemName"))
										.refType("B")
										.build());
			}
		}
		board.setAttachList(attachList); // 제목,내용,작성자회원번호,첨부파일들정보
		
		int result = boardService.insertBoard(board);
		
		if(attachList.isEmpty() && result == 1 
				|| !attachList.isEmpty() && result == attachList.size()) {
			rdAttributes.addFlashAttribute("alertMsg", "게시글 등록 성공");
		}else {
			rdAttributes.addFlashAttribute("alertMsg", "게시글 등록 실패");			
		}
		
		return "redirect:/board/boardList.do";
		
	}
	
	@PostMapping("/boardModify.do")
	public String modifyPage(@RequestParam("no") int no, Model model) {
	    model.addAttribute("b", boardService.selectBoard(no));
	    return "board/boardModify";
	}


	@PostMapping("/boardUpdate.do")
	public String modify(BoardDto board 		// 번호,제목,내용
					   , String[] delFileNo   // null | 삭제할첨부파일번호들
					   , List<MultipartFile> uploadFiles // 새로넘어온첨부파일들
					   , RedirectAttributes rdAttributes ) {
		
		// 후에 db에 반영 성공시 삭제할 파일들 삭제 위해 미리 조회
		List<AttachDto> delAttachList = boardService.selectDelAttach(delFileNo);
		
		List<AttachDto> attachList = new ArrayList<>();
		for(MultipartFile file : uploadFiles) {
			if(file != null && !file.isEmpty()) {
				Map<String, String> map = fileUtil.fileupload(file, "board");
				attachList.add(AttachDto.builder()
										.filePath(map.get("filePath"))
										.originalName(map.get("originalName"))
										.filesystemName(map.get("filesystemName"))
										.refType("B")
										.refNo(board.getBoardNo())
										.build());	
			}
		}
		board.setAttachList(attachList);
		
		int result = boardService.updateBoard(board, delFileNo);
		
		if(result > 0) { // 성공
			rdAttributes.addFlashAttribute("alertMsg", "성공적으로 수정되었습니다.");
			for(AttachDto at : delAttachList) {
				new File(at.getFilePath() + "/" + at.getFilesystemName()).delete();
			}
		}else { // 실패
			rdAttributes.addFlashAttribute("alertMsg", "게시글 수정에 실패했습니다.");
		}
		
		return "redirect:/board/boardDetail.do?no=" + board.getBoardNo();
		
	}


	@GetMapping("/boardSearch.do")
	public String search(@RequestParam(value="page", defaultValue="1") int currentPage
					   , @RequestParam Map<String, String> search
					   , Model model) {
		// Map<String,String> search ==> {condition=user_id|board_title|board_content, keyword=란}
		
		int listCount = boardService.selectSearchListCount(search);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		List<BoardDto> list = boardService.selectSearchList(search, pi);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("search", search);
		
		
		return "board/boardList";
	}

	@ResponseBody
	@GetMapping(value="/rlist.do", produces="application/json")
	public List<ReplyDto> replyList(int no) {
	    List<ReplyDto> replies = boardService.selectReplyList(no);
	    return replies;
	}
	
	@ResponseBody
	@GetMapping(value="/rrlist.do", produces="application/json")
	public List<ReplyDto> replyList(int bno, int nno) {
	    List<ReplyDto> replies = boardService.selectReplyList(bno, nno);
	    return replies;
	}
	
	@ResponseBody
	@PostMapping("/rinsert.do")
	public String replyInsert(ReplyDto r, HttpSession session) {
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "FAIL: Please log in first.";
        }

        // 댓글 내용의 줄바꿈을 <br> 태그로 변환
        r.setReplyContent(StringUtil.convertNewlinesToBreaks(r.getReplyContent()));

        r.setMemNo(String.valueOf(loginUser.getMemNo()));
        int result = boardService.insertReply(r);
        return result > 0 ? "SUCCESS" : "FAIL";
	}
	
	@ResponseBody
	@PostMapping("/rrinsert.do")
	public String rreplyInsert(ReplyDto r, HttpSession session) {
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "FAIL: Please log in first.";
        }

        // 대댓글 내용의 줄바꿈을 <br> 태그로 변환
        r.setReplyContent(StringUtil.convertNewlinesToBreaks(r.getReplyContent()));

        r.setMemNo(String.valueOf(loginUser.getMemNo()));
        r.setReplyType(1); // 대댓글(replyType=1) 설정
        int result = boardService.insertRreply(r);
        return result > 0 ? "SUCCESS" : "FAIL";
	}

	@ResponseBody
    @PostMapping("/deleteReplyCompletely.do")
    public Map<String, Object> deleteReplyCompletely(@RequestParam(value = "replyNo", required = false) Integer replyNo) {
        Map<String, Object> result = new HashMap<>();
        if (replyNo == null) {
            result.put("status", "FAIL");
            result.put("message", "Invalid reply number.");
            return result;
        }
        int deleteResult = boardService.deleteReplyCompletely(replyNo);
        result.put("status", deleteResult > 0 ? "SUCCESS" : "FAIL");
        return result;
    }
	
	@ResponseBody
    @PostMapping("/updateReply.do")
    public Map<String, Object> updateReply(@RequestParam("replyNo") int replyNo, @RequestParam("content") String content) {
        Map<String, Object> result = new HashMap<>();
        int updateResult = boardService.updateReply(replyNo, content);
        result.put("status", updateResult > 0 ? "SUCCESS" : "FAIL");
        return result;
    }
	
	@PostMapping("/boardDelete.do")
	public String remove(@RequestParam("no") int no, RedirectAttributes rdAttributes) {
	    int result = boardService.deleteBoard(no);
	    
	    if (result > 0) {
	        rdAttributes.addFlashAttribute("alertMsg", "성공적으로 삭제되었습니다.");
	    } else {
	        rdAttributes.addFlashAttribute("alertMsg", "게시글 삭제에 실패하였습니다.");
	    }
	    
	    return "redirect:/board/boardList.do";
	}

	@PostMapping("/deleteSelectedPosts.do")
	public String deleteSelectedPosts(@RequestParam("boardNos") List<Integer> boardNos,  RedirectAttributes rdAttributes) {
		int result = boardService.deleteSelectedPosts(boardNos);
	    
        if (result > 0) {
            rdAttributes.addFlashAttribute("alertMsg", "선택된 게시글이 성공적으로 삭제되었습니다.");
        } else {
            rdAttributes.addFlashAttribute("alertMsg", "게시글 삭제에 실패하였습니다.");
        }
	    return "redirect:/board/boardList.do";
	}

	@GetMapping("/rrcount.do")
	@ResponseBody
	public int getRreplyCount(@RequestParam int replyNo) {
	    return boardService.getRreplyCount(replyNo);
	}
	
	
}
