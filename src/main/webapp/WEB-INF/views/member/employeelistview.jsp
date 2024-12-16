<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en"
	class="light-style layout-navbar-fixed layout-menu-fixed layout-compact"
	dir="ltr" data-theme="theme-default"
	data-assets-path="${ contextPath }/assets/" data-template="views"
	data-style="light">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${ contextPath }/resources/assets/js/config.js"></script>





<!-- Vendors CSS -->
<link rel="stylesheet"
	href="../../assets/vendor/libs/node-waves/node-waves.css" />

<link rel="stylesheet"
	href="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
<link rel="stylesheet"
	href="../../assets/vendor/libs/typeahead-js/typeahead.css" />
<link rel="stylesheet"
	href="../../assets/vendor/libs/datatables-bs5/datatables.bootstrap5.css" />
<link rel="stylesheet"
	href="../../assets/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css" />
<link rel="stylesheet"
	href="../../assets/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css" />
<link rel="stylesheet"
	href="../../assets/vendor/libs/select2/select2.css" />
<link rel="stylesheet"
	href="../../assets/vendor/libs/@form-validation/form-validation.css" />
<link rel="stylesheet"
	href="../../assets/vendor/libs/quill/typography.css" />
<link rel="stylesheet" href="../../assets/vendor/libs/quill/katex.css" />
<link rel="stylesheet" href="../../assets/vendor/libs/quill/editor.css" />

<!-- Page CSS -->

<link rel="stylesheet"
	href="../../assets/vendor/css/pages/app-ecommerce.css" />
<link rel="stylesheet" href="../../assets/vendor/css/pages/page-faq.css" />



<style>
		#employeelistview::before {
		  content: ''; /* 가상 요소 필수 */
		  display: inline-block; /* 블록 요소 */
		  width: 10px; /* 동그라미 크기 */
		  height: 10px; /* 동그라미 크기 */
		  border-radius: 50%; /* 완전한 원 */
		  background-color: transparent; /* 배경을 투명으로 설정 */
		  border: 2px solid gray; /* 초기 테두리 색상 */
		}
		#employeelistview.active::before {
		  border: 2px solid white; /* 테두리만 흰색으로 변경 */
		}
</style>




