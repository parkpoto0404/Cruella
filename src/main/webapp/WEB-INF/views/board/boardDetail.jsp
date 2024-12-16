<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en" class="light-style layout-navbar-fixed layout-menu-fixed layout-compact"
      dir="ltr" data-theme="theme-default" data-assets-path="${contextPath}/assets/" data-template="views"
      data-style="light">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${contextPath}/resources/assets/js/config.js"></script>
<style>
.icon-wrapper {
	  position: relative;
	}
	
	.icon-wrapper .icon, .icon-wrapper .comment-icon, .icon-wrapper .modal-comment-icon {
	  border-radius: 50%;
	  padding: 10px;
	  transition: background-color 0.3s, color 0.3s; /* 아이콘 색상 변화를 추가 */
	}
	
	.icon-wrapper .icon:hover, .icon-wrapper .comment-icon:hover, .icon-wrapper .modal-comment-icon:hover {
	  background-color: #f0f0f0;
	  color: #555; /* 호버 시 아이콘 색상 변경 */
	  cursor: pointer;
	}
	
	.action-box, .action-replybox, .modal-action-box {
	  display: none;
	  position: absolute;
	  background: white;
	  border: 1px solid #ddd;
	  border-radius: 5px;
	  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
	  z-index: 1000;
	}
	
	.action-box a, .action-replybox a, .modal-action-box a {
	  display: block;
	  padding: 10px 20px;
	  color: black;
	  text-decoration: none;
	  border-bottom: 1px solid #ddd;
	}
	
	.action-box a:last-child, .action-replybox a:last-child, .modal-action-box a:last-child {
	  border-bottom: none;
	}
	
	.action-box a:hover, .action-replybox a:hover, .modal-action-box a:hover {
	  background-color: #f0f0f0;
	}
	
	.content-pre {
	  white-space: pre-wrap;
	  word-wrap: break-word;
	}
	
	.attachment-list {
	  display: none;
	  background: white;
	  border: 1px solid #ddd;
	  border-radius: 5px;
	  padding: 10px;
	  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
	  width: fit-content;
	  position: absolute;
	  z-index: 1000;
	}
	
	.attachment-toggle-wrapper {
	  position: relative;
	}
	
	.attachment-toggle-wrapper .attachment-list {
	  margin-top: 5px; /* Adjusts spacing between the toggle and list */
	}
	.content-wrapper {
    overflow: visible;
  }
  
  .content pre {
    white-space: pre-wrap; /* 줄 바꿈을 적용하여 내용이 길어질 경우 자동으로 줄 바꿈 */
    word-wrap: break-word; /* 긴 단어가 있을 경우 자동으로 줄 바꿈 */
  }
  #writer, #count {
  	overflow-x: auto; /* 가로 스크롤 활성화 */
	  white-space: nowrap; /* 줄바꿈 방지 */
  }
	#boardTeam::before {
	  content: ''; /* 가상 요소 필수 */
	  display: inline-block; /* 블록 요소 */
	  width: 10px; /* 동그라미 크기 */
	  height: 10px; /* 동그라미 크기 */
	  border-radius: 50%; /* 완전한 원 */
	  background-color: transparent; /* 배경을 투명으로 설정 */
	  border: 2px solid gray; /* 초기 테두리 색상 */
	}
	#boardTeam.active::before {
	  border: 2px solid white; /* 테두리만 흰색으로 변경 */
	}
	.rounded-circle {
    transition: transform 0.3s, border 0.3s;
    cursor: default; /* 호버 시 마우스 커서 모양 유지 */
  }
</style>

