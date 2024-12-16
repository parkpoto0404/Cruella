<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	.action-box, .modal-action-box {
	  display: none;
	  position: absolute;
	  background: white;
	  border: 1px solid #ddd;
	  border-radius: 5px;
	  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
	  z-index: 1000;
	}
	
	.action-box a, .modal-action-box a {
	  display: block;
	  padding: 10px 20px;
	  color: black;
	  text-decoration: none;
	  border-bottom: 1px solid #ddd;
	}
	
	.action-box a:last-child, .modal-action-box a:last-child {
	  border-bottom: none;
	}
	
	.action-box a:hover, .modal-action-box a:hover {
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
	#boardNotice::before {
	  content: ''; /* 가상 요소 필수 */
	  display: inline-block; /* 블록 요소 */
	  width: 10px; /* 동그라미 크기 */
	  height: 10px; /* 동그라미 크기 */
	  border-radius: 50%; /* 완전한 원 */
	  background-color: transparent; /* 배경을 투명으로 설정 */
	  border: 2px solid gray; /* 초기 테두리 색상 */
	}
	#boardNotice.active::before {
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
                <span style="font-size: 14px;">공지사항</span><br><br>
                <span style="font-size: 24px; color: black;">${n.noticeTitle}</span>
                <br><br>
                <div class="d-flex justify-content-between align-items-center user-info">
                  <div id="writer" class="avatar-wrapper d-flex align-items-center">
                    <div class="avatar me-2">
                      <img src="${contextPath}${n.profileURL}" alt class="rounded-circle"/>
                    </div>
                    <div class="d-flex flex-column">
                      <span class="emp_name text_truncate" style="color: black;">${n.memName}</span>
                    </div>
                    <div class="d-flex flex-column" style="margin-left: 20px;">
                      <span>${n.noticeRegistDT}</span>
                    </div>
                  </div>
                  <div class="attachment-toggle-wrapper">
                    <span id="attachment-toggle" style="cursor: pointer;">첨부파일(${n.attachCount})</span>
                    <span id="count" style="margin-left: 20px; color: black;">조회수 (${n.noticeCount})</span>
                    <div id="attachment-list" class="attachment-list">
                      <c:forEach var="at" items="${n.attachList}">
                        <a href="${contextPath}${at.filePath}/${at.filesystemName}" download="${at.originalName}">${at.originalName}</a>
                        <br>
                      </c:forEach>
                    </div>
                  </div>
                </div>
                <!-- 부서 코드 표시 추가 -->
                <div class="dept-codes">
                  <c:forEach var="dept" items="${n.deptCodes}">
                    <span class="badge badge-primary">${dept.deptName}</span>
                  </c:forEach>
                </div>
                <br>
                <hr>           
                <c:choose>
                  <c:when test="${loginUser.memNo == n.memNo}">
                    <div class="d-flex justify-content-end align-items-center">
                      <div class="icon-wrapper">
                        <i class="ti ti-dots-vertical ti-md icon"></i>
                        <div class="action-box dropdown-replymenu dropdown-menu-end" style="margin-left: -60px;">
                          <form id="frm" action="" method="post">
                            <input type="hidden" id="no" name="no" value="" />
                            <a class="dropdown-item" href="#" onclick="modifyNoticePost(${n.noticeNo})">
                              <i class="menu-icon tf-icons ti ti-edit"></i><span>수정</span>
                            </a>
                            <a class="dropdown-item" href="#" onclick="deleteNoticePost(${n.noticeNo})">
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
                    <pre style="font-size: 16px; color: black; font-family: 'Noto Sans KR', sans-serif;">${n.noticeContent}</pre>
                  </div>
                </div>
                <br>
                <hr>              
                <div style="display: flex; justify-content: center; margin-top: 20px;">
                  <button id="back" class="btn btn-label-secondary" style="text-align: center;" onclick="noticeList();">목록</button>
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
</div>
<!-- Overlay -->
<div class="layout-overlay layout-menu-toggle"></div>
<!-- Drag Target Area To SlideIn Menu On Small Screens -->
<div class="drag-target"></div>
</body>

<script>

$(document).ready(function(){

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


//게시글 수정
function modifyNoticePost(noticeNo) {
  var form = document.getElementById('frm');
  form.setAttribute('action', '${contextPath}/notice/noticeModify.do');
  document.getElementById('no').value = noticeNo;
  form.submit();
}

// 게시글 삭제
function deleteNoticePost(noticeNo) {
  if (confirm('정말로 삭제하시겠습니까?')) {
    var form = document.getElementById('frm');
    form.setAttribute('action', '${contextPath}/notice/noticeDelete.do');
    document.getElementById('no').value = noticeNo;
    form.submit();
  }
}


function noticeList() {
  window.location.href = '${contextPath}/notice/noticeList.do';
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

    // attachment-toggle 클릭 처리
    if (e.target.matches('#attachment-toggle')) {
      e.stopPropagation();
      const attachmentList = document.getElementById('attachment-list');
      attachmentList.style.display = attachmentList.style.display === 'none' || !attachmentList.style.display ? 'block' : 'none';
      hideOtherBoxes('.attachment-list', attachmentList);
    }
  });

  // 외부 클릭 이벤트 처리 (모든 action-box, attachment-list 숨기기)
  document.addEventListener('click', (e) => {
    document.querySelectorAll('.action-box').forEach(box => {
      if (!box.contains(e.target) && !e.target.matches('.icon')) {
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
});

//사이드바 처리
document.addEventListener("DOMContentLoaded", function () {
	
	const element = document.getElementById("boardNotice");
	
	document.getElementById("boardSide").classList.add("open");
	element.style.backgroundColor = "#958CF4";
	element.style.color = "white";
	element.classList.add("active");
	
	
});
</script>
</html>