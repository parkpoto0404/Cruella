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
	#app_box_active::before {
	  content: ''; /* 가상 요소 필수 */
	  display: inline-block; /* 블록 요소 */
	  width: 10px; /* 동그라미 크기 */
	  height: 10px; /* 동그라미 크기 */
	  border-radius: 50%; /* 완전한 원 */
	  background-color: transparent; /* 배경을 투명으로 설정 */
	  border: 2px solid gray; /* 초기 테두리 색상 */
	}
	#app_box_active.active::before {
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
      <!-- nav 끗 -->


   <div class="content-wrapper">
   <!-- 세션 시작 -->
    <div class="container-xxl flex-grow-1 container-p-y">
     <!-- 이쪽에 세션정보 넣어야합니다 -->
    
    
    


        <!-- Session Start -->

        <style>
          .table input[type="checkbox"]{
            zoom: 1.4;
          }
          #app_list_click tr>th>span{
            cursor: pointer;
          }
          #app_list_click tr>td{
            cursor: pointer;
          }
          .status_imp{color: red;} /* 조건문 걸어서 상태별로 색깔 바꾸기 */ 
          .status_text{color: orange;}
        </style>




        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">

               <!-- <h2>결재문서함</h2> -->
               <div class="row">
                <div class="col-md-12">
                  <div class="nav-align-top">
                    <ul class="nav nav-pills flex-column flex-sm-row mb-6 gap-2 gap-lg-0">
                      <li class="nav-item">
                        <a class="nav-link" href="${contextPath }/app/app_main.do" id="nav-link1">
                          <i class="ti-sm ti ti-user-check me-1_5"></i> 결재작성
                        </a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link active" href="#" id="nav-link2">
                          <i class="ti-sm ti ti-folder me-1_5"></i> 결재문서함
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
  
              <!-- <script>
                $(document).ready(function(){
  
                  $('#nav-link1').on('click',function(){
  
                      $('#nav-link1').addClass('active');
                      $('#nav-link2').removeClass('active');
  
                  })
                  $('#nav-link2').on('click',function(){
  
                    $('#nav-link2').addClass('active');
                    $('#nav-link1').removeClass('active');
  
                    })
                })
              </script> -->

            <div class="card">
              <div class="card-header border-bottom" style="padding: 0;">


                <div>
                 
                  <div class="card-body" style="height: 100px;">
                    <div class="row">
                      <!-- Basic -->
                      <div class="col-md-6 mb-6" style="position: relative; top: 10px;">
                        <div class="position-relative" style="display: flex;">

                          <!-- 카테고리 대분류 -->
                          <span id="select_big_type">
                            <select id="select_formType1"
                              class="select form-select form-select-lg select2-hidden-accessible"
                              style="width: 240px;">
                              <option value="선택">선택해주세요</option>
                              <option value="결재대기함" >결재대기함</option>
                              <option value="결재진행함">결재진행함</option>
                              <option value="결재완료함">결재완료함</option>
                              <option value="결재반려함">결재반려함</option>
                              <option value="참조열람함">참조열람함</option>
                            
                            </select>
                          </span>
                          
                          <script>
                          $(document).ready(function(){
                        	  $('#select_formType1').change(function(){
                        		  
                        		  var selectedValue = $(this).val();
                        		  
                        		  switch(selectedValue){
                        		  	
                        		  case "결재대기함" : location.href = "${contextPath}/app/box_standby.do"; break;
                        		  case "결재진행함" : location.href = "${contextPath}/app/box_progress.do"; break;
                        		  case "결재완료함" : location.href = "${contextPath}/app/box_complete.do"; break;
                        		  case "결재반려함" : location.href = "${contextPath}/app/box_companion.do"; break;
                        		  case "참조열람함" : location.href = "${contextPath}/app/box_view.do"; break;
                        		  
                        		  
                        		  }
                        		  
                        		
                        		  
                        	  })
                          })
                          
                          </script>

                         


                        </div>
                      </div>
                    </div>
                  </div>


                </div>

                       
                      </div>
                    </div>
                  
                  </div>
                </div>


              </div>










            </div>
            


          </div>
        </div>









          <!-- Session End -->
    
    
    
    
    
    
    </div>
   <!-- 세션 끝 -->
   
   
     <script>
     // 사이드바 처리
		document.addEventListener("DOMContentLoaded", function () {
	  	
			const element = document.getElementById("app_box_active");
			
	  	document.getElementById("app_main_active").classList.add("open");
	  	element.style.backgroundColor = "#958CF4";
	  	element.style.color = "white";
	  	element.classList.add("active");
	  	
	  	
		});
        
        
        </script>



   <!-- 푸터 시작 -->
   <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
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
   
   
   
   
   
</body>
</html>