</head>
<body>
<div class="layout-wrapper layout-content-navbar">
  <div class="layout-container">
    <!-- 헤더 시작 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <!-- 헤더 끝 -->
    
    <div class="layout-page">
      <!-- nav 시작 -->
      <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
      <!-- nav 끝 -->

      <div class="content-wrapper">
        <div class="container-xxl flex-grow-1 container-p-y">
          <div class="container card" style="padding: 50px;">
            <div style="align-items: center;">
              <div>
                <span style="font-size: 14px;">
                  <c:choose>
                    <c:when test="${loginUser.deptCode eq 'S1'}">영업총괄팀 </c:when>
                    <c:when test="${loginUser.deptCode eq 'S2'}">인사팀 </c:when>
                    <c:when test="${loginUser.deptCode eq 'S3'}">지원팀 </c:when>
                    <c:when test="${loginUser.deptCode eq 'T1'}">남성의류팀 </c:when>
                    <c:when test="${loginUser.deptCode eq 'T2'}">여성의류팀 </c:when>
                    <c:when test="${loginUser.deptCode eq 'T3'}">식품팀 </c:when>
                    <c:when test="${loginUser.deptCode eq 'T4'}">스포츠팀 </c:when>
                    <c:when test="${loginUser.deptCode eq 'T5'}">뷰티팀 </c:when>
                    <c:when test="${loginUser.deptCode eq 'T6'}">명품팀 </c:when>
                    <c:when test="${loginUser.deptCode eq 'T7'}">문화센터팀 </c:when>
                    <c:when test="${loginUser.deptCode eq 'T8'}">디지털 및 가전팀 </c:when>
                    <c:otherwise>기타부서팀</c:otherwise>
                  </c:choose>
                  게시판
                </span><br><br>
                <span style="font-size: 24px; color: black;">${b.boardTitle}</span>
                <br><br>
                <div class="d-flex justify-content-between align-items-center user-info">
                  <div id="writer" class="avatar-wrapper d-flex align-items-center">
                    <div class="avatar me-2">
                      <img src="${contextPath}${b.profileURL}" alt class="rounded-circle"/>
                    </div>
                    <div class="d-flex flex-column">
                      <span class="emp_name text_truncate" style="color: black;">${b.memName}</span>
                    </div>
                    <div class="d-flex flex-column" style="margin-left: 20px;">
                      <span>${b.boardRegistDT}</span>
                    </div>
                  </div>
                  <div class="attachment-toggle-wrapper">
                    <span id="attachment-toggle" style="cursor: pointer;">첨부파일(${b.attachCount})</span>
                    <span id="count" style="margin-left: 20px; color: black;">조회수 (${b.boardCount})</span>
                    <div id="attachment-list" class="attachment-list">
                      <c:forEach var="at" items="${b.attachList}">
                        <a href="${contextPath}${at.filePath}/${at.filesystemName}" download="${at.originalName}">${at.originalName}</a>
                        <br>
                      </c:forEach>
                    </div>
                  </div>
                </div>         
                <br>
                <hr>           
                <c:choose>
                  <c:when test="${ loginUser.memNo == b.memNo }">
                    <div class="d-flex justify-content-end align-items-center">
                      <div class="icon-wrapper">
                        <i class="ti ti-dots-vertical ti-md icon"></i>
                        <div class="action-box dropdown-replymenu dropdown-menu-end" style="margin-left: -60px;">
                          <form id="frm" action="" method="post">
                            <input type="hidden" id="no" name="no" value="" />
                            <a  class="dropdown-item" href="#" onclick="modifyBoardPost(${b.boardNo})">
                              <i class="menu-icon tf-icons ti ti-edit"></i><span>수정</span>
                            </a>
                            <a  class="dropdown-item" href="#" onclick="deleteBoardPost(${b.boardNo})">
                              <i class="menu-icon tf-icons ti ti-trash"></i><span>삭제</span>
                            </a>
                          </form>
                        </div>
                      </div>
                    </div>                  
                  </c:when>
                  <c:otherwise>
                    <br>
                  </c:otherwise>
                </c:choose>                          
                <div class="content-wrapper" style="overflow: visible;">
								  <div class="content">
								    <pre style="font-size: 16px; color: black; font-family: 'Noto Sans KR', sans-serif;">${b.boardContent}</pre>
								  </div>
								</div>
                <br><br>
                
                <div style="display: flex; align-items: center; justify-content: space-between;">
                  <table id="reply_area" class="table" align="center">
                    <thead>
                      <tr>    
                        <th colspan="2" width="650">
                          <textarea class="form-control" id="reply_content" rows="2" style="resize:none; width:100%"></textarea>
                        </th>
                        <th style="vertical-align: middle"><button class="btn btn-secondary" style="text-align: center;" onclick="fn_insertReply();">등록</button></th>
                      </tr>
                      <tr>
                        <td colspan="3">댓글 (<span id="rcount">0</span>) </td> 
                      </tr>
                    </thead>
                    <tbody>
                                                                    
                    </tbody>
                  </table>
                </div>
                <div style="display: flex; justify-content: center; margin-top: 20px;">
                  <button id="back" class="btn btn-label-secondary" style="text-align: center;" onclick="boardList();">목록</button>
                </div>
								
								<!-- Modal -->
								<div class="modal fade" id="modalScrollable" tabindex="-1" aria-hidden="true">
								  <div class="modal-dialog modal-dialog-scrollable" role="document">
								    <div class="modal-content">
								      <div class="modal-header">
								        <div style="width: 100%;">
								          <div class="d-flex justify-content-between align-items-center" style="margin: 10px;">
								            <div class="avatar-wrapper d-flex align-items-center">
								              <div class="avatar me-2">
								                <img src="#" alt class="rounded-circle"/>
								              </div>
								              <div class="d-flex flex-column">
								                <span class="emp_name text_truncate" id="modal-author" style="color: black;"></span>
								              </div>
								              <div class="d-flex flex-column" style="margin-left: 20px;">
								                <span id="modal-date"></span>
								              </div>
								            </div>
								          </div>
								          <p id="modal-content" style="margin-left: 40px; margin-top: 20px; color: black;"></p>
								        </div>
								        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								      </div>
								
								      <div class="modal-body">
								        <table id="reply_table" class="table">
								          <tbody>
								            <!-- AJAX를 통해 동적으로 대댓글을 추가할 영역 -->
								          </tbody>
								        </table>
								      </div>
								
								      <div class="modal-footer">
								        <div id="reply_div" style="display: flex; align-items: center; justify-content: space-between; width: 100%;">
								
								        </div>
								      </div>
								    </div>
								  </div>
								</div>


              </div>
            </div>
          </div>
        </div>
        <!-- 푸터 시작 -->
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
        <!-- 푸터 끝 -->
        <div class="content-backdrop fade"></div>
      </div>
      <!-- nav layout page 닫기 -->
    </div>
    <!-- layout-container 닫기 -->
  </div>
  <!-- layout wrapper 닫기 -->
  <form id="frm" method="post">
    <input type="hidden" id="no" name="replyNo" value="" />
  </form>
