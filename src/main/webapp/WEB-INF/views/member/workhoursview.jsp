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
<style>
		#workhoursview::before {
		  content: ''; /* 가상 요소 필수 */
		  display: inline-block; /* 블록 요소 */
		  width: 10px; /* 동그라미 크기 */
		  height: 10px; /* 동그라미 크기 */
		  border-radius: 50%; /* 완전한 원 */
		  background-color: transparent; /* 배경을 투명으로 설정 */
		  border: 2px solid gray; /* 초기 테두리 색상 */
		}
		#workhoursview.active::before {
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

				<!-- nav 시작 -->
				<jsp:include page="/WEB-INF/views/common/nav.jsp" />
				<!-- nav 끗 -->
				
				
			<div class="layout-page">
			
			
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

										<li class="nav-item"><a class="nav-link "
											href="${ contextPath }/member/employeelistview.do""><i
												class="ti-sm ti ti-users me-1_5"></i> 직원조회 </a></li>

										<li class="nav-item"><a class="nav-link"
											href="${ contextPath }/wl/checkinrecordview.do""><i
												class="ti-sm ti ti-users me-1_5"></i> 출근기록조회 </a></li>

										<li class="nav-item"><a class="nav-link active"
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



						<!--상단프로필-->
						<!--/상단프로필-->
						<div class="card mb-6">
							<div
								class="user-profile-header d-flex flex-column flex-lg-row text-sm-start text-center mb-5">
								<div style="align-content: center; margin-top: 20px;">
									<img src="${ contextPath }<c:out value='${ loginUser.profileURL }' default='/assets/img/default_profile.png' />" alt="user image"
										class="d-block h-auto ms-0 ms-sm-6 rounded user-profile-img" 
										style="margin-bottom: 20px; align-items: center; max-width: 120px; max-height: 120px; object-fit: cover;"/>
								</div>
								<div class="flex-grow-1 mt-3 mt-lg-5">
									<div
										class="d-flex align-items-md-end align-items-sm-start align-items-center justify-content-md-between justify-content-start mx-5 flex-md-row flex-column gap-4">
										<div class="user-profile-info">
											<h4 class="mb-2 mt-lg-6">${ loginUser.getMemName() }</h4>
											<ul
												class="list-inline mb-0 d-flex align-items-center flex-wrap justify-content-sm-start justify-content-center gap-4 my-2">
												<li class="list-inline-item d-flex gap-2 align-items-center">
													<i class="ti ti-palette ti-lg"></i><span class="fw-medium">${ loginUser.getDeptName() }</span>
												</li>
												<li class="list-inline-item d-flex gap-2 align-items-center">
													<i class="ti ti-map-pin ti-lg"></i><span class="fw-medium">${ loginUser.getPosName() }</span>
												</li>
																								<li class="list-inline-item d-flex gap-2 align-items-center">
													<i class="ti ti-mail ti-lg"></i>
													<span class="fw-medium">
														${ loginUser.getEmail() }</span>
												</li>

											</ul>
										</div>
										<div id="searchBox" style="display: none; margin-top: 10px;">
											<input type="text" placeholder="검색어를 입력하세요" />
										</div>




									</div>
								</div>
							</div>
						</div>

						<div class="card" style="padding: 30px;">
							<div class="d-flex">

								<div style="margin-left: 20px;">
									<h3>2024년</h3>
								</div>

								<div
									style="width: 75%; align-items: center; justify-content: right;"
									class="d-flex"></div>
								<div
									style="width: 10%; text-align: right; align-content: center; margin-right: 15px;">
								</div>
							</div>
							<div class="table-responsive text-nowrap">
								<table class="table" style="text-align: center;">

									<tr>
										<th>월</th>
										<th>근무일수</th>
										<th>필수근무시간</th>
										<th>실 근무시간</th>

									</tr>
									</thead>
									<tbody class="table-border-bottom-0">
									<c:forEach var="wl" items="${ memNo }">
										<tr>
											<!-- 월 -->
											<td>${ wl.workDate2 }</td>
											<!-- 근무일수 -->
											<td>${ wl.workDay }일</td>
											<!-- 필수근무시간 -->
											<td>144시간</td>
											<!-- 실 근무시간 -->
											<td>${ wl.totalWorkTime }시간</td>
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>













					</div>
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
    // 사이드바 처리
	document.addEventListener("DOMContentLoaded", function () {
  	
		const element = document.getElementById("workhoursview");
		
  	document.getElementById("member").classList.add("open");
  	element.style.backgroundColor = "#958CF4";
  	element.style.color = "white";
  	element.classList.add("active");
  	
  	
	});
	</script>

</body>
</html>