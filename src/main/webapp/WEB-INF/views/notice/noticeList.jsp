<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html
  lang="en"
  class="light-style layout-navbar-fixed layout-menu-fixed layout-compact"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="${ contextPath }/assets/"
  data-template="views"
  data-style="light">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${ contextPath }/resources/assets/js/config.js"></script>
<style>
  .ms-auto {
    margin-left: auto;
  }
  .d-flex {
    display: flex;
    align-items: center;
  }
  .select, .text, #searchBtn {
    margin-right: 10px; /* 요소 간의 간격을 조정 */
  }
  .title {
  	max-width: 500px;
  	overflow: hidden;
  	text-overflow: ellipsis;
  	white-space: nowrap;
  }
  .card-datatable {
  overflow-x: auto;
	}
	
	.datatables-basic {
	  table-layout: fixed;
	  width: 100%;
	}
	
	.datatables-basic th,
	.datatables-basic td {
	  white-space: nowrap;
	  overflow: hidden;
	  
	}
	
	@media (max-width: 768px) {
	  .datatables-basic th,
	  .datatables-basic td {
	    font-size: 14px;
	    padding: 8px;
	  }
	}
	
	@media (max-width: 480px) {
	  .datatables-basic th,
	  .datatables-basic td {
	    font-size: 12px;
	    padding: 6px;
	  }
	
	  .datatables-basic th:nth-child(3),
	  .datatables-basic td:nth-child(3) {
	    display: none;
	  }
	}
	#create {
	    width: 70px; /* 너비를 줄입니다 */
	    height: 35px;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    padding: 0 5px; /* 내부 패딩을 추가하여 글자가 잘리지 않도록 합니다 */
	    font-size: 14px; /* 글자 크기를 조금 줄입니다 */
	    white-space: nowrap; /* 글자가 한 줄로 나오도록 합니다 */
	    margin-top: -50px;
	}
	
	.pinned {
	    background-color: #E6E6FA; 
	    font-weight: bold; /* 글씨를 굵게 설정 */
	}
	
	.pinned .item-checkbox {
	    background-color: white; 
	}
	
	.pinned td {
	    border-top: 1px solid white !important; /* 테두리 색상 설정 */
	    border-bottom: 1px solid white !important; /* 테두리 색상 설정 */
	}
	
	.pagination {
    display: flex;
    flex-wrap: nowrap;
    justify-content: center;
  }
  .btn-group {
    display: flex;
    align-items: center;
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
      <jsp:include page="/WEB-INF/views/common/nav.jsp" />
      <!-- nav 끝 -->

      <div class="content-wrapper">
        <!-- 세션 시작 -->
        <div class="container-xxl flex-grow-1 container-p-y">
          <!-- 이쪽에 세션정보 넣어야합니다 ----------------------------------------------------------------------- -->

          <!-- Content wrapper -->
          <div class="content-wrapper">
            <!-- Content -->
            <div class="container-xxl flex-grow-1 container-p-y">
              <div class="container card py-5">
                <div class="d-flex align-items-center">
                  <div style="margin: 20px;">
                    <span style="font-size: 20px;">
                    	공지사항                                        
                    </span>        
                  </div>
                               
                  <div class="ms-auto d-flex">
									  <form id="search_form" action="${contextPath}/notice/noticeSearch.do" method="get" class="d-flex align-items-center">
									    <input type="hidden" name="page" value="1">
									   	<input type="hidden" name="deptCode" value="${loginUser.deptCode}">
									    <div class="select">
									      <select id="searchSelect" class="custom-select select1 form-select form-select-lg" name="condition" style="width: 110px; height: 38px !important; min-height: 38px !important; font-size: 16px !important; padding-top: 0.3rem !important; padding-right: 1rem !important; padding-bottom: calc(38px - 1rem - 16px) !important; padding-left: 1rem !important; box-sizing: border-box;">
									        <option value="" <c:if test="${empty search.condition}">selected</c:if>>전체</option>
									        <option value="mem_name" <c:if test="${search.condition == 'mem_name'}">selected</c:if>>작성자</option>
									        <option value="notice_title" <c:if test="${search.condition == 'notice_title'}">selected</c:if>>제목</option>
									        <option value="notice_content" <c:if test="${search.condition == 'notice_content'}">selected</c:if>>내용</option>
									      </select>
									    </div>
									    <div class="text">
									      <input type="hidden" name="deptCode" value="${loginUser.deptCode}">
									      <input type="text" class="form-control" name="keyword" value="${search.keyword}">
									    </div>
									    <button type="submit" id="searchBtn" class="btn btn-primary">
									      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-tabler icons-tabler-outline icon-tabler-search me-2">
									        <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
									        <path d="M10 10m-7 0a7 7 0 1 0 14 0a7 7 0 1 0 -14 0"/>
									        <path d="M21 21l-6 -6"/>
									      </svg>
									      검색
									    </button>
									  </form>
									  <c:if test="${not empty search}">
									    <script>
									      $(document).ready(function(){
									        $("#search_form select").val('${search.condition}');

									      });
									    </script>
									  </c:if>
									</div>
                  
                  
                </div>    
                
                <div class="card-datatable table-responsive pt-3">
								  <table class="datatables-basic table text-center">
								    <thead>
								      <tr>
								        <c:choose>
								          <c:when test="${ loginUser.deptCode == 'S2'}">
								            <th style="width: 5%;"><input type="checkbox" id="selectAll" /></th>
								            <th style="width: 10%;">번호</th>
								            <th style="width: 15%;">작성자</th>
								            <th style="width: 35%;">제목</th>
								            <th style="width: 15%;">작성일</th>
								            <th style="width: 10%;">조회수</th>
								          </c:when>
								          <c:otherwise>
								            <th style="width: 10%;">번호</th>
								            <th style="width: 15%;">작성자</th>
								            <th style="width: 40%;">제목</th>
								            <th style="width: 15%;">작성일</th>
								            <th style="width: 10%;">조회수</th>
								          </c:otherwise>
								        </c:choose>
								      </tr>
								    </thead>
								    <tbody>
								      <c:choose>
								        <c:when test="${empty list}">
								          <!-- 게시글이 없을 경우 -->
								          <tr>
								            <td colspan="6">조회된 게시글이 없습니다.</td>
								          </tr>
								        </c:when>
								        <c:otherwise>
								          <c:set var="count" value="1" />
								          <c:forEach var="notice" items="${list}">
								            <!-- 역순 넘버링 계산 -->
								            <c:set var="reverseCount" value="${pi.listCount - (pi.currentPage - 1) * pi.boardLimit - (count - 1)}" />
								            <tr data-noticeno="${notice.noticeNo}" class="${notice.isPinned == 1 ? 'pinned' : ''}">
								              <c:choose>
								                <c:when test="${ loginUser.deptCode == 'S2'}">
								                  <td><input type="checkbox" class="item-checkbox" /></td>
								                </c:when>
								              </c:choose>
								              <td>${reverseCount}</td> <!-- 역순 번호 -->
								              <td>${notice.memName}</td>
								              <td class="title" style="cursor: pointer;" onclick='location.href = "${contextPath}/notice/${loginUser.memNo eq notice.memNo ? "noticeDetail.do" : "increase.do"}?no=${notice.noticeNo}";'>
								                ${notice.noticeTitle}
								                <c:if test="${notice.attachCount != 0}">
								                  <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-tabler icons-tabler-outline icon-tabler-paperclip">
								                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
								                    <path d="M15 7l-6.5 6.5a1.5 1.5 0 0 0 3 3l6.5 -6.5a3 3 0 0 0 -6 -6l-6.5 6.5a4.5 4.5 0 0 0 9 9l6.5 -6.5" />
								                  </svg>
								                </c:if>
								              </td>
								              <td>${notice.noticeRegistDT}</td>
								              <td>${notice.noticeCount}</td>
								            </tr>
								            <c:set var="count" value="${count + 1}" />
								          </c:forEach>
								        </c:otherwise>
								      </c:choose>
								    </tbody>
								  </table>
								</div>
								
								<!-- 페이징 바 -->
									<div class="card-body">
									  <c:choose>
									    <c:when test="${ loginUser.deptCode == 'S2'}">
									      <div class="ms-5 d-flex justify-content-between align-items-center">
									        <button id="create" class="btn btn-danger" onclick="deleteSelectedPosts();" style="margin-left: -30px;">
									          <span class="ti-xs ti ti-trash me-2"></span>삭제
									        </button>
									        
									        <nav aria-label="Page navigation">
									          <ul class="pagination" id="paging_area">
									            <li class="page-item first"><a class="page-link" href="javascript:void(0);" onclick="goToPage(1);"><i class="ti ti-chevrons-left ti-sm"></i></a></li>
									            <li class="page-item prev ${pi.currentPage == 1 ? 'disabled' : ''}"><a class="page-link" href="javascript:void(0);" onclick="goToPage(${pi.currentPage - 1});"><i class="ti ti-chevron-left ti-sm"></i></a></li>
									            <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
									              <li class="page-item ${i == pi.currentPage ? 'active' : ''}"><a class="page-link" href="javascript:void(0);" onclick="goToPage(${i});">${i}</a></li>
									            </c:forEach>
									            <li class="page-item next ${pi.currentPage == pi.maxPage ? 'disabled' : ''}"><a class="page-link" href="javascript:void(0);" onclick="goToPage(${pi.currentPage + 1});"><i class="ti ti-chevron-right ti-sm"></i></a></li>
									            <li class="page-item last"><a class="page-link" href="javascript:void(0);" onclick="goToPage(${pi.maxPage});"><i class="ti ti-chevrons-right ti-sm"></i></a></li>
									          </ul>
									        </nav>
									
									        <button id="create" class="btn btn-primary waves-effect waves-light" onclick="regist();">
									          <span class="ti-xs ti ti-edit me-2"></span>작성
									        </button>
									      </div>
									    </c:when>
									    <c:otherwise>
									      <div class="d-flex justify-content-center">
									        <nav aria-label="Page navigation">
									          <ul class="pagination" id="paging_area">
									            <li class="page-item first"><a class="page-link" href="javascript:void(0);" onclick="goToPage(1);"><i class="ti ti-chevrons-left ti-sm"></i></a></li>
									            <li class="page-item prev ${pi.currentPage == 1 ? 'disabled' : ''}"><a class="page-link" href="javascript:void(0);" onclick="goToPage(${pi.currentPage - 1});"><i class="ti ti-chevron-left ti-sm"></i></a></li>
									            <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
									              <li class="page-item ${i == pi.currentPage ? 'active' : ''}"><a class="page-link" href="javascript:void(0);" onclick="goToPage(${i});">${i}</a></li>
									            </c:forEach>
									            <li class="page-item next ${pi.currentPage == pi.maxPage ? 'disabled' : ''}"><a class="page-link" href="javascript:void(0);" onclick="goToPage(${pi.currentPage + 1});"><i class="ti ti-chevron-right ti-sm"></i></a></li>
									            <li class="page-item last"><a class="page-link" href="javascript:void(0);" onclick="goToPage(${pi.maxPage});"><i class="ti ti-chevrons-right ti-sm"></i></a></li>
									          </ul>
									        </nav>
									      </div>
									    </c:otherwise>
									  </c:choose>             
									</div>
								
            </div>
          </div>
          <!-- 세션정보 끝 -->
        </div>
        <!-- 세션 끝 -->
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
<!-- Overlay -->
<div class="layout-overlay layout-menu-toggle"></div>
<!-- Drag Target Area To SlideIn Menu On Small Screens -->
<div class="drag-target"></div>
<!-- layout wrapper 닫기 -->
</body>
<script>
	//사이드바 처리
	document.addEventListener("DOMContentLoaded", function () {
		
		const element = document.getElementById("boardNotice");
		
		document.getElementById("boardSide").classList.add("open");
		element.style.backgroundColor = "#958CF4";
		element.style.color = "white";
		element.classList.add("active");
				
	});

	$(document).ready(function(){
	  $("#searchSelect").val("${empty search.condition ? '' : search.condition}");
	});


  $(document).ready(function(){
    $("#search_form select").val('${search.condition}');
  });
	
  document.getElementById('selectAll').addEventListener('click', function(event) {
    const checkboxes = document.querySelectorAll('.item-checkbox');
    checkboxes.forEach(checkbox => {
      checkbox.checked = event.target.checked;
    });
  });

  function goToPage(pageNumber) {
	  if('${search.keyword}' == ''){
	    window.location.href = "${contextPath}/notice/noticeList.do?page=" + pageNumber;		  
	  }else{
		  $("#search_form input[name=page]").val(pageNumber);
		  $("#search_form").submit();
	  }
  }

  function regist() {
    window.location.href = "${contextPath}/notice/noticeRegist.do";
  }

  function deleteSelectedPosts() {
    const checkboxes = document.querySelectorAll('.item-checkbox:checked');
    const selectednoticeNos = Array.from(checkboxes).map(checkbox => checkbox.closest('tr').dataset.noticeno);

    if (selectednoticeNos.length === 0) {
      alert('삭제할 게시물을 선택해주세요.');
      return;
    }

    if (confirm('선택한 게시물을 삭제하시겠습니까?')) {
      const form = document.createElement('form');
      form.method = 'post';
      form.action = "${contextPath}/notice/deleteSelectedPosts.do";
      selectednoticeNos.forEach(noticeNo => {
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'noticeNos';
        input.value = noticeNo;
        form.appendChild(input);
      });

      document.body.appendChild(form);
      form.submit();
    }
  }
</script>
</html>