</div>
<!-- Overlay -->
<div class="layout-overlay layout-menu-toggle"></div>
<!-- Drag Target Area To SlideIn Menu On Small Screens -->
<div class="drag-target"></div>
</body>
<script>


// 쿠키에서 스크롤 위치를 가져오는 함수
function getScrollPositionFromCookie() {
  var name = "scrollPosition=";
  var decodedCookie = decodeURIComponent(document.cookie);
  var ca = decodedCookie.split(';');
  for (var i = 0; i < ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) === ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) === 0) {
      return c.substring(name.length, c.length);
    }
  }
  return null;
}

// 페이지 로드 시 스크롤 위치를 복원하는 함수
function restoreScrollPosition() {
  var scrollPosition = getScrollPositionFromCookie();
  if (scrollPosition !== null) {
    window.scrollTo(0, parseInt(scrollPosition));
  }
}

// 페이지 로드 시 스크롤 위치를 복원
window.onload = restoreScrollPosition;



//수정할 댓글 번호를 저장할 변수
let currentReplyNo;

$(document).ready(function(){
  fn_replyList(); // 페이지 로드 시 댓글 목록 불러오기
  
  
  
  // 아이콘 클릭 시 액션 박스 표시
  $(document).on('click', '.icon', function() {
    $(this).next('.action-replybox').toggle();
  });

  // 클릭 시 외부 영역 클릭하면 액션 박스 숨기기
  $(document).on('click', function(e) {
    if (!$(e.target).closest('.icon-wrapper').length) {
      $('.action-replybox').hide();
    }
  });

  // attachment-toggle 클릭 시 첨부파일 목록 표시
  $(document).on('click', '#attachment-toggle', function(e) {
    e.stopPropagation();
    $('#attachment-list').toggle();
  });

  // 클릭 시 외부 영역 클릭하면 첨부파일 목록 숨기기
  $(document).on('click', function(e) {
    if (!$(e.target).closest('.attachment-toggle-wrapper').length) {
      $('#attachment-list').hide();
    }
  });

  // 클릭 이벤트 전파 중지 (첨부파일 리스트 내에서)
  $('#attachment-list').on('click', function(e) {
    e.stopPropagation();
  });
});

var loginUserMemNo = "${loginUser.memNo}";

