<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


  	<!-- Favicon -->
	<link rel="icon" type="image/x-icon" href="${ contextPath }/resources/assets/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&ampdisplay=swap"
      rel="stylesheet" />

    <!-- Icons -->
    <link rel="stylesheet" href="${contextPath }/resources/assets/vendor/fonts/fontawesome.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/fonts/tabler-icons.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/fonts/flag-icons.css" />

    <!-- Core CSS -->

    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/css/rtl/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/css/rtl/theme-default.css" class="template-customizer-theme-css" />

    <link rel="stylesheet" href="${ contextPath }/resources/assets/css/demo.css" />
    <!-- 여기까지 공통 건들지마세요! -->
    
    
    

    <!-- Vendors CSS -->

    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/node-waves/node-waves.css" />

    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/scrollbar-js/typeahead.css" />
    
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/datatables-bs5/datatables.bootstrap5.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css" />
   
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/@form-validation/form-validation.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/quill/typography.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/quill/katex.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/quill/editor.css" />
    <!-- // -->
    
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/apex-charts/apex-charts.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/swiper/swiper.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/datatables-checkboxes-jquery/datatables.checkboxes.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/bs-stepper/bs-stepper.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/bootstrap-select/bootstrap-select.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/bootstrap-maxlength/bootstrap-maxlength.css" />
    
    
    
    <link rel="stylesheet" href="${ contextPath }/resources/libs/jstree/jstree.css" />
    
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/flatpickr/flatpickr.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/bootstrap-datepicker/bootstrap-datepicker.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/bootstrap-daterangepicker/bootstrap-daterangepicker.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/jquery-timepicker/jquery-timepicker.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/pickr/pickr-themes.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/node-waves/node-waves.css" />
  <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
  <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/typeahead-js/typeahead.css" />  
    
    
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/libs/tagify/tagify.css" />
    
    <!-- Page CSS -->

    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/css/pages/app-ecommerce.css" />
	<link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/css/pages/cards-advance.css" />
    <link rel="stylesheet" href="${ contextPath }/resources/assets/vendor/css/pages/app-chat.css" />	
    <link rel="stylesheet" href="${ contextPaath }/resources/assets/vendor/css/pages/page-faq.css" />
    
  
  
  <!-- 여기도 공통!!!! -->
    <!-- Helpers -->
    <script src="${ contextPath }/resources/assets/vendor/js/helpers.js"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->

    <!--? Template customizer: To hide customizer set displayCustomizer value false in config.js.  -->
    <script src="${ contextPath }/resources/assets/vendor/js/template-customizer.js"></script>

    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="${ contextPath }/resources/assets/js/config.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<!-- // -->




<c:if test="${not empty alertMsg}">
    <script>
       alert("${alertMsg}");
    </script>
