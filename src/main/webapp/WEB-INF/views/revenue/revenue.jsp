<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Arrays" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en" class="light-style layout-navbar-fixed layout-menu-fixed layout-compact" dir="ltr" data-theme="theme-default" data-assets-path="${contextPath}/assets/" data-template="views" data-style="light">
  <head>
    <meta charset="UTF-8">
    <title>Revenue Entry</title>
    <script src="${contextPath}/resources/assets/js/config.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <!-- flatpickr CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <!-- flatpickr 한글 설정 CSS -->
    <link rel="stylesheet" href="https://npmcdn.com/flatpickr/dist/l10n/ko.css">
    <style>
      #salesRegist::before {
        content: ''; /* 가상 요소 필수 */
        display: inline-block; /* 블록 요소 */
        width: 10px; /* 동그라미 크기 */
        height: 10px; /* 동그라미 크기 */
        border-radius: 50%; /* 완전한 원 */
        background-color: transparent; /* 배경을 투명으로 설정 */
        border: 2px solid gray; /* 초기 테두리 색상 */
      }

      #salesRegist.active::before {
        border: 2px solid white; /* 테두리만 흰색으로 변경 */
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

      /* 중앙 정렬을 위한 CSS */
      .flatpickr-current-month {
        display: flex;
        justify-content: center;
        align-items: center;
      }

      .flatpickr-current-month .flatpickr-monthDropdown-months,
      .flatpickr-current-month .numInputWrapper {
        justify-content: center;
      }
    </style>
  </head>
  <body>
    <%-- 부서 코드 확인 --%>
    <c:if test="${not empty param.deptCode and param.deptCode != loginUser.deptCode}">
      <script>
        alert("해당 부서가 아닙니다.");
        window.location.href = "${contextPath}/revenue/revenue.do?deptCode=${loginUser.deptCode}";
      </script>
    </c:if>

    <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container">
        <!-- 헤더 시작 -->
        <jsp:include page="/WEB-INF/views/common/header.jsp" />
        <!-- 헤더 끝 -->

        <div class="layout-page">
          <!-- 네비게이션 -->
          <jsp:include page="/WEB-INF/views/common/nav.jsp" />
          <!-- 네비게이션 끝 -->

          <div class="content-wrapper">
            <div class="container-xxl flex-grow-1 container-p-y">
              <div class="container card py-5">
                <!-- 탭 제목 -->
                <h4 class="fw-bold py-3 mb-4">매출 관리</h4>

                <!-- 탭 네비게이션 -->
                <ul class="nav nav-tabs" id="revenueTabs" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link active" id="view-tab" data-bs-toggle="tab" href="#view" role="tab" aria-controls="view" aria-selected="true">매출 조회</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" id="register-tab" data-bs-toggle="tab" href="#register" role="tab" aria-controls="register" aria-selected="false">매출 등록</a>
                  </li>
                </ul>

                <!-- 탭 내용 -->
                <div class="tab-content" id="revenueTabsContent">
                  <!-- 매출 조회 탭 -->
                  <div class="tab-pane fade show active" id="view" role="tabpanel" aria-labelledby="view-tab">
                    <div class="ms-auto d-flex">
                      <!-- 검색 폼 -->
                      <div class="ms-auto d-flex justify-content-end">
	                      <form action="${contextPath}/revenue/revenue.do" method="get" class="d-flex align-items-center">
	                        <input type="hidden" name="deptCode" value="${deptCode}" />
	                        <input type="hidden" name="startDate" value="${startDate}" />
	                        <input type="hidden" name="endDate" value="${endDate}" />
	                        <input type="hidden" name="tab" value="view" />
	                        <div class="input-group mb-3">
	                          <input type="text" class="form-control" name="searchKeyword" style="width: 310px;" placeholder="관리자또는 매장이름 키워드를 입력하세요" value="${searchKeyword}" />
	                          <input type="text" class="form-control custom-select" style="width: 210px;" placeholder="날짜를 선택해주세요" id="flatpickr-range" name="dateRange" value="${startDate} to ${endDate}" />
	                          <button class="btn btn-primary" type="submit">검색</button>
	                        </div>
	                      </form>
	                    </div>
                    </div>
                    <script>
	                    document.addEventListener("DOMContentLoaded", function () {
	                   	  flatpickr("#flatpickr-range", {
	                   	    mode: "range", // 날짜 범위 선택
	                   	    dateFormat: "Y-m-d", // 날짜 형식
	                   	    locale: "ko", // 한글 설정
	                   	    maxDate: "today", // 오늘까지만 선택 가능
	                   	    defaultDate: ["${startDate}", "${endDate}"], // 기본 날짜 범위 설정
	                   	    onClose: function (selectedDates) {
	                   	      if (selectedDates.length === 2) {
	                   	        var startDate = new Date(selectedDates[0]);
	                   	        var endDate = new Date(selectedDates[1]);
	                   	        startDate.setDate(startDate.getDate() + 1); // 'endDate'에 하루를 더함
	                   	        endDate.setDate(endDate.getDate() + 1);
	                   	        document.querySelector('input[name="startDate"]').value = startDate
	                   	          .toISOString()
	                   	          .split("T")[0];
	                   	        document.querySelector('input[name="endDate"]').value = endDate
	                   	          .toISOString()
	                   	          .split("T")[0];
	                   	      } else {
	                   	        document.querySelector('input[name="startDate"]').value = "";
	                   	        document.querySelector('input[name="endDate"]').value = "";
	                   	      }
	                   	    },
	                   	  });
	
	                   	  var urlParams = new URLSearchParams(window.location.search);
	                   	  var tab = urlParams.get("tab");
	                   	  if (tab && tab === "register") {
	                   	    var registerTab = document.getElementById("register-tab");
	                   	    var viewTab = document.getElementById("view-tab");
	                   	    var registerPane = document.getElementById("register");
	                   	    var viewPane = document.getElementById("view");
	
	                   	    viewTab.classList.remove("active");
	                   	    registerTab.classList.add("active");
	                   	    viewPane.classList.remove("show", "active");
	                   	    registerPane.classList.add("show", "active");
	                   	  }
	                   	});


                    </script>

										<!-- 매출 테이블 -->
										<table class="datatables-basic table text-center" cellpadding="10" cellspacing="0" style="width: 100%; text-align: center;">
										  <thead>
										    <tr>
										      <th>관리자</th>
										      <th>매장 이름</th>
										      <th>매출 값</th>
										      <th>등록 날짜</th>
										    </tr>
										  </thead>
										  <tbody>
										    <c:choose>
										      <c:when test="${not empty revenueList}">
										        <c:forEach items="${revenueList}" var="revenue">
										          <tr>
										            <td>${revenue.memName}</td>
										            <td>${revenue.rvStore}</td>
										            <td><fmt:formatNumber value="${revenue.rvValue}" type="number" pattern="#,##0" /></td>
										            <td>${revenue.rvRegistDate}</td>
										          </tr>
										        </c:forEach>
										      </c:when>									      
										      <c:otherwise>
										        <tr>
										          <td colspan="4">조회된 데이터가 없습니다.</td>
										        </tr>
										      </c:otherwise>
										    </c:choose>
										  </tbody>
										</table>


                    <br />
                    <!-- 페이징 -->
                    <div class="d-flex justify-content-center">
                      <nav aria-label="Page navigation">
                        <ul class="pagination" id="paging_area">
                          <li class="page-item first">
                            <a
                              class="page-link"
                              href="${contextPath}/revenue/revenue.do?page=1&size=${size}&deptCode=${deptCode}&searchKeyword=${searchKeyword}&startDate=${startDate}&endDate=${endDate}&tab=view"
                            >
                              <i class="ti ti-chevrons-left ti-sm"></i>
                            </a>
                          </li>
                          <li class="page-item prev ${pi.currentPage == 1 ? 'disabled' : ''}">
                            <a
                              class="page-link"
                              href="${contextPath}/revenue/revenue.do?page=${pi.currentPage - 1}&size=${size}&deptCode=${deptCode}&searchKeyword=${searchKeyword}&startDate=${startDate}&endDate=${endDate}&tab=view"
                            >
                              <i class="ti ti-chevron-left ti-sm"></i>
                            </a>
                          </li>
                          <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                            <li class="page-item ${i == pi.currentPage ? 'active' : ''}">
                              <a
                                class="page-link"
                                href="${contextPath}/revenue/revenue.do?page=${i}&size=${size}&deptCode=${deptCode}&searchKeyword=${searchKeyword}&startDate=${startDate}&endDate=${endDate}&tab=view"
                              >
                                ${i}
                              </a>
                            </li>
                          </c:forEach>
                          <li class="page-item next ${pi.currentPage == pi.maxPage ? 'disabled' : ''}">
                            <a
                              class="page-link"
                              href="${contextPath}/revenue/revenue.do?page=${pi.currentPage + 1}&size=${size}&deptCode=${deptCode}&searchKeyword=${searchKeyword}&startDate=${startDate}&endDate=${endDate}&tab=view"
                            >
                              <i class="ti ti-chevron-right ti-sm"></i>
                            </a>
                          </li>
                          <li class="page-item last">
                            <a
                              class="page-link"
                              href="${contextPath}/revenue/revenue.do?page=${pi.maxPage}&size=${size}&deptCode=${deptCode}&searchKeyword=${searchKeyword}&startDate=${startDate}&endDate=${endDate}&tab=view"
                            >
                              <i class="ti ti-chevrons-right ti-sm"></i>
                            </a>
                          </li>
                        </ul>
                      </nav>
                    </div>
                  </div>

                  <!-- 매출 등록 탭 -->
                  <div class="tab-pane fade" id="register" role="tabpanel" aria-labelledby="register-tab">
                    <c:if test="${not empty successMessage}">
                      <div class="alert alert-success" role="alert">${successMessage}</div>
                    </c:if>

                    <c:if test="${not empty errorMessage}">
                      <div class="alert alert-danger" role="alert">${errorMessage}</div>
                    </c:if>

                    <!-- 매출 등록 폼 -->
										<form id="revenueForm" action="${contextPath}/revenue/registerAll.do" method="post">
										    <input type="hidden" name="memNo" value="${loginUser.memNo}" />
										    <input type="hidden" name="deptCode" value="${deptCode}" />
										    <div id="storeInputs">
										        <c:forEach items="${storeOptions}" var="store" varStatus="status">
										            <div class="store-input-group mb-3 row g-2 align-items-center">
										                <div class="col-auto">
										                    <label for="rvStore${status.index}" class="form-label">매장 ${status.index + 1}</label>
										                    <input type="text" class="form-control" name="rvStores[]" value="${store}" readonly style="width: 150px;" />
										                </div>
										                <div class="col-auto">
										                    <label for="rvValue${status.index}" class="form-label">당일 매출</label>
										                    <input
										                        type="text"
										                        class="form-control rvValue"
										                        name="rvValues[]"
										                        style="width: 300px;"
										                        placeholder="당일매출을 입력하세요"
										                    />
										                </div>
										            </div>
										        </c:forEach>
										        <div class="d-flex justify-content-start mt-3">
										            <button type="submit" class="btn btn-primary" style="height: 38px;">매출등록</button>
										        </div>
										    </div>
										</form>
                  </div>
                </div>
              </div>
            </div>

            <!-- 푸터 -->
            <jsp:include page="/WEB-INF/views/common/footer.jsp" />
            <!-- 푸터 끝 -->
          </div>
        </div>
      </div>
    </div>

		<script>
		  document.addEventListener("DOMContentLoaded", function () {
		    const rvValueInputs = document.querySelectorAll(".rvValue");
		
		    // 숫자를 쉼표 형식으로 변환하는 함수
		    function formatNumberWithCommas(value) {
		      return value.replace(/\D/g, "") // 숫자가 아닌 문자 제거
		                  .replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 3자리마다 쉼표 추가
		    }
		
		    // 입력 필드에 이벤트 리스너 추가
		    rvValueInputs.forEach((input) => {
		      input.addEventListener("input", function () {
		        const originalValue = input.value.replace(/,/g, ""); // 기존 숫자에서 쉼표 제거
		        const formattedValue = formatNumberWithCommas(originalValue); // 쉼표 추가한 새 값
		
		        // 커서 위치 조정
		        const cursorPosition = input.selectionStart; // 현재 커서 위치
		        const beforeCursor = input.value.slice(0, cursorPosition).replace(/,/g, ""); // 커서 이전의 숫자
		        const newCursorPosition = formatNumberWithCommas(beforeCursor).length; // 쉼표가 추가된 뒤 커서 위치 계산
		
		        input.value = formattedValue; // 포맷팅된 값 적용
		        input.setSelectionRange(newCursorPosition, newCursorPosition); // 커서 위치 설정
		      });
		    });
		
		    // 폼 제출 시 쉼표 제거 후 값 전송
		    document.getElementById("revenueForm").addEventListener("submit", function () {
		      rvValueInputs.forEach((input) => {
		        input.value = input.value.replace(/,/g, ""); // 쉼표 제거
		      });
		    });
		  });
		  
		  const revenueForm = document.getElementById("revenueForm");

		  revenueForm.addEventListener("submit", function (event) {
		    const storeInputs = document.querySelectorAll(".rvValue");
		    let hasValidInput = false;

		    // 입력값 검증: 최소 하나의 매장 입력값 확인
		    storeInputs.forEach((input) => {
		      if (input.value.trim() !== "") {
		        hasValidInput = true; // 유효한 입력값 발견
		      }
		    });

		    if (!hasValidInput) {
		      // 유효한 입력값이 없을 경우 경고 및 제출 중단
		      event.preventDefault();
		      alert("최소 하나의 매장을 입력해 주세요.");
		      return;
		    }

		    // 입력되지 않은 매장은 제거
		    storeInputs.forEach((input) => {
		      if (input.value.trim() === "") {
		        input.closest(".store-input-group").remove();
		      }
		    });
		  });
		  
	    document.addEventListener('DOMContentLoaded', function () {
	        const inputFields = document.querySelectorAll('.rvValue');

	        inputFields.forEach(input => {
	            input.addEventListener('input', function () {
	                // 입력 필드의 값에서 모든 쉼표를 제거
	                let value = this.value.replace(/,/g, '');
	                // 숫자 길이를 9자리로 제한
	                if (value.length > 9) {
	                    value = value.slice(0, 9);
	                }
	                // 숫자로 변환 후 다시 쉼표를 추가
	                value = Number(value).toLocaleString('en');
	                // 변환된 값으로 입력 필드 업데이트
	                this.value = value;
	            });
	        });
	    });
		  
		</script>
		
    <!-- flatpickr JS -->
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
  </body>
</html>