function fn_replyList() {
	  $.ajax({
	    url: '${contextPath}/board/rlist.do',
	    data: { no: ${b.boardNo} },
	    success: function(resData) {
	      $("#rcount").text(resData.length); // 댓글 수 출력
	      let tr = "";
	      for (let i = 0; i < resData.length; i++) {
	        tr += "<tr data-replyno='" + resData[i].replyNo + "'><td colspan='3'>"
	            + "<div class='d-flex justify-content-between align-items-center user-info'>"
	            + "<div class='avatar-wrapper d-flex align-items-center'>"
	            + "<div class='avatar me-2'>"
	            + "<img src='${contextPath}" + resData[i].profileURL + "' alt='Avatar' class='rounded-circle' />"
	            + "</div>"
	            + "<div class='d-flex align-items-center'>"
	            + "<span class='emp_name text_truncate' style='color: black; margin-right: 20px;'>" + resData[i].memName + "</span>"
	            + "<span>" + resData[i].replyRegistDT + "</span>"
	            + "</div></div>";

	        // 댓글 작성자가 로그인한 사용자와 같은지 확인
	        if (loginUserMemNo == resData[i].memNo) {
	          tr += "<div class='d-flex justify-content-end align-items-center'>"
	              + "<div class='icon-wrapper'>"
	              + "<i class='ti ti-dots-vertical ti-md comment-icon' style='cursor: pointer;'></i>"
	              + "<div class='action-replybox dropdown-replymenu dropdown-menu-end' style='margin-left: -60px;'>"
	              + "<form id='rfrm' action='' method='post'>"
	              + "<input type='hidden' id='replyNo' name='replyNo' value='' />"
	              + "<a class='dropdown-item' href='#' onclick='modifyReply(" + resData[i].replyNo + ", `" + resData[i].replyContent + "`)'>"
	              + "<i class='menu-icon tf-icons ti ti-edit'></i><span>수정</span></a>"
	              + "<a class='dropdown-item' href='#' onclick='deleteReply(" + resData[i].replyNo + ")'>"
	              + "<i class='menu-icon tf-icons ti ti-trash'></i><span>삭제</span></a>"
	              + "</form>"
	              + "</div></div></div>";
	        } else {
	          tr += "<br>";
	        }

	        tr += "</div><br>"
	            + "<div class='reply-content' style='margin-left: 30px; white-space: pre-wrap; color: black; word-break: break-all;'>" + resData[i].replyContent + "</div><br><br>"
	            + "<button type='button' class='btn btn-sm btn-outline-secondary' data-bs-toggle='modal' data-bs-target='#modalScrollable' data-reply-id='" + resData[i].replyNo + "' data-reply-content='" + resData[i].replyContent + "' data-reply-author='" + resData[i].memName + "' data-reply-date='" + resData[i].replyRegistDT + "' data-reply-memno='" + resData[i].memNo + "' data-reply-profileurl='" + resData[i].profileURL + "'>답글 <span id='reply-count-" + resData[i].replyNo + "'>(0)</span></button>"
	            + "</td></tr>";

	        // 답글 수를 가져와서 버튼에 표시
	        fn_getRreplyCount(resData[i].replyNo);
	      }

	      $("#reply_area tbody").html(tr);
	    },
	    error: function(xhr, status, error) {
	      console.error("에러 발생:", status, error);
	    }
	  });
	}



// 답글 수를 가져오는 함수
function fn_getRreplyCount(replyId) {
  $.ajax({
    url: '${contextPath}/board/rrcount.do', // 대댓글 수를 반환하는 엔드포인트
    data: { replyNo: replyId },
    success: function(resData) {
      $("#reply-count-" + replyId).text("(" + resData + ")");
    },
    error: function(xhr, status, error) {
      console.error("에러 발생:", status, error);
    }
  });
}


// 댓글 등록용 (ajax) 함수
function fn_insertReply(){
  $.ajax({
    url: '${contextPath}/board/rinsert.do',
    type: 'post',
    data: {
      replyContent: $("#reply_content").val(),
      boardNo: ${b.boardNo}
    },
    success: function(resData){
      if(resData === "SUCCESS"){
        fn_replyList();
        $("#reply_content").val("");
      } else {
        alert("댓글 작성 실패");
      }
    },
    error: function(xhr, status, error) {
      console.error("에러 발생:", status, error);
    }
  });
}

function fn_insertRreply(replyId) {
  var replyContent = $("#rreply_content").val();
  $.ajax({
    url: '${contextPath}/board/rrinsert.do',
    type: 'post',
    data: {
      replyContent: replyContent,
      boardNo: ${b.boardNo},
      replyRef: replyId
    },
    success: function(resData){
      if (resData === "SUCCESS") {
    	  fn_replyList(); // 댓글 목록 갱신
        fn_rreplyList(replyId); // 대댓글 목록 새로고침
        $("#rreply_content").val(""); // 입력 필드 초기화
      } else {
        alert("대댓글 작성 실패");
      }
    },
    error: function(xhr, status, error) {
      console.error("에러 발생:", status, error);
    }
  });
}

