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

	.select2-selection__placeholder{
		display: none;
	}
	
	.select2-selection__rendered{
		display: none;
	}
	
	.pagination .page-item .page-link {
    cursor: pointer;
    
   }
	
      #itemsAll::before {
        content: ''; /* 가상 요소 필수 */
        display: inline-block; /* 블록 요소 */
        width: 10px; /* 동그라미 크기 */
        height: 10px; /* 동그라미 크기 */
        border-radius: 50%; /* 완전한 원 */
        background-color: transparent; /* 배경을 투명으로 설정 */
        border: 2px solid gray; /* 초기 테두리 색상 */
      }
      #itemsAll.active::before {
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
    <div class="container-xxl flex-grow-1 container-p-y" style="margin-top: 35px;">
     <!-- 이쪽에 세션정보 넣어야합니다 -->
    
    <!-- select - option 등으로 필터링, 오더링 넣기 -->
              <div class="btn-group">
                <button
                	id="categoryId"
                  type="button"
                  class="btn btn-label-secondary dropdown-toggle"
                  data-bs-toggle="dropdown"
                  aria-expanded="false">
                  카테고리별 조회
                </button>
                <ul class="dropdown-menu" >
							    <li>
							     <a class="dropdown-item" href="javascript:void(0);" onclick="updateButtonText(this)">전체
							    <input type="hidden" value="전체">
							    </a> 
							    
							    </li>
							    
							    <li>
							     <a class="dropdown-item" href="javascript:void(0);" onclick="updateButtonText(this)">전자기기</a> 
							    </li>
							    <li>
							     <a class="dropdown-item" href="javascript:void(0);" onclick="updateButtonText(this)">사무용품</a> 
							    </li>
							    <li>
							     <a class="dropdown-item" href="javascript:void(0);" onclick="updateButtonText(this)">기타</a> 
							    </li>
							  </ul>
              </div>


							<!--  
              <c:if test="${ loginUser.deptCode eq 'S3' }">
              <button onclick="location.href='${contextPath}/supply/supplyRegist.do'" 
                type="button"
                class="btn btn-outline-primary"
                style="float:inline-end; margin-left:10px;">
                비품 신청목록
              </button>
              </c:if>
							-->
							
							
              <!-- /비품 신청서 버튼 -->

              <!-- 비품 추가 모달 버튼 --> <!-- 지원팀만 보이게 쿼리문 수정-->
              <c:if test="${ loginUser.deptCode eq 'S3' }">
                <button
                  type="button"
                  class="btn btn-outline-primary"
                  data-bs-toggle="modal" 
                  data-bs-target="#addNewItem"
                  style="float:inline-end; margin-left:10px;">
                  비품 추가
                </button>
              </c:if>

                <!-- 비품 신청 모달 버튼 ( 아직 구현안함 ) -->
               <!--
                <button
                type="button"
                class="btn btn-primary"
                data-bs-toggle="modal" 
                data-bs-target="#applySupply"
                style="float:inline-end;">
                비품 신청
              </button>
							  -->





              <!-- 비품 추가 모달창 -->
              <div class="modal fade" id="addNewItem" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-simple modal-add-new-address">
                  <div class="modal-content">
                    <div class="modal-body">
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      <div class="text-center mb-6">
                        <h4 class="address-title mb-2" style="padding-bottom:10px;">비품 추가</h4>
                      </div>
                      <form id="addNewItemForm" action="${ contextPath }/supply/insert.do" method="post" class="row g-6" enctype="multipart/form-data">
                        <div class="col-12">
                          <div class="row">
                            <div class="col-md mb-md-0 mb-4">
                              <div class="form-check custom-option custom-option-icon">
                                <label class="form-check-label custom-option-content" for="upfile">
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
                                    <span style="font-size: 10px;" >이미지 파일만 업로드하세요.</span>
                                  </span>
                                  <input
                                    name="uploadFile"
                                    class="form-check-input"
                                    type="file"
                                    value=""
                                    id="upfile"
                                    accept="image/*"
                                    hidden
                                    checked
                                    multiple
                                     />
                                </label>
                              </div>
                              
                              <div id="fileListContainer" style="margin-top: 20px;">
		                            <ul id="fileList"></ul> <!-- 파일 목록을 표시할 부분 -->
                       			 </div>
                              
                              
                              
                            </div>
                            


                            <div class="col-12" style="margin-top:20px;">
                              <label class="form-label" for="supCategory">카테고리</label>
                          <select
                            id="supCategory"
                            name="supCategory"
                            class="select2 form-select"
                            data-allow-clear="true">
                            <option value="" disabled selected hidden>선택</option>
                            <option value="전자기기">전자기기</option>
                            <option value="사무용품">사무용품</option>
                            <option value="기타">기타</option>
                          </select>
                            </div>



                          </div>
                        </div>
                        
                        <div class="col-12" style="margin-top:20px;">
                          <label class="form-label" for="supType">비품 종류</label>
                          <select
                            id="supType"
                            name="supType"
                            class="select2 form-select"
                            data-allow-clear="true">
                            <option value="선택" disabled selected style="display:none;">선택</option>
                            <option value="컴퓨터 본체">컴퓨터 본체</option>
                            <option value="노트북">노트북</option>
                            <option value="마우스">마우스</option>
                            <option value="결제 단말기">결제 단말기</option>
                            <option value="키보드">키보드</option>
                            <option value="복합기">복합기</option>
                            <option value="빔 프로젝터">빔 프로젝터</option>
                          </select>
                        </div>
                        
                        
                        
                        
                        <!--  
                        <div class="col-12" style="margin-top:20px;">
                          <label class="form-label" for="supplyTyple">비품종류</label>
                          <input
                            type="text"
                            id="supplyTyple"
                            name="modalAddressFirstName"
                            class="form-control" />
                        </div>
                        -->
                        
                        <div class="col-12" style="margin-top:20px;">
                          <label class="form-label" for="supName">비품명</label>
                          <input
                            type="text"
                            id="supName"
                            name="supName"
                            class="form-control" />
                        </div>
                        <div class="col-12" style="margin-top:20px;">
                          <label class="form-label" for="supModel">모델명</label>
                          <input
                            type="text"
                            id="supModel"
                            name="supModel"
                            class="form-control"/>
                        </div>

											<!--  
                        <div class="col-12" style="margin-top:20px;">
                          <label class="form-label" for="repairHistory">수리내역</label>
                          <select
                            id="repairHistory"
                            name="repairHistory"
                            class="select2 form-select"
                            data-allow-clear="true">
                            <option value="O">O</option>
                            <option value="X">X</option>
                          </select>
                        </div>

                        

                        <div class="col-12" style="margin-top:20px;">
                          <label class="form-label" for="modalAddressLastName">수리 상세 내용</label>
                          <input
                            type="text"
                            id="modalAddressLastName"
                            name="modalAddressLastName"
                            class="form-control" />
                        </div>
                        -->

                       
                        <div class="col-12" style="margin-top:20px;">
                          <label class="form-label" for="supRepair">상태</label>
                          <select
                            id="supRepair"
                            name="supRepair"
                            class="select2 form-select"
                            data-allow-clear="true">
                            <option value="N">정상</option>
                            <option value="Y">수리중</option>
                          </select>
                        </div>
													

                        
                        <div class="col-12 text-center" style="margin-top:50px;">
                          <button type="submit" class="btn btn-primary me-3">추가</button>
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

              <!-- /비품 추가 모달창 -->




              <!-- 비품 신청 모달창  --> 
              <div class="modal fade" id="applySupply" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-simple modal-add-new-address">
                  <div class="modal-content" style="width:600px; margin-left: 100px;">
                    <div class="modal-body">
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      <div class="text-center mb-6">
                        <h4 class="address-title mb-2" style="padding-bottom:30px;">비품 신청</h4>
                      </div>
                      <form id="applySupplyForm" action="${ contextPath }/supply/rental.do" method="post" class="row g-6">
                        <div class="col-12 col-md-6" style="margin-top:20px; width:500px;">
                          <label class="form-label" for="supplyCategory">카테고리</label>
                          <select
                            id="supplyCategory"
                            name="supCategory"
                            class="select2 form-select"
                            data-allow-clear="true">
                            <option value="" disabled selected hidden>선택</option>
                            <option value="전자기기">전자기기</option>
                            <option value="사무용품">사무용품</option>
                            <option value="기타">기타</option>
                          </select>
                        </div>

                        <div class="col-12" style="margin-top:20px; width:500px;">
                          <label class="form-label" for="supplyType">비품 종류</label>
                          <select
                            id="supplyType"
                            name="supType"
                            class="select2 form-select"
                            data-allow-clear="true">
                            <option value="선택" disabled selected style="display:none;">선택</option>
                            <option value="컴퓨터 본체">컴퓨터 본체</option>
                            <option value="노트북">노트북</option>
                            <option value="마우스">마우스</option>
                            <option value="결제 단말기">결제 단말기</option>
                            <option value="키보드">키보드</option>
                            <option value="복합기">복합기</option>
                            <option value="빔 프로젝터">빔 프로젝터</option>
                          </select>
                        </div>


                        <div class="col-12 text-center" style="margin-top:50px;">
                          <button type="submit" class="btn btn-primary me-3">신청</button>
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

              <!-- /비품 신청 모달창 -->




	<script>
	
	$('#supplyCategory').change(function() {
        // id="supplyCategory"에 들어있는 value 값 가져오기 ( val 은 jquery문 )
        const selectedValue = $(this).val();

        console.log(supplyCategory);
        
        
        
        $('#supplyType').html("");

        let a = "";
        if(selectedValue === '전자기기'){
          a += '<option value="선택" disabled selected style="display:none;">선택</option>'
          a += '<option value="컴퓨터 본체">컴퓨터 본체</option>'
          a += '<option value="노트북">노트북</option>'
          a += '<option value="마우스">마우스</option>'
          a += '<option value="결제 단말기">결제 단말기</option>'
          a += '<option value="키보드">키보드</option>'
          a += '<option value="복합기">복합기</option>'
          a += '<option value="빔 프로젝터">빔 프로젝터</option>'
          
        }else if(selectedValue === '사무용품'){
        	a += '<option value="선택" disabled selected style="display:none;">선택</option>'
          a += '<option value="펜">펜</option>'
          a += '<option value="포스트잇">포스트잇</option>'
          a += '<option value="A4용지">A4용지</option>'
          a += '<option value="가위">가위</option>'
          a += '<option value="자">자</option>'
          a += '<option value="형광펜">형광펜</option>'
          a += '<option value="수첩">수첩</option>'
          a += '<option value="연필">연필</option>'
        }else{ // '기타'
        	a += '<option value="선택" disabled selected style="display:none;">선택</option>'
          a += '<option value="이동식 탈의실">이동식 탈의실</option>'
          a += '<option value="옷걸이">옷걸이</option>'
          a += '<option value="행사 매대">행사 매대</option>'
          a += '<option value="전신거울">전신거울</option>'
        }

       
        
        $('#supplyType').html(a); // jQuery문으로 innerHTML에 넣는 구문이 .html이다.



    });
	
	
	

	
	$('#supCategory').change(function() {
        // id="supplyCategory"에 들어있는 value 값 가져오기 ( val 은 jquery문 )
        const selectedValue = $(this).val();

        console.log(supCategory);
        
        
        
        $('#supType').html("");

        let a = "";
        if(selectedValue === '전자기기'){
          a += '<option value="선택" disabled selected style="display:none;">선택</option>'
          a += '<option value="컴퓨터 본체">컴퓨터 본체</option>'
          a += '<option value="노트북">노트북</option>'
          a += '<option value="마우스">마우스</option>'
          a += '<option value="결제 단말기">결제 단말기</option>'
          a += '<option value="키보드">키보드</option>'
          a += '<option value="복합기">복합기</option>'
          a += '<option value="빔 프로젝터">빔 프로젝터</option>'
          
        }else if(selectedValue === '사무용품'){
        	a += '<option value="선택" disabled selected style="display:none;">선택</option>'
          a += '<option value="펜">펜</option>'
          a += '<option value="포스트잇">포스트잇</option>'
          a += '<option value="A4용지">A4용지</option>'
          a += '<option value="가위">가위</option>'
          a += '<option value="자">자</option>'
          a += '<option value="형광펜">형광펜</option>'
          a += '<option value="수첩">수첩</option>'
          a += '<option value="연필">연필</option>'
        }else{ // '기타'
        	a += '<option value="선택" disabled selected style="display:none;">선택</option>'
          a += '<option value="이동식 탈의실">이동식 탈의실</option>'
          a += '<option value="옷걸이">옷걸이</option>'
          a += '<option value="행사 매대">행사 매대</option>'
          a += '<option value="전신거울">전신거울</option>'
        }

       
        
        $('#supType').html(a); // jQuery문으로 innerHTML에 넣는 구문이 .html이다.



    });
	
	


	</script>
                 







              <!-- Category List Table -->
              <div class="card" style="margin-top:10px;"> 
                <div class="card-datatable ">
                  <table class="table border-top">
                    <thead>
                      <tr style="height:30px;">
                        <th style="text-align:center; width:150px;">카테고리</th>
                        <th style="text-align:center;">비품종류</th>
                        <th style="text-align:center;">총 수량</th>
                        <th style="text-align:center;">잔여 재고</th>
                        <th style="text-align:center;">대여중</th>
                        <th style="text-align:center;">수리중</th>
                      <!-- 지급 현황 지원팀만 이 열이 보이게 <th style="text-align:center;"> </th>-->
                      </tr>
                    </thead>
                    <tbody id="tbodyId">
                  <!--  
                      <c:choose>
									<c:when test="${ empty list }">
										<tr style="height:55px;">
											<td colspan="${ loginUser.deptCode != 'S3' ? 6 : 5 }" style="text-align:center;">조회된 비품이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="s" items="${ list }">
											<tr style="height:55px;" onclick="location.href='${contextPath}/supply/supply.do?no=${s.supNo}'">
												<td style="text-align:center; width:150px;">${ s.supCategory }</td>
                        <td style="text-align:center;"> ${ s.supType } &nbsp;
                          <button type="button" class="btn rounded-pill btn-outline-primary btn btn-sm">정보</button>
                        </td>
                        <td style="text-align:center;"> ${ s.leftSupply } </td>
                        <td style="text-align:center;"> ${ s.repairSupply } </td>
                        <td style="text-align:center;"> ${ s.workSupply } </td>
                        <td style="text-align:center;">
                          <button type="button" class="btn rounded-pill btn-outline-info btn btn-sm">상세보기</button>
                        </td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
								 -->   
							
								 
								 
								 
								 
								 
                    </tbody>
                  </table>

                  <!-- 페이징바 -->


								<div class="card-body">
							<div class="row">
								<span class="col-lg-12 d-flex justify-content-center">
									<div class="demo-inline-spacing">
										<nav aria-label="Page navigation" id="paginationId">
										
										
										
										
										
										
										
										</nav>
									</div>
								</span>
							</div>
						</div>
					</div>

                  
                
						
                </div>
              </div>




                
            </div>
            
            
           <!-- Session End -->
    
    
    
    
    
   <!-- 세션 끝 -->

		<script>
		
		
		  function goToPage(pageNumber) {
		    // URL의 query string에 page 파라미터 추가
		    const url = new URL(window.location.href);
		    url.searchParams.set('page', pageNumber);
		    window.location.href = url.toString();
		  }
		
		
		</script>


	<script>
	


	$(document).ready(function() {
	    // 파일 첨부 시 파일 목록을 업데이트하는 함수
	    $('#upfile').on('change', function(evt) {
	        const files = evt.target.files; // FileList[0: File, 1: File, ..]
	        let totalSize = 0;

	        // 파일 목록을 보여줄 리스트 초기화
	        $('#fileList').empty();

	        for (let i = 0; i < files.length; i++) {
	            if (files[i].size > 10 * 1024 * 1024) { // 파일 개별 크기 제한 (10MB)
	                alert('첨부파일의 최대 크기는 10MB입니다.');
	                evt.target.value = '';
	                return;
	            }

	            totalSize += files[i].size;

	            if (totalSize > 100 * 1024 * 1024) { // 전체 파일 크기 제한 (100MB)
	                alert('전체 첨부파일의 최대 크기는 100MB입니다.');
	                evt.target.value = '';
	                return;
	            }

	            // 파일 정보를 리스트에 추가
	            const listItem = $('<li>')
	                .css({
	                    'list-style-type': 'none', // 기본 동그라미 모양 없애기
	                    'margin-bottom': '10px'  // 각 항목 간 여백 추가
	                });

	            // 파일명 클릭 시 다운로드
	            const downloadLink = $('<a>')
	                .attr('href', URL.createObjectURL(files[i]))
	                .attr('download', files[i].name)
	                .text(files[i].name)  // "다운로드" 글씨는 없애고 파일명만 표시
	                .css({
	                    'text-decoration': 'none',  // 링크 스타일 제거
	                    'color': '#007bff'          // 기본 링크 색상 (원하는 색상으로 변경 가능)
	                })
	                .appendTo(listItem);

	            $('#fileList').append(listItem);
	        }
	    });

	    // 모달창을 닫을 때 입력된 파일 목록 초기화
	    $('#modalCloseButton').on('click', function() { // 모달 닫는 버튼을 클릭했을 때
	        $('#upfile').val('');  // 파일 입력 초기화
	        $('#fileList').empty(); // 파일 목록 초기화
	    });
	});
	


	
	</script>


							



	    <script>
	    
	    $(document).ready(function(){
	    	
	    	selectSupplyList("전체", 1);
		  })
	    
	    
	  // 버튼에 선택된 항목 텍스트를 업데이트하는 함수
	  function updateButtonText(element) {
		  
		  console.log("updateButtonText함수 실행됨");
	    const button = element.closest('.btn-group').querySelector('button');
	    
	    button.innerHTML = element.innerHTML;
	    
	    
	    
	    
	    selectSupplyList(element.innerText, 1);
	  }
	  
		// 현재 선택되어있는 카테고리에 맞춰서 리스트 조회하는 ajax
		
	   function selectSupplyList(category, pageNo){ 
			
			
		    $.ajax({
				  url: '${contextPath}/supply/list.do', // ajax로 리스트 조회용 controller 따로 호출
				  type: 'GET',
				  data: {
					  supCategory: category,
					  pageNo: pageNo
				  },
				  success: function(res){
					  //console.log(res);
					  //console.log(res.list);  // {pi: {}, list: []}
					  
					  let a = "";
					  for(let i=0; i<res.list.length; i++){
						  a += "<tr style='height:55px;'>"
							     +		"<td style='text-align:center; width:150px;'>" + res.list[i].supCategory + "</td>"

							     +		"<td style='text-align:center;'>" + res.list[i].supType 
							     
							      +		"</td>"
							     +		"<td style='text-align:center;'>" + res.list[i].totalSupply + "</td>"
							     +		"<td style='text-align:center;'>" + res.list[i].leftSupply + "</td>"
							     +		"<td style='text-align:center;'>" + res.list[i].rentSupply + "</td>"
							     +		"<td style='text-align:center;'>" + res.list[i].repairSupply + "</td>"
							     +		"<td style='text-align:center;'>" 
							   		
									 +		"</td>"
									 +  "</tr>"
									 
									 
									  
									 <!-- 
									 
								     +
								     				"<button style='margin-left: 10px;' type='button' class='btn rounded-pill btn-outline-primary btn btn-sm'>" + '정보' + "</button>"
								     
									 -->
									 
									 
									 
									 
									 <!--
									 +
					     				"<button style='margin-left: 10px;' type='button' class='btn rounded-pill btn-outline-primary btn btn-sm'>" + '정보' + "</button>"
					    
									 -->
									 
									 
									 <!--
									 

								     +
										  			"<button type='button' class='btn rounded-pill btn-outline-info btn btn-sm'>" + '상세보기' + "</button>"	
									 -->
									 
									 
									 
					  }
					  $("#tbodyId").html(a);

					  
					  console.log(res.pi);
					  
					// Pagination HTML
					    let paginationHtml = "<ul class='pagination'>";

					    
					    
					  

					    // 첫 페이지로 이동
							paginationHtml += "<li class='page-item first " + (res.pi.currentPage == 1 ? 'disabled' : '') + "'>"
							                + "<a class='page-link' onclick='selectSupplyList(" + '"' + category + '", ' + 1 + ")'>"
							                + "<i class='ti ti-chevrons-left ti-sm'></i></a></li>";

							// 이전 페이지로 이동
							paginationHtml += "<li class='page-item prev " + (pageNo == 1 ? 'disabled' : '') + "'>"
							                + "<a class='page-link' onclick='selectSupplyList(" + '"' + category + '", ' + (pageNo -1) + ")'>"
							                + "<i class='ti ti-chevron-left ti-sm'></i></a></li>";
					    

					    // 페이지 번호 출력
					    for (let i = res.pi.startPage; i <= res.pi.endPage; i++) {
					        paginationHtml += "<li class='page-item " + (res.pi.currentPage == i ? 'active' : '') + "'>"
					                        + "<a class='page-link' onclick='selectSupplyList(" + '"' + category + '", ' + i + ")'>" + i + "</a></li>";
					    }
					     
					     // 다음 페이지로 이동
							paginationHtml += "<li class='page-item next " + (res.pi.currentPage == res.pi.maxPage ? 'disabled' : '') + "'>"
							                + "<a class='page-link' onclick='selectSupplyList(" + '"' + category + '", ' + (pageNo + 1) + ")'>"
							                + "<i class='ti ti-chevron-right ti-sm'></i></a></li>";

							// 마지막 페이지로 이동
							paginationHtml += "<li class='page-item last " + (res.pi.currentPage == res.pi.maxPage ? 'disabled' : '') + "'>"
							                + "<a class='page-link' onclick='selectSupplyList(" + '"' + category + '", ' + res.pi.maxPage + ")'>"
							                + "<i class='ti ti-chevrons-right ti-sm'></i></a></li>";

					     
					     
					     
					    paginationHtml += "</ul>";
					    
					    
					    
					    

					    // Pagination HTML 삽입
					    $("#paginationId").html(paginationHtml);
					  
										/*
											<ul class="pagination">
												<!-- 첫 페이지로 이동 -->
												<li
													class="page-item first ${pi.currentPage == 1 ? 'disabled' : ''}">
													<a class="page-link" href="#"
													onclick="goToPage(1);"> <i
														class="ti ti-chevrons-left ti-sm"></i>
												</a>
												</li>

												<!-- 이전 페이지로 이동 -->
												<li
													class="page-item prev ${pi.currentPage == 1 ? 'disabled' : ''}">
													<a class="page-link" href="${contextPath }/supply/list.do?page=${pi.currentPage-1}"> 
													<i class="ti ti-chevron-left ti-sm"></i>
												</a>
												</li>

												<!-- 페이지 번호 출력 -->
												<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
													<li class="page-item ${pi.currentPage == i ? 'active' : '' }">
														<a class="page-link" href="${contextPath }/supply/list.do?page=${i}">${i}</a>
													</li>
												</c:forEach>

												<!-- 다음 페이지로 이동 -->
												<li
													class="page-item prev ${pi.currentPage == 1 ? 'disabled' : ''}">
													<a class="page-link" href="${contextPath }/supply/list.do?page=${pi.currentPage+1}"> 
													<i class="ti ti-chevron-right ti-sm"></i>
												</a>
												</li>

												<!-- 마지막 페이지로 이동 -->
												<li
													class="page-item last ${pi.currentPage == pi.maxPage ? 'disabled' : ''}">
													<a class="page-link" href="#"
													onclick="goToPage(${pi.maxPage});"> <i
														class="ti ti-chevrons-right ti-sm"></i>
												</a>
												</li>
											</ul> 
											*/
											
											
							
					<!--/페이징바-->
					  
					  
					  
					  
					  
				  }
			  }) 
	  } 
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	   // 사이드바 처리
		document.addEventListener("DOMContentLoaded", function () {
	  	
			const element = document.getElementById("itemsAll");
			
	  	document.getElementById("items").classList.add("open");
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