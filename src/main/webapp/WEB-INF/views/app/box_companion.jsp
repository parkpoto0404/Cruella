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

.table input[type="checkbox"] {
	zoom: 1.4;
}

#app_list_click tr>th>span {
	cursor: pointer;
}

#app_list_click tr>td {
	cursor: pointer;
}

.header_title {
	font-size: 13px;
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
                              <option value="결재반려함" selected>결재반려함</option>
                              <option value="참조열람함">참조열람함</option>
                             
                            </select>
                          </span>

                          <span id="delete_icon" style="position: relative; left: 964px; top: 25px; cursor: pointer;">
                            <i class="ti ti-trash" style="font-size: 25px;"></i>
                          </span>


                        </div>
                      </div>
                    </div>
                  </div>


                </div>


                <div class="d-flex justify-content-between align-items-center row pt-4 gap-4 gap-md-0">
                  <div class="col-md-4 user_role"></div>
                  <div class="col-md-4 user_plan"></div>
                  <div class="col-md-4 user_status"></div>
                </div>
              </div>
              <div class="card-datatable table-responsive">
                <table class="datatables-users table">
                  <tbody class="border-top" id="app_list_click">


				<c:choose>
				  <c:when test="${ empty list }" >
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td style="padding-right: 53px;">조회된 결과가 없습니다</td>
					</tr>
				</c:when>
				<c:otherwise>
                   
                	<tr id="order_tr">
                      <th></th>
                      <th><input type="checkbox" id="all_checkBox"></th>
                      <th><span class="header_title"><b>기안자</b></span></th>
                      <th></th>
                      <th style="text-align: center;">
                        <span class="header_title" style="position: relative; left: 0px;"><b>제목</b></span>
                      </th>
                      <th></th>
                      <th ><span class="header_title" style="position: relative;left: 10px;"><b>기안날짜</b></span></th>
                      <th ><span class="header_title" style="position: relative; right: 13px;"><b>중요사항</b></span></th>
                      <th ><span class="header_title" style="position: relative;right: 0px;"><b>상태</b></span></th>
                    </tr>
                    
                    

					<c:forEach var="a" items="${ list }">
                    <tr class="detail_tr" onclick="location.href='${contextPath}/app/detail.do?docNo=${a.docNo}'">
                      <td></td>
                      <!-- 체크박스 클릭시 상세페이지 이동되는 오류를 위해/ 이벤트 중지 -->
                      <td onclick="event.stopPropagation();"> 
                      <input type="checkbox" class="deleteCheck_box" value="${a.docNo}">
                      </td>
                      <td><span class="name_box">${a.memName }</span></td>
                      <td></td>
                      <td style="text-align: center;"><span class="title_box">${a.docTitle}</span></td>
                      <td></td>
                      <td>
                      
	                      <span class="appDate_box">${a.docDt }</span>
	                      <input type="hidden" value="${a.docType}" >
						  <input type="hidden" value="${a.docNo}" >
						  
                      </td>     
                      <td>
	                      	<c:choose>
	                      		<c:when test="${a.docImpo eq 'C'}">
			                      	<span class="impo_box">
				                      	일반
			                      	</span>
	                      		</c:when>
	                      		<c:when test="${a.docImpo eq 'I'}">
	                      			<span class="impo_box" style="color:#FF5252;">
				                      	중요
			                      	</span>
	                      		</c:when>
	                      		<c:when test="${a.docImpo eq 'E'}">
	                      			<span class="impo_box" style="color:#FFDB64;">
				                      	긴급
			                      	</span>
	                      		</c:when>
	                      	</c:choose>
                      	
                      </td>
                      <td>
                       
                       
                      	<span class="status_box" style="color:red;">
                      		반려
                      	</span>
                      	
                       
                      </td>
                    </tr> 
                    </c:forEach>
                    
                    </c:otherwise>
                  </c:choose>
                    

                  </tbody>
                </table>
                

                <!-- 페이징바 , 클릭한 숫자에 클래스에 active 추가하기 -->
                <div class="card-body" style="justify-items: center;">
                  <div class="row">
                    <div class="col-lg-6">
                      
                      <div class="demo-inline-spacing">
                        <!-- Basic Pagination -->
                        <nav aria-label="Page navigation">
                          <ul class="pagination">


                          <!-- 페이징 이전버튼 -->
                            <li class="page-item first ${ pi.currentPage == 1 ? 'disabled' : '' }">
                              <a class="page-link" 
                              	href="#" onclick="goPage(1);">
                                <i class="ti ti-chevrons-left ti-sm"></i>
                              </a>
                            </li> 
                            
                            <li class="page-item prev ${ pi.currentPage == 1 ? 'disabled' : '' }">
                              <a class="page-link" 
                              		href="${ contextPath }/app/box_companion.do?page=${pi.currentPage-1}">
                                <i class="ti ti-chevron-left ti-sm"></i>
                              </a>
                            </li>


							<c:forEach var="i" begin="${pi.startPage }" end="${pi.endPage }">
                            <!-- 페이징 숫자 / for문돌려서 생성 -->
                            <li class="page-item ${pi.currentPage == i ? 'active' : '' }">
                              <a class="page-link" 
                              	href="${ contextPath }/app/box_companion.do?page=${i}">${ i }</a>
                            </li>
                            </c:forEach>
                           

                            <!-- 페이징 다음버튼 -->
                            <li class="page-item next ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }">
                              <a class="page-link" 
                              		href="${ contextPath }/app/box_companion.do?page=${pi.currentPage+1}">
                                <i class="ti ti-chevron-right ti-sm"></i>
                              </a>
                            </li>
                            
                           <li class="page-item last ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }">
                              <a class="page-link" 
                              		href="#" onclick="goPage(${pi.maxPage})">
                                <i class="ti ti-chevrons-right ti-sm"></i>
                              </a>
                           </li> 
                           
                           
                          </ul>
                        </nav>
                        <!--/ Basic Pagination -->
                       
                      </div>
                    </div>
                  
                  </div>
                </div>


              </div>




            </div>
            


          </div>
        </div>


  <script>
      // 다수 페이징버튼          
     function goPage(pNum){
                        	   
       window.location.href = '${contextPath}/app/box_companion.do?page=' + pNum;
 	}
     
     
     $(document).ready(function() {
    	    
     		// check박스 이벤트함수
    	    $('#all_checkBox').on('click', function() {
    	        $('.deleteCheck_box').prop('checked', this.checked);
    	    });

    	    
    	    $('.deleteCheck_box').on('click', function() {
    	        if ($('.deleteCheck_box:checked').length === $('.deleteCheck_box').length) {
    	            $('#all_checkBox').prop('checked', true); 
    	        } else {
    	            $('#all_checkBox').prop('checked', false); 
    	        }
    	    });
    	    
    	    
    	    
    	    $('#select_formType1').change(function(){ // select 체인지 이벤트시
      		  
      		  var selectedValue = $(this).val();
      		  
      		  switch(selectedValue){
      		  	
      		  case "결재대기함" : location.href = "${contextPath}/app/box_standby.do"; break;
      		  case "결재진행함" : location.href = "${contextPath}/app/box_progress.do"; break;
      		  case "결재완료함" : location.href = "${contextPath}/app/box_complete.do"; break;
      		  case "결재반려함" : location.href = "${contextPath}/app/box_companion.do"; break;
      		  case "참조열람함" : location.href = "${contextPath}/app/box_view.do"; break;
      		  
      		  
      		  }
      		  
      		
      		  
      	  })
      	  
    	    
    	   /*   function rowClick(event, url) {
    			// 추가적으로 필요하면 조건을 확인한 뒤 URL 이동
    			window.location.href = url;
  			} */
  			
  			
   
    		// 체크한 기안서들 삭제
    	    $('#delete_icon').on('click',function(){
    	    	
    	    	var selectedDocNos = [];
    	    	
    	    if(confirm('기안서를 삭제하시겠습니까?')){
    	    	
    	        $('.deleteCheck_box:checked').each(function() {
    	        	
    	          var docNo = $(this).val(); 
    	          selectedDocNos.push(docNo);
    	          console.log("Selected docNo: ", selectedDocNos);
    	          
    	        });
    	        
    	        
    	        
				if(selectedDocNos.length > 0){
    	    		
    	    		$.ajax({
    	    		    url: '${contextPath}/app/deleteApp.do',
    	    		    type: 'POST',
    	    		    contentType: 'application/json',  
    	    		    data: JSON.stringify({ 
    	    		    	docNos: selectedDocNos 
    	    		    	}),  
    	    		    success: function(res) {
    	    		        if (res > 0) {
    	    		            alert('성공적으로 삭제했습니다');
    	    		            location.href = "${contextPath}/app/box_companion.do";
    	    		        }
    	    		    }
    	    		});
	    	    	
    	    	}

    	    	
    	    }
	
    	    	
    	    })

    	    
    	});

     
     // 사이드바 css 처리
		document.addEventListener("DOMContentLoaded", function () {
	  	
		const element = document.getElementById("app_box_active");
			
	  	document.getElementById("app_main_active").classList.add("open");
	  	element.style.backgroundColor = "#958CF4";
	  	element.style.color = "white";
	  	element.classList.add("active");
	  	
	  	
		});
     
     
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
 
 </script>

    
   </div>
   <!-- 세션 끝 -->
   



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