function fn_rreplyList(replyId) {
	  $.ajax({
	    url: '${contextPath}/board/rrlist.do',
	    data: { bno: ${b.boardNo}, nno: replyId },
	    success: function(resData) {
	      $("#rrcount").text(resData.length); // 대댓글 수 출력

	      let tr = "";
	      for (let i = 0; i < resData.length; i++) {
	        tr += "<tr data-replyno='" + resData[i].replyNo + "'><td colspan='3'>"
	            + "<div class='d-flex justify-content-between align-items-center user-info'>"
	            + "<div class='avatar-wrapper d-flex align-items-center'>"
	            + "<div class='avatar me-2 d-flex justify-content-between'>"
	            + "<i class='menu-icon tf-icons ti ti-currency-leu' style='margin-right: auto; font-size: 40px; margin-top: -10px;'></i>"
	            + "<img src='${contextPath}" + resData[i].profileURL + "' alt='Avatar' class='rounded-circle' />"
	            + "</div>"
	            + "<div class='d-flex flex-column'>"
	            + "<span class='emp_name text_truncate' style='color: black; margin-left: 40px;'>" + resData[i].memName + "</span>"
	            + "</div>"
	            + "<div class='d-flex flex-column' style='margin-left: 20px;'>"
	            + "<span>" + resData[i].replyRegistDT + "</span>"
	            + "</div></div>";


        // 댓글 작성자가 로그인한 사용자와 같은지 확인
        if (loginUserMemNo == resData[i].memNo) {
          tr += "<div class='d-flex justify-content-end align-items-center'>"
              + "<div class='icon-wrapper'>"
              + "<i class='ti ti-dots-vertical ti-md comment-icon' style='cursor: pointer;'></i>"
              + "<div class='action-replybox dropdown-replymenu dropdown-menu-end' style='margin-left: -60px;'>"
              + "<form id='rfrm' action='' method='post'>"
              + "<input type='hidden' id='replyNo' name='replyNo' value='' />"
              + "<a class='dropdown-item' href='#' onclick='modalModifyReply(" + resData[i].replyNo + ", `" + resData[i].replyContent + "`)'>"
              + "<i class='menu-icon tf-icons ti ti-edit'></i><span>수정</span></a>"
              + "<a class='dropdown-item' href='#' onclick='modalDeleteReply(" + resData[i].replyNo + ")'>"
              + "<i class='menu-icon tf-icons ti ti-trash'></i><span>삭제</span></a>"
              + "</form>"
              + "</div></div></div>";
        } else {
          tr += "<br>";
        }

        tr += "</div><br>"
            + "<div class='reply-content' style='margin-left: 30px; white-space: pre-wrap; color: black; word-break: break-all;'>" + resData[i].replyContent + "</div><br><br>"
            + "</td></tr>";
      }

      // reply_table HTML 업데이트
      $("#reply_table tbody").html(tr);

      // reply_div HTML 내용
      let replyDivContent = "<div class='input' style='flex-grow: 1;'>"
                          + "<textarea id='rreply_content' class='form-control' aria-label='With textarea' placeholder='답글을 입력해주세요.' style='width: 100%; border: 0px; resize: none;'></textarea>"
                          + "</div>"
                          + "<div>"
                          + "<button id='regist' class='btn btn-sm btn-outline-secondary' style='text-align: center; margin-left: 10px;' onclick='fn_insertRreply(" + replyId + ");'>등록</button>"
                          + "</div>";

      // reply_div HTML 업데이트
      $("#reply_div").html(replyDivContent);
    },
    error: function(xhr, status, error) {
      console.error("에러 발생:", status, error);
    }
  });
}





//게시글 수정
function modifyBoardPost(boardNo) {
  var form = document.getElementById('frm');
  form.setAttribute('action', '${contextPath}/board/boardModify.do');
  document.getElementById('no').value = boardNo;
  form.submit();
}

// 게시글 삭제
function deleteBoardPost(boardNo) {
  if (confirm('정말로 삭제하시겠습니까?')) {
    var form = document.getElementById('frm');
    form.setAttribute('action', '${contextPath}/board/boardDelete.do');
    document.getElementById('no').value = boardNo;
    form.submit();
  }
}