</head>
<body>

	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">


			<!-- 헤더 시작 -->
			<jsp:include page="/WEB-INF/views/common/header.jsp" />
			<!-- 헤더 끝 -->

			<div class="layout-page">

				<!-- nav 시작 -->
				<jsp:include page="/WEB-INF/views/common/nav.jsp" />
				<!-- nav 끗 -->


				<div class="content-wrapper">
					<!-- 세션 시작 -->
					<div class="container-xxl flex-grow-1 container-p-y">
						<!-- 이쪽에 세션정보 넣어야합니다 -->



						<div class="row">
							<div class="col-md-12">
								<div class="nav-align-top">
									<ul
										class="nav nav-pills flex-column flex-sm-row mb-6 gap-2 gap-lg-0">
										<c:if test="${ loginUser.deptCode eq 'S2'}">
											<li class="nav-item"><a class="nav-link"
												href="${ contextPath }/member/signup.do"> <i
													class="ti-sm ti ti-user-check me-1_5"></i> 직원등록
											</a></li>
										</c:if>

										<li class="nav-item"><a class="nav-link active "
											href="${ contextPath }/member/employeelistview.do""><i
												class="ti-sm ti ti-users me-1_5"></i> 직원조회 </a></li>

										<li class="nav-item"><a class="nav-link"
											href="${ contextPath }/wl/checkinrecordview.do""><i
												class="ti-sm ti ti-users me-1_5"></i> 출근기록조회 </a></li>

										<li class="nav-item"><a class="nav-link"
											href="${ contextPath }/member/workhoursview.do""><i
												class="ti-sm ti ti-users me-1_5"></i> 근무시간조회 </a></li>
										<c:if test="${ loginUser.deptCode eq 'S2'}">
											<li class="nav-item"><a class="nav-link"
												href="${ contextPath }/member/salarypayment.do""><i
													class="ti-sm ti ti-users me-1_5"></i> 급여지급 </a></li>
										</c:if>

										<li class="nav-item"><a class="nav-link"
											href="${ contextPath }/member/checksalary.do""><i
												class="ti-sm ti ti-money me-1_5"></i> 급여내역확인 </a></li>
								</div>
							</div>
						</div>



 						<div
							class="faq-header d-flex flex-column justify-content-center align-items-center "
							style="margin-bottom: 10px; ">
							<img src="${contextPath }/assets/img/pages/header.png" class=""
								alt="background image" style="width: 100%; height: 102px; border-radius: 7px;" />
						
						</div> 
						<!--/상단 검색바-->

						<!--검색내용-->
						<div class="card"
							style="padding: 30px; padding: 30px; position: relative; bottom: 3px;">
							<h5 class="card-header">사원목록</h5>
							<div class="table-responsive text-nowrap">
								<table class="table" style="text-align: center;">
									<thead>
										<tr>
											<th>사원명</th>
											<th>부서</th>
											<th>직급</th>
											<th>이메일</th>
											 <c:if test="${ loginUser.deptCode eq 'S2'}">
											<th>&nbsp;</th>
											</c:if>

										</tr>
									</thead>
									<tbody class="table-border-bottom-0">
										<c:forEach var="member" items="${list}">


											<tr>
												<td><span class="fw-medium">${member.memName}</span></td>

												<td>${member.deptName}</td>

												<td><span class="fw-medium">${member.posName}</span></td>


												<td><span>${member.email}</span></td>
													 <c:if test="${ loginUser.deptCode eq 'S2'}">
												<td><a class="badge bg-label-primary me-1"
													style="border: none;"
													href="${contextPath}/member/modifydelete.do?memNo=${member.memNo}">수정/삭제</a>
												</td>
												</c:if>
										</c:forEach>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- 페이징바 , 클릭한 숫자에 클래스에 active 추가하기 -->
							<div class="card-body">
								<div class="row">
									<span class="col-lg-12 d-flex justify-content-center">
										<div class="demo-inline-spacing">
											<nav aria-label="Page navigation">
												<ul class="pagination">
													<!-- 첫 페이지로 이동 -->
													<li
														class="page-item first ${pi.currentPage == 1 ? 'disabled' : ''}">
														<a class="page-link" href="javascript:void(0);"
														onclick="goToPage(1);"> <i
															class="ti ti-chevrons-left ti-sm"></i>
													</a>
													</li>

													<!-- 이전 페이지로 이동 -->
													<li
														class="page-item prev ${pi.currentPage == 1 ? 'disabled' : ''}">
														<a class="page-link" href="javascript:void(0);"
														onclick="goToPage(${pi.currentPage - 1});"> <i
															class="ti ti-chevron-left ti-sm"></i>
													</a>
													</li>

													<!-- 페이지 번호 출력 -->
													<c:forEach var="i" begin="${pi.startPage}"
														end="${pi.endPage}">
														<li
															class="page-item ${i == pi.currentPage ? 'active' : ''}">
															<a class="page-link" href="javascript:void(0);"
															onclick="goToPage(${i});">${i}</a>
														</li>
													</c:forEach>

													<!-- 다음 페이지로 이동 -->
													<li
														class="page-item next ${pi.currentPage == pi.maxPage ? 'disabled' : ''}">
														<a class="page-link" href="javascript:void(0);"
														onclick="goToPage(${pi.currentPage + 1});"> <i
															class="ti ti-chevron-right ti-sm"></i>
													</a>
													</li>

													<!-- 마지막 페이지로 이동 -->
													<li
														class="page-item last ${pi.currentPage == pi.maxPage ? 'disabled' : ''}">
														<a class="page-link" href="javascript:void(0);"
														onclick="goToPage(${pi.maxPage});"> <i
															class="ti ti-chevrons-right ti-sm"></i>
													</a>
													</li>
												</ul>
											</nav>
										</div>
									</span>
								</div>
							</div>
						</div>
						<!--/검색내용-->








					</div>
					<!-- 세션 끝 -->





					<!-- 푸터 시작 -->
					<jsp:include page="/WEB-INF/views/common/footer.jsp" />
					<!-- 푸터 끝 -->

					<div class="content-backdrop fade"></div>
					<!-- wrapper 닫기 -->
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
	</div>













	<script>
  function goToPage(pageNumber) {
    // URL의 query string에 page 파라미터 추가
    const url = new URL(window.location.href);
    url.searchParams.set('page', pageNumber);
    window.location.href = url.toString();
  }
</script>

	<script>
    // 사이드바 처리
	document.addEventListener("DOMContentLoaded", function () {
  	
		const element = document.getElementById("employeelistview");
		
  	document.getElementById("member").classList.add("open");
  	element.style.backgroundColor = "#958CF4";
  	element.style.color = "white";
  	element.classList.add("active");
  	
  	
	});
	</script>



</body>
</html>