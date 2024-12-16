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
    <div class="container-xxl flex-grow-1 container-p-y" style="margin-top: 35px;">
     <!-- 이쪽에 세션정보 넣어야합니다 -->
    
    <!-- select - option 등으로 필터링, 오더링 넣기 -->
              <div class="btn-group">
                <div class="col-12" style="margin-top:20px;">
                  <select
                    id="orderbydate"
                    name="orderbydate"
                    class="select2 form-select"
                    data-allow-clear="true">
                    <option value="선택" disabled selected style="display:none;">신청 희망일순 조회</option>
                    <option value="최신순">최신순</option>
                    <option value="오래된순">오래된순</option>
                  </select>
                </div>
              </div>


              <div class="btn-group">
                <div class="col-12" style="margin-top:20px;">
                  <select
                    id="orderbydep"
                    name="orderbydep"
                    class="select2 form-select"
                    data-allow-clear="true">
                    <option value="선택" disabled selected style="display:none;">부서별 조회</option>
                    <option value="최신순">최신순</option>
                    <option value="오래된순">오래된순</option>
                  </select>
                </div>
              </div>






             
              <!-- Category List Table -->
              <div class="card" style="margin-top:10px;"> 
                <div class="card-datatable ">
                  <table class="table border-top">
                    <thead>
                      <tr style="height:30px;">
                        <th style="text-align:center;">신청 비품 카테고리</th>
                        <th style="text-align:center;">신청 비품종류</th>
                        <th style="text-align:center;">부서</th>
                        <th style="text-align:center;">사원명</th>
                        <th style="text-align:center;">사원 번호</th>
                        <th style="text-align:center;">신청 희망일</th>
                        <th style="text-align:center;">반납 희망일</th>
                        <th></th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr style="height:55px;">
                        <td style="text-align:center;">전자기기</td>
                        <td style="text-align:center;">컴퓨터 본체</td>
                        <td style="text-align:center;"> 인사관리팀 </td>
                        <td style="text-align:center;"> 김영욱 </td>
                        <td style="text-align:center;"> C2024002 </td>
                        <td style="text-align:center;"> 2024-10-10 </td>
                        <td style="text-align:center;"> - </td>
                        <td style="text-align:center; display:inline-block;" >
                          <button
                            type="button"
                            class="btn rounded-pill btn-outline-primary btn btn-sm"
                            style="float:inline-end; margin-left:10px;">
                            승인
                          </button>
                        </td>
                      </tr>


                      <tr style="height:55px;">
                        <td style="text-align:center;">전자기기</td>
                        <td style="text-align:center;">컴퓨터 본체</td>
                        <td style="text-align:center;"> 인사관리팀 </td>
                        <td style="text-align:center;"> 김영욱 </td>
                        <td style="text-align:center;"> C2024002 </td>
                        <td style="text-align:center;"> 2024-10-10 </td>
                        <td style="text-align:center;"> - </td>
                        <td style="text-align:center; display:inline-block;" >
                          <button
                            type="button"
                            class="btn rounded-pill btn-outline-primary btn btn-sm"
                            style="float:inline-end; margin-left:10px;">
                            승인
                          </button>
                        </td>
                      </tr>


                      <tr style="height:55px;">
                        <td style="text-align:center;">사무용품</td>
                        <td style="text-align:center;">수첩</td>
                        <td style="text-align:center;"> 개발팀 </td>
                        <td style="text-align:center;"> 어쩌고 </td>
                        <td style="text-align:center;"> C2024111 </td>
                        <td style="text-align:center;"> 2024-11-30 </td>
                        <td style="text-align:center;"> - </td>
                        <td style="text-align:center; display:inline-block;" >
                          <button
                            type="button"
                            class="btn rounded-pill btn-outline-primary btn btn-sm"
                            style="float:inline-end; margin-left:10px;">
                            승인
                          </button>
                        </td>
                      </tr>
                      
                    </tbody>
                  </table>
                  <!-- 페이징바 -->


                  
                <!-- 페이징바 , 클릭한 숫자에 클래스에 active 추가하기 -->
                <div class="card-body" style="justify-items: center;">
                  <div class="row">
                    <div class="col-lg-6">
                      
                      <div class="demo-inline-spacing">
                        <!-- Basic Pagination -->
                        <nav aria-label="Page navigation">
                          <ul class="pagination">
                            <li class="page-item first">
                              <a class="page-link" href="javascript:void(0);"
                                ><i class="ti ti-chevrons-left ti-sm"></i
                              ></a>
                            </li>
                            <li class="page-item prev">
                              <a class="page-link" href="javascript:void(0);"
                                ><i class="ti ti-chevron-left ti-sm"></i
                              ></a>
                            </li>
                            <li class="page-item">
                              <a class="page-link" href="javascript:void(0);">1</a>
                            </li>
                            <li class="page-item">
                              <a class="page-link" href="javascript:void(0);">2</a>
                            </li>
                            <li class="page-item">
                              <a class="page-link" href="javascript:void(0);">3</a>
                            </li>
                            <li class="page-item">
                              <a class="page-link" href="javascript:void(0);">4</a>
                            </li>
                            <li class="page-item">
                              <a class="page-link" href="javascript:void(0);">5</a>
                            </li>
                            <li class="page-item next">
                              <a class="page-link" href="javascript:void(0);"
                                ><i class="ti ti-chevron-right ti-sm"></i
                              ></a>
                            </li>
                            <li class="page-item last">
                              <a class="page-link" href="javascript:void(0);"
                                ><i class="ti ti-chevrons-right ti-sm"></i
                              ></a>
                            </li>
                          </ul>
                        </nav>
                        <!--/ Basic Pagination -->
                       
                      </div>
                    </div>
                  
                  </div>
                </div>

                <!-- /페이징바 -->
                </div>
                
              </div>


            </div>
            
            <div style="text-align: center;">
              <button type="submit" class="btn btn-primary me-3">뒤로가기</button>
            </div>


           <!-- Session End -->
    


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