//모달을 열 때 넘버 값을 설정
$(document).on('show.bs.modal', '#modalScrollable', function(event) {
  var button = $(event.relatedTarget);
  var replyId = button.data('reply-id');
  var replyContent = button.data('reply-content');
  var replyAuthor = button.data('reply-author');
  var replyDate = button.data('reply-date');
  var replyMemNo = button.data('reply-memno');
  var profileURL = button.data('reply-profileurl');
  var modal = $(this);

  modal.find('#modal-author').text(replyAuthor);
  modal.find('#modal-date').text(replyDate);
  modal.find('#modal-content').html(replyContent);  // <br> 태그를 HTML로 인식하도록 변경
  modal.find('.avatar img').attr('src', '${contextPath}' + profileURL); // 프로필 이미지 설정

  // 작성자인 경우에만 ... 아이콘 보이게 설정
  if (replyMemNo == loginUserMemNo) {
    modal.find('.modal-comment-icon').show();
  } else {
    modal.find('.modal-comment-icon').hide();
  }

  // 수정 및 삭제 버튼에 이벤트 핸들러 설정
  modal.find('#modal-modify').off('click').on('click', function() {
    modifyReply(replyId, replyContent);
  });
  modal.find('#modal-delete').off('click').on('click', function() {
    deleteReply(replyId);
  });

  // 등록 버튼에 replyId 할당
  modal.find('#regist').attr('onclick', `fn_insertRreply(${replyId})`);

  // 대댓글 목록을 불러옵니다.
  fn_rreplyList(replyId);
});


function modifyReply(replyNo, replyContent) {
  // 현재 수정 중인 댓글의 최신 내용을 가져옴
  let replyRow = $("tr[data-replyno='" + replyNo + "']");
  let contentDiv = replyRow.find(".reply-content");

  // 최신 내용을 가져옴
  let latestContent = replyRow.data('replycontent') || replyContent;

  // 기존 댓글 내용을 백업
  let originalContent = contentDiv.html();

  // 기존 내용을 텍스트로 변환하여 input 창에 표시
  let decodedContent = $('<div/>').html(latestContent).text();

  let inputHtml = "<textarea class='form-control reply-edit-content' aria-label='With textarea' style='width: 80%; resize: none;'>" + decodedContent + "</textarea>";
  let saveButtonHtml = "<button class='btn btn-sm btn-label-info' style='text-align: center; margin-left: 10px; margin-top: 5px;' onclick='saveReply(" + replyNo + ");'>수정</button>";
  let cancelButtonHtml = "<button class='btn btn-sm btn-label-dark' style='text-align: center; margin-left: 10px; margin-top: 5px;' onclick='cancelModifyReply(" + replyNo + ", `" + originalContent + "`);'>취소</button>";

  contentDiv.html(inputHtml + saveButtonHtml + cancelButtonHtml);

  // 수정 아이콘이 있던 box 닫기
  let iconWrapper = replyRow.find(".icon-wrapper");
  iconWrapper.hide();
  $('#modalScrollable').modal('hide');
  
  // input 창에 포커스 맞추기
  setTimeout(function() {
    contentDiv.find('.reply-edit-content').focus();
  }, 500);
  
}

function saveReply(replyNo) {
  
  let replyRow = $("tr[data-replyno='" + replyNo + "']");
  let editedContent = replyRow.find(".reply-edit-content").val();

  // 서버에 댓글 수정 요청 전송
  $.ajax({
    url: '${contextPath}/board/updateReply.do',
    type: 'POST',
    data: { replyNo: replyNo, content: editedContent }, // 'content' 파라미터 추가
    success: function(resData) {
      // 수정된 댓글 내용으로 업데이트
      replyRow.find(".reply-content").html(editedContent);
      replyRow.find(".icon-wrapper").show(); // 수정 완료 후 아이콘 다시 표시

      // replyRow에 데이터 속성으로 업데이트된 내용을 저장
      replyRow.data('replycontent', editedContent);
      fn_replyList(); // 댓글 목록 갱신
    },
    error: function(xhr, status, error) {
      console.error("댓글 수정 중 에러 발생:", status, error);
    }
  });
}

function cancelModifyReply(replyNo, originalContent) {
  
  let replyRow = $("tr[data-replyno='" + replyNo + "']");
  let contentDiv = replyRow.find(".reply-content");

  // 수정 취소 시 원래 내용으로 복원
  contentDiv.html(originalContent);

  // 수정 취소 후 아이콘 다시 표시
  replyRow.find(".icon-wrapper").show();
}

function deleteReply(replyNo) {
  

  // 삭제 확인 알림
  if (confirm('정말로 이 댓글을 삭제하시겠습니까?')) {
		
	  
		
    // 서버에 댓글 삭제 요청 전송
    $.ajax({
      url: '${contextPath}/board/deleteReplyCompletely.do',
      type: 'POST',
      data: { replyNo: replyNo },
      success: function(resData) {
        // 댓글 삭제 후 목록 갱신
        $("tr[data-replyno='" + replyNo + "']").remove();
        
        
        
        fn_replyList(); // 댓글 목록 갱신
        $('#modalScrollable').modal('hide');    
      },
      error: function(xhr, status, error) {
        console.error("댓글 삭제 중 에러 발생:", status, error);
      }
    });
  }
}


