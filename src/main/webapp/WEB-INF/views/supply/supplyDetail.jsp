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
                <button
                  type="button"
                  class="btn btn-label-secondary dropdown-toggle"
                  data-bs-toggle="dropdown"
                  aria-expanded="false">
                  수리내역별 조회
                </button>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="javascript:void(0);">O</a></li>
                  <li><a class="dropdown-item" href="javascript:void(0);">X</a></li>
                </ul>
              </div>


              <div class="btn-group">
                <button
                  type="button"
                  class="btn btn-label-secondary dropdown-toggle"
                  data-bs-toggle="dropdown"
                  aria-expanded="false">
                  상태별 조회
                </button>
                <!-- 이 탭은 전자기기 부분에서만 보이게 -->
                 <!-- 사무용품이나 기타는 오름차순, 내림차순으로 보이게? 필터링도 넣으면 좋을거같은데.. -->
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="javascript:void(0);">정상</a></li>
                  <li><a class="dropdown-item" href="javascript:void(0);">고장</a></li>
                  <li><a class="dropdown-item" href="javascript:void(0);">수리중</a></li>

                </ul>
              </div>


              <!-- Category List Table -->
              <div class="card" style="margin-top:10px;"> 
                <div class="card-datatable ">
                  <table class="table border-top">
                    <thead>
                      <tr style="height:30px;">
                        <th style="text-align:center;">비품명</th>
                        <th style="text-align:center;">모델 &nbsp;</th>
                        <th style="text-align:center;">첨부파일</th>
                        <th style="text-align:center;">비품추가일</th>
                        <th style="text-align:center;">수리내역</th>
                        <th style="text-align:center;">상태</th>
                        <th></th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr style="height:55px;">
                        <td style="text-align:center;"> 컴퓨터 본체1 </td>
                        <td style="text-align:center;"> DELL52431AFE3 &nbsp;</td>
                        <td style="text-align:center;"> afwpneklagjlsfd_img </td>
                        <td style="text-align:center;"> 2023년 05월 17일 </td>
                        <td style="text-align:center;"> X </td>
                        <td style="text-align:center;"> 정상 </td>
                        <td style="text-align:center;">
                          <!-- 모달 버튼 -->
                          <button
                            type="button"
                            class="btn rounded-pill btn-label-primary"
                            data-bs-toggle="modal" 
                            data-bs-target="#modify">
                            수정
                          </button>
                        </td>
                      </tr>




              <!-- 비품 수정 버튼 클릭시 모달 -->
              <div class="modal fade" id="modify" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-simple modal-add-new-address">
                  <div class="modal-content">
                    <div class="modal-body">
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      <div class="text-center mb-6">
                        <h4 class="address-title mb-2" style="padding-bottom:30px;">비품 수정</h4>
                      </div>
                      <form id="modifyForm" class="row g-6" onsubmit="return false">
                        <div class="col-12">
                          <div class="row">
                            <div class="col-md mb-md-0 mb-4">
                              <div class="form-check custom-option custom-option-icon">
                                <label class="form-check-label custom-option-content" for="customRadioHome">
                                  <span class="custom-option-body">
                                    <svg
                                      width="28"
                                      height="28"
                                      viewBox="0 0 28 28"
                                      fill="none"
                                      xmlns="http://www.w3.org/2000/svg">
                                      <path
                                        opacity="0.2"
                                        d="M16.625 23.625V16.625H11.375V23.625H4.37501V12.6328C4.37437 12.5113 4.39937 12.391 4.44837 12.2798C4.49737 12.1686 4.56928 12.069 4.65939 11.9875L13.4094 4.03592C13.5689 3.88911 13.7778 3.80762 13.9945 3.80762C14.2113 3.80762 14.4202 3.88911 14.5797 4.03592L23.3406 11.9875C23.4287 12.0706 23.4992 12.1706 23.548 12.2814C23.5969 12.3922 23.6231 12.5117 23.625 12.6328V23.625H16.625Z" />
                                      <path
                                        d="M23.625 23.625V12.6328C23.623 12.5117 23.5969 12.3922 23.548 12.2814C23.4992 12.1706 23.4287 12.0706 23.3406 11.9875L14.5797 4.03592C14.4202 3.88911 14.2113 3.80762 13.9945 3.80762C13.7777 3.80762 13.5689 3.88911 13.4094 4.03592L4.65937 11.9875C4.56926 12.069 4.49736 12.1686 4.44836 12.2798C4.39936 12.391 4.37436 12.5113 4.375 12.6328V23.625M1.75 23.625H26.25M16.625 23.625V17.5C16.625 17.2679 16.5328 17.0454 16.3687 16.8813C16.2046 16.7172 15.9821 16.625 15.75 16.625H12.25C12.0179 16.625 11.7954 16.7172 11.6313 16.8813C11.4672 17.0454 11.375 17.2679 11.375 17.5V23.625"
                                        stroke-width="2"
                                        stroke-linecap="round"
                                        stroke-linejoin="round" />
                                    </svg>
                                    <span class="custom-option-title">첨부파일</span>
                                  </span>
                                  <input
                                    name="customRadioIcon"
                                    class="form-check-input"
                                    type="radio"
                                    value=""
                                    id="customRadioHome"
                                    checked />
                                </label>
                              </div>
                            </div>
                            




                            <div class="col-12" style="margin-top:20px;">
                              <label class="form-label" for="modalAddressCountry">카테고리</label>
                              <select
                                id="modalAddressCountry"
                                name="modalAddressCountry"
                                class="select2 form-select"
                                data-allow-clear="true">
                                <option value="전자기기">전자기기</option>
                                <option value="문구">문구</option>
                                <option value="의류">의류</option>
                                <option value="기타">기타</option>
                              </select>
                            </div>



                          </div>
                        </div>
                        <div class="col-12" style="margin-top:20px;">
                          <label class="form-label" for="modalAddressFirstName">비품명</label>
                          <input
                            type="text"
                            id="modalAddressFirstName"
                            name="modalAddressFirstName"
                            class="form-control" />
                        </div>
                        <div class="col-12" style="margin-top:20px;">
                          <label class="form-label" for="modalAddressLastName">모델명</label>
                          <input
                            type="text"
                            id="modalAddressLastName"
                            name="modalAddressLastName"
                            class="form-control"/>
                        </div>


                        <div class="col-12" style="margin-top:20px;">
                          <label class="form-label" for="modalAddressCountry">수리내역</label>
                          <select
                            id="modalAddressCountry"
                            name="modalAddressCountry"
                            class="select2 form-select"
                            data-allow-clear="true">
                            <option value="O">O</option>
                            <option value="X">X</option>
                          </select>
                        </div>

                        <!-- 수리내역이 O 일 때만 나타나게? -->

                        <div class="col-12" style="margin-top:20px;">
                          <label class="form-label" for="modalAddressLastName">수리 상세 내용</label>
                          <input
                            type="text"
                            id="modalAddressLastName"
                            name="modalAddressLastName"
                            class="form-control" />
                        </div>

                        <!-- 상태 select에만 x표시 뜨는거 수정해보기 -->
                        <div class="col-12" style="margin-top:20px;">
                          <label class="form-label" for="modalAddressCountry">상태</label>
                          <select
                            id="modalAddressCountry"
                            name="modalAddressCountry"
                            class="select2 form-select"
                            data-allow-clear="true">
                            <option value="정상">정상</option>
                            <option value="고장">고장</option>
                            <option value="수리중">수리중</option>
                          </select>
                        </div>


                        
                        <div class="col-12 text-center" style="margin-top:50px;">
                          <button type="submit" class="btn btn-primary me-3">수정</button>
                          <button
                            type="reset"
                            class="btn btn-label-secondary"
                            data-bs-dismiss="modal"
                            aria-label="Close">
                            취소
                          </button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>






                      <tr style="height:55px;">
                        <td style="text-align:center;"> 컴퓨터 본체2 </td>
                        <td style="text-align:center;"> DELL52431AFE3 &nbsp;</td>
                        <td style="text-align:center;"> afwpneklagjlsfd_img </td>
                        <td style="text-align:center;"> 2023년 05월 17일 </td>
                        <td style="text-align:center;"> O </td>
                        <td style="text-align:center;"> 고장 </td>
                        <td style="text-align:center;"><button type="button" class="btn rounded-pill btn-label-primary">수정</button></td>
                      </tr>
                      <tr style="height:55px;">
                        <td style="text-align:center;"> 컴퓨터 본체3 </td>
                        <td style="text-align:center;"> DELL52431AFE3 &nbsp;</td>
                        <td style="text-align:center;"> afwpneklagjlsfd_img </td>
                        <td style="text-align:center;"> 2023년 05월 17일 </td>
                        <td style="text-align:center;"> X </td>
                        <td style="text-align:center;"> 정상 </td>
                        <td style="text-align:center;"><button type="button" class="btn rounded-pill btn-label-primary">수정</button></td>
                      </tr>
                      <tr style="height:55px;">
                        <td style="text-align:center;"> 컴퓨터 본체4 </td>
                        <td style="text-align:center;"> DELL52431AFE3 &nbsp;</td>
                        <td style="text-align:center;"> afwpneklagjlsfd_img </td>
                        <td style="text-align:center;"> 2023년 05월 17일 </td>
                        <td style="text-align:center;"> X </td>
                        <td style="text-align:center;"> 정상 </td>
                        <td style="text-align:center;"><button type="button" class="btn rounded-pill btn-label-primary">수정</button></td>
                      </tr>
                      <tr style="height:55px;">
                        <td style="text-align:center;"> 컴퓨터 본체5 </td>
                        <td style="text-align:center;"> DELL52431AFE3 &nbsp;</td>
                        <td style="text-align:center;"> afwpneklagjlsfd_img </td>
                        <td style="text-align:center;"> 2023년 05월 17일 </td>
                        <td style="text-align:center;"> X </td>
                        <td style="text-align:center;"> 정상 </td>
                        <td style="text-align:center;"><button type="button" class="btn rounded-pill btn-label-primary">수정</button></td>
                      </tr>
                      <tr style="height:55px;">
                        <td style="text-align:center;"> 컴퓨터 본체6 </td>
                        <td style="text-align:center;"> DELL52431AFE3 &nbsp;</td>
                        <td style="text-align:center;"> afwpneklagjlsfd_img </td>
                        <td style="text-align:center;"> 2023년 05월 17일 </td>
                        <td style="text-align:center;"> X </td>
                        <td style="text-align:center;"> 정상 </td>
                        <td style="text-align:center;"><button type="button" class="btn rounded-pill btn-label-primary">수정</button></td>
                      </tr>
                      <tr style="height:55px;">
                        <td style="text-align:center;"> 컴퓨터 본체7 </td>
                        <td style="text-align:center;"> DELL52431AFE3 &nbsp;</td>
                        <td style="text-align:center;"> afwpneklagjlsfd_img </td>
                        <td style="text-align:center;"> 2023년 05월 17일 </td>
                        <td style="text-align:center;"> X </td>
                        <td style="text-align:center;"> 정상 </td>
                        <td style="text-align:center;"><button type="button" class="btn rounded-pill btn-label-primary">수정</button></td>
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