</c:if>


		<aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
          <div class="app-brand demo">
                <a href="${contextPath}" class="app-brand-link">
              <img src="${ contextPath }/resources/assets/img/mainlogo.png ">
              <span class="app-brand-text demo menu-text fw-bold">Cruella</span>
            </a>

            <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto">
              <i class="ti menu-toggle-icon d-none d-xl-block align-middle"></i>
              <i class="ti ti-x d-block d-xl-none ti-md align-middle"></i>
            </a>
          </div>

          <div class="menu-inner-shadow"></div>

          <ul class="menu-inner py-1">

           

						<!-- 대시보드 -->
            <li class="menu-item">
	            <a href="${ contextPath }/member/dashbord.do" id="dashboard" class="menu-link">
	            	<i class="menu-icon tf-icons ti ti-smart-home"></i>
	              <div data-i18n="대시보드"></div>
	            </a>
            </li>
            <!-- 메뉴 -->
            <li class="menu-header small">
              <span class="menu-header-text" data-i18n="메뉴">메뉴</span>
            </li>
            
            <!-- 마이페이지 -->
            <li class="menu-item" id="mypage">
              <a href="#" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons ti ti-user"></i>
                <div data-i18n="마이페이지">마이페이지</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="${ contextPath }/member/myinfo.do" id="side_myinfo" class="menu-link">
                    <div data-i18n="내 정보">내 정보</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="${ contextPath }/member/myinfo_workLog.do" class="menu-link" id="side_myworklog">
                    <div data-i18n="근태관리">근태관리</div>
                  </a>
                </li>
              </ul>
            </li>

            <!-- 전자결재 -->
            <li class="menu-item" id="app_main_active">
              <a href="javascript:void(0);" class="menu-link menu-toggle" >
                <i class="menu-icon tf-icons ti ti-edit"></i>
                <div data-i18n="전자결재">전자결재</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="${contextPath }/app/app_main.do" class="menu-link" id="app_active">
                    <div data-i18n="결재 작성">결재 작성</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="${contextPath }/app/box_main.do" class="menu-link" id="app_box_active">
                    <div data-i18n="결재 문서함">결재 문서함</div>
                  </a>
                </li>
              </ul>
            </li>

            <!-- 일정관리 -->
            <li class="menu-item" id="schedule">
              <a href="#" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons ti ti-calendar"></i>
                <div data-i18n="일정관리">일정관리</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="${ contextPath }/calendar/calendar.do" id="calendarAll" class="menu-link">
                    <div data-i18n="일정 관리">일정 관리</div>
                  </a>
                </li>
              </ul>
            </li>


						<!-- 자산관리 -->
            <li class="menu-item" id="items">
              <a href="#" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons ti ti-box"></i>
                <div data-i18n="자산관리">자산관리</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="${ contextPath }/supply/supply.do" id="itemsAll" class="menu-link">
                    <div data-i18n="비품 관리">비품 관리</div>
                  </a>
                </li>
              </ul>
            </li>
            <!-- 인사관리 -->
            <li class="menu-item" id="member">
              <a href="#" class="menu-link menu-toggle" >
                <i class="menu-icon tf-icons ti ti-users"></i>
                <div data-i18n="인사관리">인사관리</div>
              </a>
              <ul class="menu-sub">
                <c:if test="${ loginUser.deptCode eq 'S2'}">
                <li class="menu-item">
                
                  <a href="${ contextPath }/member/signup.do" class="menu-link" id="signup">
                    <div data-i18n="직원 등록">직원 등록</div> 
                  </a>
                </li>
                </c:if>
                <li class="menu-item">
                  <a href="${ contextPath }/member/employeelistview.do" class="menu-link" id="employeelistview">
                    <div data-i18n="직원 조회">직원 조회</div> 
                  </a>
                </li>
                <li class="menu-item">
                  <a href="${ contextPath }/wl/checkinrecordview.do" class="menu-link" id="checkinrecordview">
                    <div data-i18n="출근기록조회">출근 기록 조회</div> 
                  </a>
                </li>
                <li class="menu-item">
                  <a href="${ contextPath }/member/workhoursview.do" class="menu-link" id="workhoursview">
                    <div data-i18n="근무시간조회">근무시간 조회</div>
                  </a>
                </li>
                <c:if test="${ loginUser.deptCode eq 'S2'}">
                <li class="menu-item">
                  <a href="${ contextPath }/member/salarypayment.do" class="menu-link" id="salarypayment">
                    <div data-i18n="급여지급">급여지급</div>
                  </a>
                </li>
                </c:if>
                <li class="menu-item">
                  <a href="${ contextPath }/member/checksalary.do" class="menu-link" id="checksalary">
                    <div data-i18n="급여내역확인">급여 내역 확인</div>
                  </a>
                </li>
              </ul>
            </li>



            <!-- 게시판 -->
            <li class="menu-item" id="boardSide" >
              <a href="#" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons ti ti-list-numbers"></i>
                <div data-i18n="게시판">게시판</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="${ contextPath }/notice/noticeList.do" id="boardNotice" class="menu-link">
                    <div data-i18n="공지사항">공지사항</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="${ contextPath }/board/boardList.do" id="boardTeam" class="menu-link">
                    <div data-i18n="팀 게시판">팀 게시판</div>
                  </a>
                </li>
              </ul>
            </li>
						
						<!-- 매출분석 -->
						<li class="menu-item" id="sales">
						  <a href="#" class="menu-link menu-toggle">
						    <i class="menu-icon tf-icons ti ti-chart-dots"></i>
						    <div data-i18n="매출분석">매출분석</div>
						  </a>
						  <ul class="menu-sub">
						    <li class="menu-item">
						      <a href="${contextPath}/chart/chart.do" id="salesChart" class="menu-link">
						        <div data-i18n="차트">차트</div>
						      </a>
						    </li>
						    <c:set var="validDeptCodes" value="T1,T2,T3,T4,T5,T6,T7,T8" />
						    <c:if test="${fn:contains(validDeptCodes, loginUser.deptCode)}">
						      <li class="menu-item">
						        <a href="${contextPath}/revenue/revenue.do?deptCode=${loginUser.deptCode}" id="salesRegist" class="menu-link">
						          <div data-i18n="매출등록">매출등록</div>
						        </a>
						      </li>
						    </c:if>
						  </ul>
						</li>

            <!-- 메신저 -->
            <li class="menu-item">
              <a href="${ contextPath }/chat/chatPage.do" id="message" class="menu-link">
                <i class="menu-icon tf-icons ti ti-messages"></i>
                <div data-i18n="메신저">메신저</div>
              </a>
            </li>
					</ul>
					
					
        </aside>