// 모달 내의 ... 아이콘 클릭 시 액션 박스를 토글하는 함수
function toggleModalActionBox(icon) {
  // 모든 드롭다운 메뉴를 닫음
  document.querySelectorAll('.modal-action-box').forEach(menu => {
    menu.style.display = 'none';
  });

  // 클릭한 드롭다운 메뉴를 토글
  var dropdownMenu = icon.nextElementSibling;
  if (dropdownMenu.style.display === 'none' || dropdownMenu.style.display === '') {
    dropdownMenu.style.display = 'block';
  } else {
    dropdownMenu.style.display = 'none';
  }
}

// 페이지가 로드될 때 모든 드롭다운 메뉴를 숨기기
document.addEventListener('DOMContentLoaded', () => {
  const dropdownMenus = document.querySelectorAll('.modal-action-box');
  dropdownMenus.forEach(menu => {
    menu.style.display = 'none';
  });

  // 외부 클릭 이벤트 처리 (모든 dropdown-menu 숨기기)
  document.addEventListener('click', (e) => {
    if (!e.target.closest('.icon-wrapper') && !e.target.matches('.ti-dots-vertical')) {
      document.querySelectorAll('.modal-action-box').forEach(box => {
        box.style.display = 'none';
      });
    } else {
      const targetMenu = e.target.closest('.icon-wrapper').querySelector('.modal-action-box');
      document.querySelectorAll('.modal-action-box').forEach(box => {
        if (box !== targetMenu) {
          box.style.display = 'none';
        }
      });
    }
  });

  // 모달이 닫힐 때 모든 드롭다운 메뉴를 숨기기
  $('#modalScrollable').on('hide.bs.modal', function () {
    const dropdownMenus = document.querySelectorAll('.modal-action-box');
    dropdownMenus.forEach(box => {
      box.style.display = 'none';
    });
  });
});


function modalModifyReply(replyNo, replyContent) {
  // 현재 수정 중인 대댓글의 최신 내용을 가져옴
  let replyRow = $("tr[data-replyno='" + replyNo + "']");
  let contentDiv = replyRow.find(".reply-content");

  // 최신 내용을 가져옴
  let latestContent = replyRow.data('replycontent') || replyContent;

  // 기존 대댓글 내용을 백업
  let originalContent = contentDiv.html();

  // 기존 내용을 텍스트로 변환하여 input 창에 표시
  let decodedContent = $('<div/>').html(latestContent).text();

  let inputHtml = "<textarea class='form-control reply-edit-content' aria-label='With textarea' style='width: 80%; resize: none;'>" + decodedContent + "</textarea>";
  let saveButtonHtml = "<button class='btn btn-sm btn-label-info' style='text-align: center; margin-left: 10px; margin-top: 5px;' onclick='modalSaveReply(" + replyNo + ");'>수정</button>";
  let cancelButtonHtml = "<button class='btn btn-sm btn-label-dark' style='text-align: center; margin-left: 10px; margin-top: 5px;' onclick='cancelModifyReply(" + replyNo + ", `" + originalContent + "`);'>취소</button>";

  contentDiv.html(inputHtml + saveButtonHtml + cancelButtonHtml);

  // 수정 아이콘이 있던 box 닫기
  let iconWrapper = replyRow.find(".icon-wrapper");
  iconWrapper.hide();
}


function modalSaveReply(replyNo) {
  let replyRow = $("tr[data-replyno='" + replyNo + "']");
  let editedContent = replyRow.find(".reply-edit-content").val();

  // 서버에 대댓글 수정 요청 전송
  $.ajax({
    url: '${contextPath}/board/updateReply.do',
    type: 'POST',
    data: { replyNo: replyNo, content: editedContent }, // 'content' 파라미터 추가
    success: function(resData) {
      // 수정된 대댓글 내용으로 업데이트
      replyRow.find(".reply-content").html(editedContent);
      replyRow.find(".icon-wrapper").show(); // 수정 완료 후 아이콘 다시 표시

      // replyRow에 데이터 속성으로 업데이트된 내용을 저장
      replyRow.data('replycontent', editedContent);
    },
    error: function(xhr, status, error) {
      console.error("대댓글 수정 중 에러 발생:", status, error);
    }
  });
}


function cancelModifyReply(replyNo, originalContent) {
  let replyRow = $("tr[data-replyno='" + replyNo + "']");
  let contentDiv = replyRow.find(".reply-content");

  // 수정 취소 시 원래 내용으로 복원
  contentDiv.html(originalContent);

  // 수정 취소 후 아이콘 다시 표시
  replyRow.find(".icon-wrapper").show();
}



function modalDeleteReply(replyNo) {
	  // 삭제 확인 알림
	  if (confirm('정말로 이 대댓글을 삭제하시겠습니까?')) {
	    // 서버에 대댓글 삭제 요청 전송
	    $.ajax({
	      url: '${contextPath}/board/deleteReplyCompletely.do',
	      type: 'POST',
	      data: { replyNo: replyNo },
	      success: function(resData) {
	        // 대댓글 삭제 후 목록 갱신
	        $("tr[data-replyno='" + replyNo + "']").remove();
	        fn_replyList(); // 댓글 목록 갱신
	      },
	      error: function(xhr, status, error) {
	        console.error("대댓글 삭제 중 에러 발생:", status, error);
	      }
	    });
	  }
	}





function boardList() {
  window.location.href = '${contextPath}/board/boardList.do';
}

document.addEventListener('DOMContentLoaded', () => {
  // 이벤트 위임을 사용하여 동적으로 생성된 요소를 처리
  document.body.addEventListener('click', (e) => {
    // 게시글의 .icon 클릭 처리
    if (e.target.matches('.icon')) {
      const actionBox = e.target.closest('.icon-wrapper').querySelector('.action-box');
      if (actionBox) {
        actionBox.style.display = actionBox.style.display === 'none' || !actionBox.style.display ? 'block' : 'none';
        hideOtherBoxes('.action-box', actionBox);
        
      }
    }

    // 댓글의 .comment-icon 클릭 처리
    if (e.target.matches('.comment-icon')) {
      const replyBox = e.target.closest('.icon-wrapper').querySelector('.action-replybox');
      if (replyBox) {
        replyBox.style.display = replyBox.style.display === 'none' || !replyBox.style.display ? 'block' : 'none';
        hideOtherBoxes('.action-replybox', replyBox);
        
      }
    }

    // attachment-toggle 클릭 처리
    if (e.target.matches('#attachment-toggle')) {
      e.stopPropagation();
      const attachmentList = document.getElementById('attachment-list');
      attachmentList.style.display = attachmentList.style.display === 'none' || !attachmentList.style.display ? 'block' : 'none';
      hideOtherBoxes('.attachment-list', attachmentList);
    }
  });

  // 외부 클릭 이벤트 처리 (모든 action-box, action-replybox 및 attachment-list 숨기기)
  document.addEventListener('click', (e) => {
    document.querySelectorAll('.action-box').forEach(box => {
      if (!box.contains(e.target) && !e.target.matches('.icon')) {
        box.style.display = 'none';
      }
    });

    document.querySelectorAll('.action-replybox').forEach(box => {
      if (!box.contains(e.target) && !e.target.matches('.comment-icon')) {
        box.style.display = 'none';
      }
    });

    const attachmentList = document.getElementById('attachment-list');
    if (attachmentList && !attachmentList.contains(e.target) && e.target.id !== 'attachment-toggle') {
      attachmentList.style.display = 'none';
    }
  });

  // 클릭 이벤트 전파 중지 (첨부파일 리스트 내에서)
  const attachmentList = document.getElementById('attachment-list');
  if (attachmentList) {
    attachmentList.addEventListener('click', (e) => {
      e.stopPropagation();
    });
  }

  // 다른 상자 숨기기 함수
  function hideOtherBoxes(selector, currentBox) {
    document.querySelectorAll(selector).forEach(box => {
      if (box !== currentBox) {
        box.style.display = 'none';
      }
    });
  }

  // 첫 번째 모달이 닫힐 때도 액션 박스를 닫도록 설정
  $('#modalScrollable').on('hide.bs.modal', function () {
    const actionBoxes = document.querySelectorAll('.modal-action-box, .action-replybox');
    actionBoxes.forEach(box => {
      box.style.display = 'none';
    });
  });
});

//사이드바 처리
document.addEventListener("DOMContentLoaded", function () {
	
	const element = document.getElementById("boardTeam");
	
	document.getElementById("boardSide").classList.add("open");
	element.style.backgroundColor = "#958CF4";
	element.style.color = "white";
	element.classList.add("active");
	
	
});
</script>
</html>